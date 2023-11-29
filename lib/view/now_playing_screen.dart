import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_flix/controller/movies_controller.dart';
import 'package:movie_flix/model/now_playing_model.dart';
import 'package:movie_flix/view/movie_details_screen.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MoviesController());
    var showCancel = false.obs;
    final TextEditingController searchController = TextEditingController();

    var val="".obs;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child:
          AppBar(
            title: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(() => CupertinoTextField(
                controller: searchController,
                onChanged: (value) {
                  controller.searchMovies(value,true);
                  showCancel.value = value.isNotEmpty;
                },
                onTap: () {
                  showCancel.value = searchController.text.isNotEmpty;
                },
                placeholder: 'Search...',
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.placeholderText,

                  ),
                ),
                suffix: showCancel.value
                    ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    controller.searchMovies('',true);
                    showCancel.value = false;
                  },
                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    color: CupertinoColors.activeBlue,
                  ),
                )
                    : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: CupertinoColors.lightBackgroundGray,
                ),
              )),
            ),
            actions: [
              Obx(() => showCancel.value
                  ? CupertinoButton(
                onPressed: () {
                  searchController.clear();
                  controller.searchMovies('',true);
                  showCancel.value = false;
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 16,
                  ),
                ),
              )
                  : SizedBox(),
              ),
            ],
          ),
          ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CupertinoActivityIndicator())
                  : RefreshIndicator(
                    onRefresh: ()=>controller.getAllNowPlayingList(),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.searchResult.isNotEmpty
                            ? controller.searchResult.length
                            : controller.nowPlayingMovieList.length,
                        itemBuilder: (ctx, index) {
                          var i = controller.searchResult.isNotEmpty
                              ? controller.searchResult[index]
                              : controller.nowPlayingMovieList[index];
                          return Dismissible(
                            key: Key(i.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              // Remove the item from the list
                              controller.deleteItem(i.id.toString(),true); // Implement this method in your controller
                              // Show a snackbar or any other action upon deletion if needed
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text("${i.originalTitle} deleted"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: InkWell(
                              onTap: () {
                                Get.to(MovieDetails(index: index,movie: true,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: Image.network("https://image.tmdb.org/t/p/w342${i.backdropPath}",height: 150,width: 100,fit: BoxFit.cover,)),
                                      const SizedBox(width: 10,),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("${i.originalTitle}",style: TextStyle(fontWeight:FontWeight.bold,fontSize:20),),
                                            const SizedBox(height: 20,),
                                            Text("${i.overview}",style:TextStyle(fontSize:15),
                                                maxLines: 4, overflow: TextOverflow.ellipsis),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

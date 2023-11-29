import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/controller/movies_controller.dart';
class MovieDetails extends StatelessWidget {
  final int index;
  final bool movie;
  const MovieDetails({super.key, required this.index, required this.movie});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<MoviesController>();
    return Scaffold(

      appBar: AppBar(),
      body: movie==true?Stack(
        fit: StackFit.loose,
        children: [
          // Full-screen image
          Image.network(
            "https://image.tmdb.org/t/p/original${controller.nowPlayingMovieList[index].backdropPath}",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Details Container
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "movie.originalTitle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "movie.overview",
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add other details as needed
                ],
              ),
            ),
          ),
        ],
      ):Stack(
        fit: StackFit.loose,
        children: [
          // Full-screen image
          Image.network(
            "https://image.tmdb.org/t/p/original${controller.topRatedMovieList[index].backdropPath}",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Details Container
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "movie.originalTitle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "movie.overview",
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add other details as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

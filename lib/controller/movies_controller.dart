import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/model/now_playing_model.dart';
import 'package:movie_flix/model/top_rated_model.dart';
import 'package:movie_flix/services/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MoviesController extends GetxController{
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getAllNowPlayingList();
    getTopRatedList();
    super.onInit();
  }
//now playing
  var nowPlayingMovieList=<NowPlayingModel>[].obs;
  Future<void> getAllNowPlayingList() async{
    isLoading.value=true;
    nowPlayingMovieList.clear();
    var headers={'Content-Type':'application/json'};
    try{
      var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.nowPlayingEndPoints.nowPlaying);
      print("call Url -> :: $url");
      HttpClient client = HttpClient()..badCertificateCallback = (cert, host, port) => true;
      http.Response response=await http.get(url,headers: headers);
      if(response.statusCode==200){
        final json=jsonDecode(response.body);
       if(json["results"] is Iterable){
         for(var i in json["results"]){
           nowPlayingMovieList.add(NowPlayingModel.fromJson(i));

         }
       }
       print("now playing: ${nowPlayingMovieList[0].posterPath}");
      }

      else{
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }
    }
    catch(error){
      showDialog(context: Get.context!, builder: (context){
        return SimpleDialog(
          title: const Text("Error"),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Text(error.toString())
          ],
        );
      });
    }
    finally{
      isLoading(false);
    }
  }

  //top rated
  var topRatedMovieList=<TopRatedModel>[].obs;
  Future<void> getTopRatedList() async{
    isLoading.value=true;
    topRatedMovieList.clear();
    var headers={'Content-Type':'application/json'};
    try{
      var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.topRated.topRated);
      print("call Url -> :: $url");
      HttpClient client = HttpClient()..badCertificateCallback = (cert, host, port) => true;
      http.Response response=await http.get(url,headers: headers);
      if(response.statusCode==200){
        final json=jsonDecode(response.body);
        if(json["results"] is Iterable){
          for(var i in json["results"]){
            topRatedMovieList.add(TopRatedModel.fromJson(i));

          }
        }
        print("now playing: ${topRatedMovieList[0].posterPath}");
      }

      else{
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }
    }
    catch(error){
      // refreshToken();
      showDialog(context: Get.context!, builder: (context){
        return SimpleDialog(
          title: const Text("Error"),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Text(error.toString())
          ],
        );
      });
    }
    finally{
      isLoading(false);
    }
  }

  var searchResult = <NowPlayingModel>[].obs;
  var searchTopRatedResult=<TopRatedModel>[].obs;
// Search function
  void searchMovies(String query, bool movie) {
    if (query.isEmpty) {
      //if query is empty show all items
      movie==true?searchResult.assignAll(nowPlayingMovieList):searchTopRatedResult.assignAll(topRatedMovieList);
    } else {
      movie==true?searchResult.assignAll(nowPlayingMovieList.where((movie) =>
      movie.title?.toLowerCase().contains(query.toLowerCase()) ?? false)):searchTopRatedResult.assignAll(topRatedMovieList.where((movie) =>
      movie.title?.toLowerCase().contains(query.toLowerCase()) ?? false));
    }
  }

  // Method to delete an item by ID from nowPlayingMovieList
  void deleteItem(String itemId,bool movie) {
    movie==true?topRatedMovieList.removeWhere((item) => item.id.toString()==itemId):nowPlayingMovieList.removeWhere((item) => item.id.toString()==itemId);
    // Replace 'id' with the identifier used in your NowPlayingModel class
  }

}
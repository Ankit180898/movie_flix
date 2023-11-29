import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/view/now_playing_screen.dart';
import 'package:movie_flix/view/top_rated_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffe8bc6d),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.black),
          color: Color(0xffe8bc6d), //<-- SEE HERE
        ),
      ),
      home:const NowPlayingScreen(),
    );
  }
}

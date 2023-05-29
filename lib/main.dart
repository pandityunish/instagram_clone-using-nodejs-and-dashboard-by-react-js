import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:instagramclone/common/constant/color.dart';
import 'package:instagramclone/common/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: kbgcolor
        ),
       scaffoldBackgroundColor:const Color.fromARGB(255, 245, 245, 245)
      ),
      
      home:const SplashScreen(),
    );
  }
}


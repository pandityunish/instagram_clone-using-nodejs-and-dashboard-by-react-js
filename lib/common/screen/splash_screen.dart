import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/screen/custom_bottom_navigationbar.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/auth/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../constant/global.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthRepository repository = Get.put(AuthRepository());
  String email = "";
  void getemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      email = preferences.getString("email") ?? "";
    });
  }
Future<void> getuserdata({required BuildContext context,required email})async{
try {
 
  http.Response res=await http.post(Uri.parse("$url/getuserdata"),
  headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
  body: jsonEncode({
    "email":email
  },)

  );
  if(context.mounted){
 handleerror(res: res, callback: () {
   print(res.body);
   repository. addduserdata(Usermodel.fromJson(res.body));
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const CustomBotttomNavigationBar(),), (route) => false);
             print(res.body);

  }, context: context);
  } 

 
  
} catch (e) {
  showsnackbar(context, e.toString());
}
  }
  @override
  void initState() {
    getemail();

    Timer(const Duration(seconds: 2), () {
      
      if (email.isEmpty) {
            
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const LoginScreen(),), (route) => false);
       
      } else {
        getuserdata(context: context, email: email);
        
       
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/instagram.png",
          height: 80,
        ),
      ),
    );
  }
}

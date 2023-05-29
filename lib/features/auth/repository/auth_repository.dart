import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/common/screen/custom_bottom_navigationbar.dart';
import 'package:instagramclone/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends GetxController{
 final userdata=Rxn<Usermodel>();
  void addduserdata(Usermodel usermodel){
    userdata.value=Usermodel(name: usermodel.name,
     id: usermodel.id, email: usermodel.email,
      image:usermodel. image,
      followers: usermodel.followers,
      following: usermodel.following);
  }
  void setemail(String email)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("email", email);
  }
  void loginuser({required BuildContext context,required String email,required String password})async{
    try {
      showLoading();
      await http.post(Uri.parse("$url/loginuser"),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },body: jsonEncode({
      "email":email,
      "password":password
      }))
      .then((res) {
    
        return  handleerror(res: res, callback: () {
          setemail(email);
          hideLoading();
       showsnackbar(context, "Login successfully");
         getuserdata(context: context, email: email).whenComplete(() {
          Get.offAll(const CustomBotttomNavigationBar());
});
     }, context: context);
      });
    
    } catch (e) {
      hideLoading();
      print(e.toString());
      showsnackbar(context, e.toString());
    }
  }
  void createuser({required BuildContext context,required String name,required String email,required String password})async{
    try {
      showLoading();
      await http.post(Uri.parse("$url/createuser"),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },body: jsonEncode({
        "name":name,
      "email":email,
      "password":password,
      "image":"",
      "following":[],
      "followers":[]
      }))
      .then((res) {
    
        return  handleerror(res: res, callback: () {
          setemail(email);
          hideLoading();
       showsnackbar(context, "Create account successfully");
     getuserdata(context: context, email: email).whenComplete(() {
      Get.offAll(const CustomBotttomNavigationBar());
        });
     }, context: context);
      });
    
    } catch (e) {
      hideLoading();
      showsnackbar(context, e.toString());
    }
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
   
    addduserdata(Usermodel.fromJson(res.body));
  }, context: context);
  }

} catch (e) {
  showsnackbar(context, e.toString());
}
  }
  Future<List<Usermodel>> getallusers({required BuildContext context})async{
    List<Usermodel> users=[];
    try {
      http.Response res=await http.get(Uri.parse("$url/getalluser"));
      if(context.mounted){
 handleerror(res: res, callback: () {
        for(int i=0;i<jsonDecode(res.body).length; i++){
          users.add(Usermodel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }, context: context);
      }
     
      
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return users;
  }
}
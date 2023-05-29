import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:instagramclone/models/user_model.dart';

class ProfileRepository extends GetxController{
  RxList followers=[].obs;
RxBool isfollow=false.obs;
void addfollowers(String userid){
  followers.add(userid);

}
void followoperator(){
if (isfollow.isFalse) {
  isfollow.value = true;
}
}
  Future<List<PostModel>> getuserposts({required BuildContext context,required String userid})async{
    List<PostModel> posts=[];
    try {
       http.Response res=await http.post(Uri.parse("$url/getuserposts"),
     headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "userid":userid
              })
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        
        for(int i=0; i<jsonDecode(res.body).length;i++){
         posts.add( PostModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }, context: context);}
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return posts;
  }
  void updateuserpost({required XFile userimage,required String username,
  required String userid,required BuildContext context})async{
    try {
      showLoading();
      AuthRepository repository=Get.put(AuthRepository());
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
      CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(userimage.path,
             folder: username));
        String uploadedvideo = response.secureUrl;
        repository.userdata.value!.image=uploadedvideo;
      http.Response res=await http.post(Uri.parse("$url/updateuserprofile"),
      body: jsonEncode({
        "userid":userid,
        "userimage":uploadedvideo
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        hideLoading();
      }, context: context);
      }

    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
  void deletuserprofile({required String username,
  required String userid,required BuildContext context})async{
    try {
      showLoading();
      AuthRepository repository=Get.put(AuthRepository());
      
        repository.userdata.value!.image="";
      http.Response res=await http.post(Uri.parse("$url/removeuserprofile"),
      body: jsonEncode({
        "userid":userid,
        
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        hideLoading();
      }, context: context);}

    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
   Future<Usermodel> getuserdataalter({required BuildContext context,required email})async{
      Usermodel usermodel=Usermodel(name: "", id: "", email: email, image: "",followers: [],following: []);

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
   usermodel=Usermodel.fromJson(res.body);
  }, context: context);}
} catch (e) {
  showsnackbar(context, e.toString());
}
return usermodel;
  }
  void followuser({required String followid,required String userid,required BuildContext context})async{
    try {
      isfollow = true.obs;
      http.Response res=await http.post(Uri.parse("$url/follow"),
      body: jsonEncode({
        "followid":followid,
        "userid":userid,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        
      }, context: context);
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
   void unfollowuser({required String followid,required String userid,required BuildContext context})async{
    try {
      isfollow = false.obs;
      http.Response res=await http.post(Uri.parse("$url/unfollow"),
      body: jsonEncode({
        "followid":followid,
        "userid":userid,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
       
      }, context: context);}
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
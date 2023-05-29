import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:instagramclone/models/stories_model.dart';
class HomeRepository extends GetxController{
  RxList likes=[].obs;
  void addalllikes(List like){
likes.addAll(like);
  }
  Future< List<PostModel>> getallposts({required BuildContext context})async{
    List<PostModel> posts=[];
    try {

      http.Response res=await http.get(Uri.parse("$url/getposts"),
     headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
      );
      if(context.mounted){
      handleerror(res: res, callback: () {

        for(int i=0; i<jsonDecode(res.body).length;i++){
         posts.add( PostModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }, context: context);
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
     return posts;
  }
 void removelikes({required String postid,required String userid,required BuildContext context})async{
    try {
      http.Response res=await http.post(Uri.parse("$url/removelikes"),
      body: jsonEncode({
        "postid":postid,
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
  void addcomments({required String postid,required String userimage,required String username,
  required String userid,required BuildContext context,required String title})async{
    try {
      http.Response res=await http.post(Uri.parse("$url/addcomment"),
      body: jsonEncode({
        "postid":postid,
        "userid":userid,
        "title":title,
        "userimage":userimage,
        "username":username
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
  Future<List<StoriesModel>> getallstories({required BuildContext context})async{
    List<StoriesModel> stories=[];
    try {
      http.Response res=await http.get(Uri.parse("$url/getallstories"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          stories.add(StoriesModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }, context: context);
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return stories;
  }
  void poststories({required BuildContext context,required String username,required String userimage,
  required String useremail,
  required String userid,required XFile images})async{
    try {
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
       CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images.path, folder: username));
        String uploadedvideo = response.secureUrl;
        List image=[];
        image.add(uploadedvideo);
        StoriesModel storiesModel=StoriesModel(useremail: useremail,
         username: username, userimage: userimage,userid: userid,
          images: image);
      http.Response res=await http.post(Uri.parse("$url/poststories"),
      headers: {
         'Content-Type': 'application/json; charset=UTF-8',
      },
      body: storiesModel.toJson()
      );
      if(context.mounted){
      handleerror(res: res, callback: () {
        showsnackbar(context, "Story uploaded successfully");
        Navigator.pop(context);
      }, context: context);
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
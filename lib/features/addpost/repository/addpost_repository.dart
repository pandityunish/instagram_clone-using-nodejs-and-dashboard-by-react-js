import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:http/http.dart' as http;
import 'package:instagramclone/models/post_model.dart';

class AddRepository extends GetxController {
  void addpost(
      {required BuildContext context,
      required String? video,
      List<XFile>? images,
      required String username,
      required String title,
      required String userid,
      required String userimage,
      required String useremail
      }) async {
    try {
      showLoading();
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
      List uploadedimages = [];
      if (images!.isEmpty) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(video!, folder: username));
        String uploadedvideo = response.secureUrl;
        PostModel postModel = PostModel(
            title: title,
            video: uploadedvideo,
            images: [],
            likes: [],
            userimage: userimage,
            username: username,
            userid: userid,
            date: '',
            comment: [],
            postid: '',
            useremail: useremail
            );
        http.Response res = await http.post(
            Uri.parse(
              "$url/post",
            ),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: postModel.toJson());
        hideLoading();
        if (context.mounted) {}else{
        handleerror(
            res: res,
            callback: () {
                title="";
                video=null;
              showsnackbar(context, "Post uploaded Succssfully");
            },
            context: context);
        }
      } else {
        for (int i = 0; i < images.length; i++) {
          CloudinaryResponse response = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(images[i].path, folder: username));
          uploadedimages.add(response.secureUrl);
          
        }
        PostModel postModel = PostModel(
              title: title,
              video: "",
              images: uploadedimages,
              likes: [],
              userimage: userimage,
              username: username,
              userid: userid,
              comment: [],
              postid: '',
              date: '',
              useremail: useremail
              );
          http.Response res = await http.post(
              Uri.parse(
                "$url/post",
              ),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: postModel.toJson());
              hideLoading();
          if (context.mounted) {}else{
          handleerror(
              res: res,
              callback: () {
                images.length=0;
                title="";

                showsnackbar(context, "Post uploaded Succssfully");
              },
              context: context);}
      }
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
  void addlikes({required String postid,required String userid,required BuildContext context})async{
    try {
      http.Response res=await http.post(Uri.parse("$url/addlikes"),
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
}

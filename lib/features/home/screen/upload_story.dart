import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';


class UploadStory extends StatelessWidget {
  final XFile image;
  const UploadStory({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    HomeRepository homeRepository=Get.put(HomeRepository());
    AuthRepository authRepository=Get.put(AuthRepository());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(File(image.path)),fit: BoxFit.cover)
            ),
          ),
          Positioned(
            top: Get.height*0.07,
            left: 10,
            child:const Row(
            children: [
              Icon(Icons.clear,color: Colors.white,size: 30,)
            ],
          )),
          Positioned(
            bottom: Get.height*0.04,
            left: Get.width*0.3,
            child: InkWell(
              onTap: () {
                homeRepository.
                poststories(context: context,
                 username: authRepository.userdata.value!.name, 
                 userimage: authRepository.userdata.value!.image.isEmpty?userurl:authRepository.userdata.value!.image,
                  useremail: authRepository.userdata.value!.email,
                   userid: authRepository.userdata.value!.id,
                    images: image);
              },
              child:const Row(
            
              children: [
            
                Icon(Icons.add_circle_outline_outlined,color: Colors.white,),
                SizedBox(width: 5,),
                Text("Add to your story",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
                      ),
            ))
        ],
      ),
    );
  }
}
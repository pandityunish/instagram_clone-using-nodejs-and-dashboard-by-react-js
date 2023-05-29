import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/features/home/widget/post_card.dart';
import 'package:instagramclone/features/profile/repository/profile_repository.dart';

class UsersallPosts extends StatelessWidget {
  final String userid;
  const UsersallPosts({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    ProfileRepository profileRepository=Get.put(ProfileRepository());
    return FutureBuilder(
      future: profileRepository.getuserposts(context: context, userid: userid),
      builder:(context, snapshot) {
         if(snapshot.connectionState==ConnectionState.waiting){
              return const Center();
            } if(snapshot.data!.isEmpty){
              return const Center(
                child: Text("No Posts"),
              );
            }
            else{
        return ListView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
       
          itemBuilder: (context, index) {
          return PostCard(postModel: snapshot.data![index]);
        },);
        }
      }, );
  }
}
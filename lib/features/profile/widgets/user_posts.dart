import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/features/profile/repository/profile_repository.dart';

class UsersPostsSection extends StatelessWidget {
  final String userid;
  const UsersPostsSection({super.key, required this.userid});

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
        return GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1,crossAxisSpacing: 2,mainAxisSpacing: 2),
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          
          return snapshot.data![index].images.isNotEmpty? Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(snapshot.data![index].images[0]),fit: BoxFit.cover)
            ),
          ):Container();
            
        },);}
      }, );
  }
}
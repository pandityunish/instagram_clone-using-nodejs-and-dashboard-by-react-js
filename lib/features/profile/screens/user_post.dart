import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/profile/repository/profile_repository.dart';

class UserPosts extends StatelessWidget {

  const UserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileRepository repository=Get.put(ProfileRepository());
    AuthRepository authRepository=Get.put(AuthRepository());
    return FutureBuilder(
      future: repository.getuserposts(context: context, 
      userid: authRepository.userdata.value!.id),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
              return const Center();
            } if(snapshot.data!.isEmpty){
              return const Center(
                child: Text("No Posts"),
              );
            }
            
            else{
        return GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1,crossAxisSpacing: 3,mainAxisSpacing: 3),
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          
          return snapshot.data![index].images.isNotEmpty? Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(snapshot.data![index].images[0]),fit: BoxFit.cover)
            ),
          ):Container();
            
        },);}
      }
    );
  }
}
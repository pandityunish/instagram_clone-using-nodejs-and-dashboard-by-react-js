import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';
import 'package:instagramclone/features/home/screen/stories_screen.dart';
import 'package:instagramclone/features/home/screen/upload_story.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  XFile? pickimage;
  void selectimage()async{
  final image=await ImagePicker().pickImage(source: ImageSource.gallery);
  setState(() {
    pickimage=image;
  });
  if(pickimage!=null){
    Get.to(UploadStory(image: pickimage!,));
  }
  }
  @override
  Widget build(BuildContext context) {
    HomeRepository repository = Get.put(HomeRepository());
    AuthRepository authRepository=Get.put(AuthRepository());
    return SizedBox(
      height: Get.height * 0.15,
      width: Get.width,
      child: FutureBuilder(
          future: repository.getallstories(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center();
            } else {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        selectimage();
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 70,
                                width: Get.width * 0.2,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    
                                    border: Border.all(
                                        width: 1,
                                        color:const  Color.fromARGB(255, 219, 219, 219)),
                                    image: DecorationImage(
                                      image:authRepository.userdata.value!.image.isEmpty?const NetworkImage(userurl): NetworkImage(authRepository.userdata.value!.image),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue
                                ),
                                  child:const Center(child: Icon(Icons.add,color: Colors.white,size: 15,)))),
                             
                            ],
                          ),
                           const SizedBox(
                                  height: 5,
                                ),
                            const Text("Your Story")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(StoryScreen(
                                      story: snapshot.data![index]));
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2,
                                          color: const Color.fromARGB(
                                              255, 233, 30, 47)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data![index].userimage),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(snapshot.data![index].username)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

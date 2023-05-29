import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/features/addpost/repository/addpost_repository.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/auth/widget/custom_buttom.dart';
import 'package:video_player/video_player.dart';

class AddScreens extends StatefulWidget {
  const AddScreens({super.key});

  @override
  State<AddScreens> createState() => _AddScreensState();
}

class _AddScreensState extends State<AddScreens> {
  final TextEditingController titleController = TextEditingController();
  List<XFile> images = [];
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  AddRepository repository = Get.put(AddRepository());
  AuthRepository repository1 = Get.put(AuthRepository());
  XFile? video;
  void pickimages() async {
    final XFile? picker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    images.add(picker!);
    setState(() {});
  }

  void pickvideo() async {
    final XFile? picker =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      video = picker;
    });
    _controller = VideoPlayerController.file(File(video!.path))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
        );
      });
  }

 

  void showbottombar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    pickimages();
                    Navigator.pop(context);
                  },
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(
                        Icons.photo,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    pickvideo();
                    Navigator.pop(context);
                  },
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(
                        Icons.video_call_sharp,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Video",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Post",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          images.isNotEmpty
              ? Row(
                  children: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          onTap: () {
                            Future(() {
                              images.clear();
                              setState(() {});
                            });
                          },
                          child: const Text('Remove images'),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
          video != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          onTap: () {
                            Future(() {

                              setState(() {
                                video = null;
                              });
                            });
                          },
                          child: const Text('Remove video'),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            images.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        showbottombar();
                      },
                      child: video == null
                          ? Container(
                              height: 200,
                              width: Get.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: const Center(
                                child: Icon(Icons.add),
                              ),
                            )
                          : Container(),
                    ),
                  )
                : SizedBox(
                    height: 250,
                    width: Get.width,
                    child: CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(images[index].path)),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.4,
                        aspectRatio: 20 / 8,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 7),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 2000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    )),
            const SizedBox(
              height: 20,
            ),
            video != null
                ? _controller.value.isInitialized
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: Chewie(
                                controller: chewieController,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
                : Container(),
            video != null
                ? InkWell(
                    onTap: () {
                      pickvideo();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.black)),
                      child:const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              "Take another video",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 0,
                  ),
            images.isNotEmpty
                ? InkWell(
                    onTap: () {
                      pickimages();
                    },
                    child: Container(
                      height: 60,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.black)),
                      child:const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              "Add other photo",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 0,
                  ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: TextFormField(
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  controller: titleController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.4, color: Colors.black)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomButton(
              text: "Post",
              onclick: () {
                
                if (video == null) {
                  repository.addpost(
                      context: context,
                      video: "",
                      images: images,
                      useremail: repository1.userdata.value!.email,
                      username: repository1.userdata.value!.name,
                      title: titleController.text,
                      userid: repository1.userdata.value!.id,
                      userimage: repository1.userdata.value!.image.isEmpty
                          ? "https://images.unsplash.com/photo-1682547095016-c9cfee414163?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
                          : repository1.userdata.value!.image);
                } else {
                  repository.addpost(
                      context: context,
                      video: video!.path,
                      useremail: repository1.userdata.value!.email,
                      images: images,
                      username: repository1.userdata.value!.name,
                      title: titleController.text,
                      userid: repository1.userdata.value!.id,
                      userimage: repository1.userdata.value!.image.isEmpty
                          ? "https://images.unsplash.com/photo-1682547095016-c9cfee414163?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
                          : repository1.userdata.value!.image);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

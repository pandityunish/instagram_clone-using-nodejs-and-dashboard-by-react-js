import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/features/addpost/repository/addpost_repository.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';
import 'package:instagramclone/features/home/screen/comment_screen.dart';
import 'package:instagramclone/features/profile/screens/alter_profile.dart';
import 'package:instagramclone/features/profile/screens/profile_screen.dart';
import 'package:instagramclone/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;
  const PostCard({super.key, required this.postModel});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  AddRepository repository = Get.put(AddRepository());
  AuthRepository authRepository = Get.put(AuthRepository());
  HomeRepository homeRepository = Get.put(HomeRepository());
  List likes=[];
  @override
  void initState() {
    likes.addAll(widget.postModel.likes);
   
    _controller = VideoPlayerController.network(widget.postModel.video)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: false,
          looping: true,
        );
      });
    super.initState();
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(widget.postModel.date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if(authRepository.userdata.value!.id==widget.postModel.userid){
               Get.to(const ProfileScreen());
                  }else{
                   Get.to(AlterProfileScreen(email: widget.postModel.useremail,
                   name: widget.postModel.username));
                  }
                 
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.postModel.userimage),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.postModel.username,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          widget.postModel.images.isNotEmpty
              ? Stack(
                  children: [
                    SizedBox(
                        width: Get.width,
                        child: CarouselSlider.builder(
                          itemCount: widget.postModel.images.length,
                          itemBuilder: (context, index, realIndex) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                     if (likes
                            .contains(authRepository.userdata.value!.id)) {
                          likes
                              .remove(authRepository.userdata.value!.id);
                              setState(() {
                                
                              });
                              homeRepository.removelikes(  postid: widget.postModel.postid,
                              userid: authRepository.userdata.value!.id,
                              context: context);
                        } else {
                          likes
                              .add(authRepository.userdata.value!.id);
                              setState(() {
                                
                              });
                          repository.addlikes(
                              postid: widget.postModel.postid,
                              userid: authRepository.userdata.value!.id,
                              context: context);
                              setState(() {
                                
                              });
                        }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.postModel.images[index],
                                      fadeInCurve: Curves.bounceOut,
                                      fit: BoxFit.cover,
                                      fadeInDuration: const Duration(seconds: 2),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Container(
                                        height: 300,
                                        color: const Color.fromARGB(
                                            255, 228, 227, 227),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.5,
                            aspectRatio: 20 / 8,
                            viewportFraction: 1,
                            scrollPhysics: const BouncingScrollPhysics(),
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 7),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 2000),
                            onPageChanged: (index, reason) {
                              setState(() {
                                i = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        )),
                    widget.postModel.images.length > 1
                        ? Positioned(
                            bottom: 20,
                            right: Get.width * 0.45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.postModel.images.length,
                                (index1) =>
                                    buildDot(index: index1, selectedindex: i),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              : _controller.value.isInitialized
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
                  : Container(),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (likes
                            .contains(authRepository.userdata.value!.id)) {
                          likes
                              .remove(authRepository.userdata.value!.id);
                              setState(() {
                                
                              });
                              homeRepository.removelikes(  postid: widget.postModel.postid,
                              userid: authRepository.userdata.value!.id,
                              context: context);
                        } else {
                          likes
                              .add(authRepository.userdata.value!.id);
                              setState(() {
                                
                              });
                          repository.addlikes(
                              postid: widget.postModel.postid,
                              userid: authRepository.userdata.value!.id,
                              context: context);
                              setState(() {
                                
                              });
                        }
                      },
                      icon:likes
                              .contains(authRepository.userdata.value!.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_outline) ) ,
                  IconButton(onPressed: () {
                    Get.to( CommentScreen(model: widget.postModel,));
                  }, icon: const Icon(Icons.comment)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_rounded,
                    size: 30,
                  ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:  Text(
                  "${likes.length} likes",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: widget.postModel.username.toLowerCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' ${widget.postModel.title}',
                  ),
                ],
              ),
            ),
          ),
          //  Padding(
          //    padding: const EdgeInsets.all(8.0),
          //    child: Wrap(
          //     children: [
          //   //    Text(widget.postModel.username.toLowerCase(),style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
          //     Text.(TextSpan()),
          //      const SizedBox(width: 5,),
          //       Text("${widget.postModel.title} ")
          //     ],
          //    ),
          //  ),
          widget.postModel.comment!.isNotEmpty? Padding(
            padding:const EdgeInsets.all(8.0),
            child: Text(
              "View all ${widget.postModel.comment!.length} comments",
              style:const TextStyle(color: Colors.grey),
            ),
          ):Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              timeago.format(
                dt,
                allowFromNow: true,
              ),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index, required int selectedindex}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 10),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: selectedindex == index ? Colors.white : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

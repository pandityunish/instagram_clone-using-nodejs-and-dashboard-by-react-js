import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';
import 'package:instagramclone/models/comment_model.dart';
import 'package:instagramclone/models/post_model.dart';

class CommentScreen extends StatefulWidget {
  final PostModel model;
  const CommentScreen({super.key, required this.model});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final commentController=TextEditingController();
  AuthRepository repository=Get.put( AuthRepository());
  HomeRepository homeRepository=Get.put(HomeRepository());
  List<CommentModel> comment=[];
@override
  void initState() {
    comment.addAll(widget.model.comment!);
    super.initState();
  }

  @override
  void dispose() {
  commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
         Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back)),
        centerTitle: true,
        title:const Text("Comments",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: () {
            
          }, icon:const Icon(Icons.send))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) =>  CommentScreen(model: widget.model),
                  transitionDuration: const Duration(seconds: 0)));
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                width: Get.width,
                color:const Color.fromARGB(255, 196, 194, 194),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        backgroundImage:repository.userdata.value!.image.isEmpty?const NetworkImage(userurl):NetworkImage(repository.userdata.value!.image),
                      ),
                       Container(
                  height: 48,
                  width: Get.width*0.8,
                             decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30)
                             ),
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      suffixIcon: TextButton(onPressed: () {
                        comment.add(CommentModel(userimage: repository.userdata.value!.image.isEmpty
                         ?userurl:repository.userdata.value!.image,
                          username: repository.userdata.value!.name,
                          userid: repository.userdata.value!.id,
                            title: commentController.text.trim()));
                            setState(() {
                              
                            });
                        homeRepository.addcomments(
                          postid: widget.model.postid,
                         userimage: repository.userdata.value!.image.isEmpty
                         ?userurl:repository.userdata.value!.image,
                          username: repository.userdata.value!.name,
                          userid: repository.userdata.value!.id,
                           context: context, title: commentController.text.trim());
                           commentController.clear();
                      }, child:const Text("Post",style: TextStyle(color: Colors.blue),)),
                      contentPadding:const EdgeInsets.all(10),
                      hintText: "Add a comment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                  ),
                            )
                    ],
                  ),
                ),
              ),
             ListView.builder(
              itemCount: comment.length,
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
               if(comment.isEmpty){
                 return const Center(
                  child: Text("No Comment"),
                 );
               }else{
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(comment[index].userimage),
                  ),
                  title: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: comment[index].username.toLowerCase(),style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      TextSpan(text: " ${comment[index].title}",style:const TextStyle(color: Colors.black,))
                    ]
                  )),
                  subtitle:const Row(
                    children: [
                       Text("1h",style: TextStyle(fontSize: 13),),
                      SizedBox(width: 10,),
                      Text("Reply",style: TextStyle(fontSize: 13),)
                    ],
                  ),
                  trailing: IconButton(onPressed: () {
                    
                  }, icon:const Icon(Icons.favorite_outline,size: 20,)),
                );
               }
             },)
            ],
          ),
        ),
      ),
    );
  }
}
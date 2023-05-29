import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/color.dart';
import 'package:instagramclone/common/screen/custom_bottom_navigationbar.dart';
import 'package:instagramclone/features/addpost/screens/add_screens.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';
import 'package:instagramclone/features/home/widget/post_card.dart';
import 'package:instagramclone/features/home/widget/stories.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeRepository repository = Get.put(HomeRepository());

  @override
  void initState() {
    repository.getallposts(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          height: 45,
        ),
        centerTitle: false,
        actions: [
           IconButton(
              onPressed: () async {
              Get.to(const AddScreens());
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
         
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) =>const CustomBotttomNavigationBar(),
                  transitionDuration: const Duration(seconds: 2)));
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
            const  Stories(),
              FutureBuilder(
                future: repository.getallposts(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                      return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Shimmer(
                gradient:const LinearGradient(colors: [
              ksimmeracolor,
               Colors.white
                ]),
                    child: Container(
                     width: Get.width,
                     height: Get.height*0.4,
                      color: ksimmeracolor,
                    ),
                  ),
              );
                    },);
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PostCard(
                          postModel: snapshot.data![index],
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

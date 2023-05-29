import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/profile/repository/profile_repository.dart';
import 'package:instagramclone/features/profile/widgets/alluserposts.dart';
import 'package:instagramclone/features/profile/widgets/user_posts.dart';

import '../../../common/constant/global.dart';

class AlterProfileScreen extends StatefulWidget {
  final String email;
  final String name;

  const AlterProfileScreen(
      {super.key, required this.email, required this.name});

  @override
  State<AlterProfileScreen> createState() => _AlterProfileScreenState();
}

class _AlterProfileScreenState extends State<AlterProfileScreen> {
  ProfileRepository profileRepository = Get.put(ProfileRepository());
  AuthRepository authRepository = Get.put(AuthRepository());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return profileRepository.getuserdataalter(
                context: context, email: widget.email);
          },
          child: FutureBuilder(
              future: profileRepository.getuserdataalter(
                  context: context, email: widget.email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage: snapshot.data!.image.isEmpty
                                      ? const NetworkImage(userurl)
                                      : NetworkImage(snapshot.data!.image),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.07,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data!.name.toLowerCase(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_horiz))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              elevation: 0,
                                              backgroundColor: authRepository
                                                          .userdata
                                                          .value!
                                                          .following
                                                          .contains(snapshot
                                                              .data!.id) ||
                                                      profileRepository
                                                              .isfollow.value ==
                                                          true
                                                  ? const Color.fromARGB(
                                                      255, 218, 217, 217)
                                                  : Colors.blue,
                                              minimumSize:
                                                  Size(Get.width * 0.25, 35)),
                                          onPressed: () {
                                            profileRepository.followoperator();
                                            if (authRepository
                                                .userdata.value!.following
                                                .contains(snapshot.data!.id)) {
                                              profileRepository.unfollowuser(
                                                  followid: snapshot.data!.id,
                                                  userid: authRepository
                                                      .userdata.value!.id,
                                                  context: context);
                                              authRepository
                                                  .userdata.value!.following
                                                  .remove(snapshot.data!.id);
                                            } else {
                                              authRepository
                                                  .userdata.value!.following
                                                  .add(snapshot.data!.id);
                                              profileRepository.followuser(
                                                  followid: snapshot.data!.id,
                                                  userid: authRepository
                                                      .userdata.value!.id,
                                                  context: context);
                                              profileRepository
                                                  .getuserdataalter(
                                                      context: context,
                                                      email: widget.email);
                                            }
                                          },
                                          child: Obx(() => Text(
                                                authRepository.userdata.value!
                                                            .following
                                                            .contains(snapshot
                                                                .data!.id) ||
                                                        profileRepository
                                                                .isfollow
                                                                .value ==
                                                            true
                                                    ? "Following"
                                                    : "Follow",
                                                style: TextStyle(
                                                    color: authRepository
                                                                .userdata
                                                                .value!
                                                                .following
                                                                .contains(
                                                                    snapshot
                                                                        .data!
                                                                        .id) ||
                                                            profileRepository
                                                                    .isfollow
                                                                    .value ==
                                                                true
                                                        ? Colors.black
                                                        : Colors.white),
                                              )))),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Obx(() => authRepository
                                                  .userdata.value!.following
                                                  .contains(
                                                      snapshot.data!.id) ||
                                              profileRepository.isfollow.value ==
                                                  true
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  elevation: 0,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 218, 217, 217),
                                                  minimumSize:
                                                      Size(Get.width * 0.25, 35)),
                                              onPressed: () {},
                                              child: const Text(
                                                "Message",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ))
                                          : Container()),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 218, 217, 217),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Icon(Icons.person_add_alt),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             const Column(
                                children: [
                                  Text(
                                    "0",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Posts")
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data!.followers.length.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("Followers")
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data!.following.length.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("Following")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const TabBar(
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor:
                                  Color.fromARGB(255, 243, 243, 243),
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    Icons.grid_on_outlined,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(Icons.view_day_outlined),
                                ),
                                Tab(
                                  icon: Icon(Icons.person_pin_outlined),
                                )
                              ]),
                          SizedBox(
                            height: Get.height * 0.5,
                            child: TabBarView(children: [
                              UsersPostsSection(userid: snapshot.data!.id),
                              UsersallPosts(userid: snapshot.data!.id),
                            const  Text("This is profile"),
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

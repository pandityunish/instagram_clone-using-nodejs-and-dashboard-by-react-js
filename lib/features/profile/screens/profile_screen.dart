
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/auth/screens/login_screen.dart';
import 'package:instagramclone/features/profile/repository/profile_repository.dart';
import 'package:instagramclone/features/profile/screens/user_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alluserposts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthRepository authRepository = Get.put(AuthRepository());
  ProfileRepository profileRepository = Get.put(ProfileRepository());
  XFile? image;
  void pickimage() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickimage!;
    });
    if (context.mounted) {}else{
    Navigator.pop(context);
    profileRepository.updateuserpost(
        context: context,
        userid: authRepository.userdata.value!.id,
        userimage: image!,
        username: authRepository.userdata.value!.name);}
  }

  void showalertdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height * 0.26,
            child: Column(
              children: [
                const Text(
                  "Change Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                TextButton(
                    onPressed: () {
                      pickimage();
                    },
                    child: const Text(
                      "Upload Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Divider(
                  thickness: 2,
                ),
                TextButton(
                    onPressed: () {
                      profileRepository.deletuserprofile(
                          username: authRepository.userdata.value!.name,
                          userid: authRepository.userdata.value!.id,
                          context: context);
                      authRepository.userdata.value!.image = "";
                    },
                    child: const Text(
                      "Remove Current Picture",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    )),
                const Divider(
                  thickness: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userdata = authRepository.userdata.value;
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userdata!.email,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                Get.off(const LoginScreen());
              },
              icon: const Icon(Icons.settings_outlined)),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.person_add_outlined))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return authRepository.getuserdata(
                context: context, email: authRepository.userdata.value!.email);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            showalertdialog();
                          },
                          child: Obx(
                            () => CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  authRepository.userdata.value!.image.isEmpty
                                      ? const NetworkImage(userurl)
                                      : NetworkImage(userdata.image),
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userdata.email,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 218, 217, 217),
                                  minimumSize: Size(Get.width * 0.65, 35)),
                              onPressed: () {},
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.black),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 218, 217, 217),
                                  minimumSize: Size(Get.width * 0.65, 35)),
                              onPressed: () {},
                              child: const Text(
                                "Ad Tools",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    userdata.name,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Posts")
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            userdata.followers.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("Followers")
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            userdata.following.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                      indicatorColor: Color.fromARGB(255, 243, 243, 243),
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
                          icon: Icon(Icons.bookmark_outline),
                        ),
                        Tab(
                          icon: Icon(Icons.person_pin_outlined),
                        )
                      ]),
                  SizedBox(
                    height: Get.height * 0.5,
                    child: TabBarView(
                      physics:const NeverScrollableScrollPhysics(),
                      children: [
                      const UserPosts(),
                      UsersallPosts(userid: userdata.id),
                      const Text("This is bookmark"),
                      const Text("This is profile"),
                    ]),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

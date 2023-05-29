import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/color.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/addpost/screens/add_screens.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/home/screen/home_screen.dart';
import 'package:instagramclone/features/profile/screens/profile_screen.dart';
import 'package:instagramclone/models/user_model.dart';

import '../../features/search/screens/search_screen.dart';

class CustomBotttomNavigationBar extends StatefulWidget {
  const CustomBotttomNavigationBar({super.key});

  @override
  State<CustomBotttomNavigationBar> createState() => _CustomBotttomNavigationBarState();
}

class _CustomBotttomNavigationBarState extends State<CustomBotttomNavigationBar> {
  AuthRepository repository=Get.put(AuthRepository());
  List<Usermodel> users=[];
  List<Widget> children=[
  const HomeScreen(),
   const SearchScreen(),
    
  const  AddScreens(),
  const  Text("message"),
   const ProfileScreen()
  ];
 
  int index=0;
  void selectindex(int i){
    setState(() {
      index=i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectindex,
        backgroundColor: kbgcolor,
        elevation: 0,
        currentIndex: index,
             selectedItemColor: Colors.black,
             unselectedItemColor: Colors.grey,
           type: BottomNavigationBarType.fixed,
        items: [
      const  BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
       const BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
         const BottomNavigationBarItem(icon: Icon(Icons.add_to_photos),label: ""),
       const BottomNavigationBarItem(icon: Icon(Icons.chat_outlined),label: ""),
       BottomNavigationBarItem(icon:Obx(() =>Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: repository.userdata.value!.image.isEmpty?const NetworkImage(userurl):NetworkImage(repository.userdata.value!.image),fit: BoxFit.cover
         ),
          border: Border.all(
            color: Colors.grey
          ),
          
        ),
        ) ) ,label: ""),
       
      ]),
    );
  }
}
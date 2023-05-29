import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/global.dart';
import 'package:instagramclone/features/home/repository/home_repository.dart';
import 'package:instagramclone/features/profile/screens/alter_profile.dart';
import 'package:instagramclone/models/user_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constant/color.dart';
import '../../auth/repository/auth_repository.dart';

class SearchPhotoDelecates extends SearchDelegate {
  final List<Usermodel> posts;

  SearchPhotoDelecates({required this.posts});
  
@override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme:const TextTheme(
        // Use this to change the query's text style
        titleLarge: TextStyle(fontSize: 20.0, ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor:Colors.white,
      ),
      inputDecorationTheme:const InputDecorationTheme(
        border: InputBorder.none,
      
        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 20.0),
      ),
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    
    List<Usermodel> matchQuery = [];
    for (var item in posts) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
          ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {

        final data = matchQuery[index];
        
        return InkWell(
          onTap: () {
           Get.to(AlterProfileScreen(email: data.email, name: data.name));
          },
          child: ListTile(
             leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:data.image.isEmpty?const NetworkImage(userurl): NetworkImage(data.image),
            ),
            title: Text(data.name),
          ),
        );
      },
    )
    );
   
   
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   
    List<Usermodel> matchQuery = [];
    for (var item in posts) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    if(matchQuery.isEmpty){
          return Center(
            child: Text('No results found for "$query"'),
          );
        }else{
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {

        final data = matchQuery[index];
        
        return InkWell(
          onTap: () {
             Get.to(AlterProfileScreen(email: data.email, name: data.name));
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:data.image.isEmpty?const NetworkImage(userurl): NetworkImage(data.image),
            ),
            title: Text(data.name),
          ),
        );
      },
    );
        }
  }
}
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   AuthRepository repository=Get.put(AuthRepository());
    List<Usermodel> users=[];
   void addallusers()async{
    users=await repository.getallusers(context: context);
    setState(() {
      
    });
  }
  @override
  void initState() {
addallusers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      HomeRepository repository = Get.put(HomeRepository());
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
             
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      showSearch(context: context, delegate:
                       SearchPhotoDelecates(posts: users));
                    },
                    child: Container(
                      height: 35,
                      width: Get.width*0.9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                         const Icon(Icons.search,size: 18,),
                           SizedBox(width: Get.width*0.02,),
                        const  Text("Search",style: TextStyle(fontSize: 16),),
                         
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.03,),
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
                  
                    return  MasonryGridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                  gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                 mainAxisSpacing: 8,
  crossAxisSpacing: 8,
                   

                 itemBuilder: (context, index) {
                 
                 return  snapshot.data![index].images.isNotEmpty? ClipRRect(
                 borderRadius: BorderRadius.circular(10),
            child: Image.network(snapshot.data![index].images[0],fit: BoxFit.cover,),
          ):Container();
                 },);
                  }
                },
              ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

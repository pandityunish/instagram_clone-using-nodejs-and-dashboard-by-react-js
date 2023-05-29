import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoriesModel {
  final String useremail;
  final String username;
  final String userimage;
  final List images;
  final String userid;
  StoriesModel({
    required this.useremail,
    required this.username,
    required this.userimage,
    required this.images,
    required this.userid,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'useremail': useremail,
      'username': username,
      'userimage': userimage,
      'images': images,
      'userid':userid
    };
  }

  factory StoriesModel.fromMap(Map<String, dynamic> map) {
    return StoriesModel(
      useremail: map['useremail'] as String,
      username: map['username'] as String,
      userimage: map['userimage'] as String,
      images: List.from((map['images'] as List)),
       userid: map['userid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoriesModel.fromJson(String source) => StoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

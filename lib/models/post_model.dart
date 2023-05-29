import 'dart:convert';

import 'package:instagramclone/models/comment_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String postid;
  final String title;
  final String video;
  final List images;
  final List likes;
  final String userimage;
  final String username;
  final String userid;
  final String date;
  final String useremail;
  final List<CommentModel>? comment;
  PostModel({
    required this.postid,
    required this.title,
    required this.video,
    required this.images,
    required this.likes,
    required this.userimage,
    required this.username,
    required this.userid,
    required this.date,
    required this.comment,
    required this.useremail
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'video': video,
      'images': images,
      'likes': likes,
      'userimage': userimage,
      'username': username,
      'userid': userid,
      'date': date,
      'comment': comment?.map((x) => x.toMap()).toList(),
      '_id':postid,
      'useremail':useremail
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'] as String,
      video: map['video'] as String,
      images: List.from((map['images'] as List)),
      likes: List.from((map['likes'] as List)),
      userimage: map['userimage'] as String,
      username: map['username'] as String,
      userid: map['userid'] as String,
      date: map['date'] as String,
      postid: map['_id'] as String,
      useremail: map['useremail'] as String,
      comment: map['comment'] != null
          ? List<CommentModel>.from(
              map['comment']?.map(
                (x) => CommentModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

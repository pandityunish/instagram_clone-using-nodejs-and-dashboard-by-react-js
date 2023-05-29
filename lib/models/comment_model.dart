import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  final String username;
  final String userimage;
  final String userid;
  final String title;
  CommentModel({
    required this.username,
    required this.userimage,
    required this.userid,
    required this.title,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'userimage': userimage,
      'userid': userid,
      'title': title,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      username: map['username'] as String,
      userimage: map['userimage'] as String,
      userid: map['userid'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

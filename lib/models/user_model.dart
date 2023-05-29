import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Usermodel {
  final String name;
  final String id;
  final String email;
   String image;
   final List followers;
   final List following;
  Usermodel({
    required this.name,
    required this.id,
    required this.email,
    required this.image,
    required this.followers,
    required this.following,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      '_id': id,
      'email': email,
      'image': image,
      'followers': followers,
      'following': following,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] as String,
      id: map['_id'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      followers: List.from((map['followers'] as List)),
      following: List.from((map['following'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) => Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);
}

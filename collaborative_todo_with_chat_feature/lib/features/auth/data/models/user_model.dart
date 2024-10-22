import 'dart:convert';

import 'package:collaborative_todo_with_chat_feature/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userid,
      required super.username,
      required super.fname,
      required super.sname,
      required super.email,
      required super.imageurl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: json['userid'],
      username: json['username'],
      fname: json['fname'],
      sname: json['sname'],
      email: json['email'],
      imageurl: json['imageurl'],
    );
  }

  factory UserModel.fromString(String json) {
    final fromJson = jsonDecode(json);
    return UserModel.fromJson(fromJson);
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'username': username,
      'fname': fname,
      'sname': sname,
      'email': email,
      'imageurl': imageurl,
    };
  }
}

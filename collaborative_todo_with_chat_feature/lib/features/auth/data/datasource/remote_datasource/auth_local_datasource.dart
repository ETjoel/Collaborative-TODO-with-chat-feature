import 'dart:convert';

import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(UserModel userModel);
  Future<UserModel> getUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userModel) async {
    try {
      await sharedPreferences.setString('user', jsonEncode(userModel.toJson()));
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> getUser() async {
    final user = sharedPreferences.getString('user');
    if (user != null) {
      return UserModel.fromString(user);
    } else {
      throw const ServerFailure("User not found");
    }
  }
}

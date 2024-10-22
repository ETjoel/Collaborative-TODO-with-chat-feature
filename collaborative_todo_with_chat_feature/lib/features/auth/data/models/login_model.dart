import 'package:collaborative_todo_with_chat_feature/features/auth/domain/entities/login_domain.dart';

class LoginModel extends LoginEntity {
  LoginModel(super.email, super.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json['email'], json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

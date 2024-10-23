import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/login_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController fnameController;
  final TextEditingController snameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpButton({
    super.key,
    required this.emailController,
    required this.fnameController,
    required this.snameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: () {
        if (emailController.text.isNotEmpty &&
            fnameController.text.isNotEmpty &&
            snameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            passwordController.text.length >= 6 &&
            passwordController.text == confirmPasswordController.text) {
          final loginModel =
              LoginModel(emailController.text, passwordController.text);
          final userModel = UserModel(
              userid: '',
              username: '${fnameController.text}_${snameController.text}',
              fname: fnameController.text,
              sname: snameController.text,
              email: emailController.text,
              imageurl: '');
          context
              .read<AuthBloc>()
              .add(SignUpEvent(loginModel: loginModel, userModel: userModel));
        }
      },
      child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Text('Sign Up',
              style: TextStyle(fontSize: 20, color: colorScheme.onPrimary))),
    );
  }
}

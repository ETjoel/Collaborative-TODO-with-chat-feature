import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_model.dart';
import '../bloc/auth/auth_bloc.dart';

class SignInButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignInButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: () {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            passwordController.text.length >= 6) {
          context.read<AuthBloc>().add(SignInEvent(
              loginModel:
                  LoginModel(emailController.text, passwordController.text)));
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
          child: Text('Sign In',
              style: TextStyle(fontSize: 20, color: colorScheme.onPrimary))),
    );
  }
}

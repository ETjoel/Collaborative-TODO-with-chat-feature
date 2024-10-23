import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSigningInLoading) {
            showAboutDialog(
                context: context,
                children: [const CircularProgressIndicator()]);
          } else if (state is AuthSignedIn) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthSignInFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.failure.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome back ...',
                      style: TextStyle(
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: size.height * 0.1),
              Text('Email'),
              SizedBox(height: 3),
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'papajones@gmail.com',
              ),
              SizedBox(height: 3),
              Text('Password'),
              SizedBox(height: 3),
              CustomTextField(
                  controller: passwordController,
                  hintText: '******',
                  obscureText: true),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.07),
              SignInButton(
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

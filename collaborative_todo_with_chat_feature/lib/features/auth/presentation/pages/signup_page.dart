import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fnameContoller = TextEditingController();
    TextEditingController snameContoller = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSigningUpLoading) {
            showAboutDialog(
                context: context,
                children: [const CircularProgressIndicator()]);
          } else if (state is AuthSignedUp) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is AuthSignUpFailure) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Welcom to',
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Text('Collaborative Todo With Chat',
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text('Email'),
                SizedBox(height: 3),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'papajones@gmail.com',
                ),
                SizedBox(height: 3),
                Text('First Name'),
                SizedBox(height: 3),
                CustomTextField(
                  controller: fnameContoller,
                  hintText: 'Fist Name',
                ),
                SizedBox(
                  height: 3,
                ),
                Text('Last Name'),
                SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  controller: snameContoller,
                  hintText: 'Second Name',
                ),
                SizedBox(height: 3),
                Text('Password'),
                SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: '******',
                  obscureText: true,
                ),
                SizedBox(height: 3),
                Text('Confirm Password'),
                SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: '*****',
                  obscureText: true,
                ),
                SizedBox(height: size.height * 0.07),
                SignUpButton(
                    emailController: emailController,
                    fnameController: fnameContoller,
                    snameController: snameContoller,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

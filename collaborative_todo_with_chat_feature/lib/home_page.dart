import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/pages/login_page.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 211, 53, 145),
      brightness: Brightness.light,
    );
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(IsSignInedEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(colorScheme: colorScheme),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSigningInLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is AuthSignedIn) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}

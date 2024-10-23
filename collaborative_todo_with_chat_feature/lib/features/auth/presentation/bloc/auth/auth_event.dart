part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class IsSignInedEvent extends AuthEvent {}

final class SignInEvent extends AuthEvent {
  final LoginModel loginModel;
  const SignInEvent({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

final class SignUpEvent extends AuthEvent {
  final UserModel userModel;
  final LoginModel loginModel;
  const SignUpEvent({required this.userModel, required this.loginModel});

  @override
  List<Object> get props => [userModel];
}

final class GetUserEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}

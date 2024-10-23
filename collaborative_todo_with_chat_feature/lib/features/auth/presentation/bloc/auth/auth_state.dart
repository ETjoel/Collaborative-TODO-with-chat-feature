part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthSignInInitial extends AuthState {}

final class AuthSigningInLoading extends AuthState {}

final class AuthSignedIn extends AuthState {}

final class AuthSignInFailure extends AuthState {
  final Failure failure;

  const AuthSignInFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

final class AuthSignUpInitial extends AuthState {}

final class AuthSigningUpLoading extends AuthState {}

final class AuthSignedUp extends AuthState {}

final class AuthSignUpFailure extends AuthState {
  final Failure failure;

  const AuthSignUpFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

final class AuthSignOutLoading extends AuthState {}

final class AuthSignedOut extends AuthState {}

final class AuthSignOutFailure extends AuthState {
  final Failure failure;

  const AuthSignOutFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

final class GetUserLoading extends AuthState {}

final class GetUserLoaded extends AuthState {
  final UserEntity user;

  const GetUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class GetUserFailure extends AuthState {
  final Failure failure;

  const GetUserFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

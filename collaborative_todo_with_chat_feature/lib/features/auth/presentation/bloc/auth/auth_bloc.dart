import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/login_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/is_signed_in_usecase.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/login_usecase.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/sign_out_usercase.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/failure/failure.dart';
import '../../../domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final SignOutUsercase signOutUsercase;
  final GetUserUsecase getUserUsecase;
  final IsSignedInUsecase isSignedInUsecase;
  AuthBloc(
      {required this.loginUsecase,
      required this.signUpUsecase,
      required this.signOutUsercase,
      required this.getUserUsecase,
      required this.isSignedInUsecase})
      : super(AuthSignInInitial()) {
    on<IsSignInedEvent>((event, emit) async {
      emit(AuthSigningInLoading());

      final result = await isSignedInUsecase();

      result.fold((failure) => emit(AuthSignInFailure(failure)), (isSignedIn) {
        if (isSignedIn) {
          emit(AuthSignedIn());
        } else {
          emit(AuthSignInInitial());
        }
      });
    });
    on<SignInEvent>((event, emit) async {
      emit(AuthSigningInLoading());

      final result = await loginUsecase(event.loginModel);

      result.fold((failure) => emit(AuthSignInFailure(failure)),
          (unit) => emit(AuthSignedIn()));
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthSigningUpLoading());

      final result = await signUpUsecase(event.userModel, event.loginModel);

      result.fold((failure) => emit(AuthSignUpFailure(failure)),
          (unit) => emit(AuthSignedUp()));
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthSignOutLoading());

      final result = await signOutUsercase();

      result.fold((failure) => emit(AuthSignOutFailure(failure)),
          (unit) => emit(AuthSignedOut()));
    });

    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoading());

      final result = await getUserUsecase();

      result.fold((failure) => emit(AuthSignInFailure(failure)),
          (user) => emit(GetUserLoaded(user)));
    });
  }
}

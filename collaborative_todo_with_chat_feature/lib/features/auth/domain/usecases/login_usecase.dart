import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/login_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<Either<Failure, Unit>> call(LoginModel loginModel) {
    return authRepository.logInWithEmailAndPassword(loginModel);
  }
}

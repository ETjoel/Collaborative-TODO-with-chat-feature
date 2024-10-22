import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/login_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

class SignUpUsecase {
  final AuthRepository authRepository;
  SignUpUsecase({required this.authRepository});

  Future<Either<Failure, Unit>> call(UserModel user, LoginModel loginModel) {
    return authRepository.signUp(user, loginModel);
  }
}

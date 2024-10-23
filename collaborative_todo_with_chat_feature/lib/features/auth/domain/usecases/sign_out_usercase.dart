import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class SignOutUsercase {
  final AuthRepository authRepository;

  SignOutUsercase({required this.authRepository});

  Future<Either<Failure, Unit>> call() {
    return authRepository.signOut();
  }
}

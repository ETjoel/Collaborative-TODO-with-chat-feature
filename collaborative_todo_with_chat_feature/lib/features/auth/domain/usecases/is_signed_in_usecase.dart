import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class IsSignedInUsecase {
  final AuthRepository authRepository;

  IsSignedInUsecase({required this.authRepository});

  Future<Either<Failure, bool>> call() {
    return authRepository.isSignedIn();
  }
}

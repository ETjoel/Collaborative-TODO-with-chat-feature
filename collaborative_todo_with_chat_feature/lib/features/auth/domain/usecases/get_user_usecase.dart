import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/entities/user_entity.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase {
  final AuthRepository authRepository;
  const GetUserUsecase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call() {
    return authRepository.getUser();
  }
}

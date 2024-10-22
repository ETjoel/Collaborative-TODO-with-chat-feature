import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/login_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      LoginModel loginModel);
  Future<Either<Failure, Unit>> signUp(
      UserModel userModel, LoginModel loginModel);
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, UserEntity>> getUser();
}

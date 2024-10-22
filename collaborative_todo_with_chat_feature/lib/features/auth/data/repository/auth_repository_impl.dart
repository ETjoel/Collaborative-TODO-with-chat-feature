import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/datasource/remote_datasource/auth_local_datasource.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/entities/user_entity.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network.dart';
import '../models/login_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.authRemoteDatasource,
      required this.authLocalDatasource});
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await authRemoteDatasource.getUser();
        await authLocalDatasource.cacheUser(user);
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final user = await authLocalDatasource.getUser();
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final isSignedIn = await authRemoteDatasource.isSignIn();
      return Right(isSignedIn);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      LoginModel loginModel) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDatasource.logInWithEmailAndPassword(loginModel);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(
      UserModel userModel, LoginModel loginEntity) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDatasource.signUp(userModel, loginEntity);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authRemoteDatasource.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

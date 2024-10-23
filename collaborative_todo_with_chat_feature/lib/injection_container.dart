import "package:cloud_firestore/cloud_firestore.dart";
import "package:collaborative_todo_with_chat_feature/core/network/network.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/data/datasource/local_datasource/auth_local_datasource.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/data/repository/auth_repository_impl.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/domain/repository/auth_repository.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/is_signed_in_usecase.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/login_usecase.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/domain/usecases/signup_usecase.dart";
import "package:collaborative_todo_with_chat_feature/features/auth/presentation/bloc/auth/auth_bloc.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:get_it/get_it.dart";
import "package:internet_connection_checker/internet_connection_checker.dart";
import "package:shared_preferences/shared_preferences.dart";

import "features/auth/domain/usecases/get_user_usecase.dart";
import "features/auth/domain/usecases/sign_out_usercase.dart";

final sl = GetIt.instance;

Future<void> init() async {
  //feeatures
  sl.registerFactory(() => AuthBloc(
      loginUsecase: sl(),
      signUpUsecase: sl(),
      signOutUsercase: sl(),
      getUserUsecase: sl(),
      isSignedInUsecase: sl()));

  //usecases
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUsercase(authRepository: sl()));
  sl.registerLazySingleton(() => GetUserUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => IsSignedInUsecase(authRepository: sl()));

  //repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl(),
      authRemoteDatasource: sl(),
      authLocalDatasource: sl()));

  //datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(firebaseAuth: sl(), firebaseFirestore: sl()));

  sl.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

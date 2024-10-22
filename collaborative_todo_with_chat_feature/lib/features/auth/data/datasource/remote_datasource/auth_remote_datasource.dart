import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collaborative_todo_with_chat_feature/core/constants.dart';
import 'package:collaborative_todo_with_chat_feature/core/failure/failure.dart';
import 'package:collaborative_todo_with_chat_feature/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/login_domain.dart';
import '../../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> logInWithEmailAndPassword(LoginEntity loginEntity);
  Future<void> signUp(UserModel userModel, LoginModel loginModel);
  Future<UserModel> getUser();
  Future<bool> isSignIn();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<UserModel> getUser() async {
    try {
      final collection = firebaseFirestore.collection(userCollection);
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        final user = await collection.doc(currentUser.uid).get();
        return UserModel.fromJson(user.data()!);
      } else {
        throw const ServerFailure("User not found");
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> logInWithEmailAndPassword(LoginEntity loginEntity) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: loginEntity.email, password: loginEntity.password);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> signUp(UserModel userModel, LoginModel loginModel) async {
    String? uid;
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);

      uid = userCredential.user!.uid;

      final newUser = UserModel(
          userid: userCredential.user!.uid,
          username: userModel.username,
          fname: userModel.fname,
          sname: userModel.sname,
          email: userModel.email,
          imageurl: userModel.imageurl);

      await firebaseFirestore
          .collection(userCollection)
          .doc(newUser.userid)
          .set(newUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.toString());
    } catch (e) {
      if (uid != null) {
        debugPrint("fire store error: ${e.toString()}");
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<bool> isSignIn() {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}

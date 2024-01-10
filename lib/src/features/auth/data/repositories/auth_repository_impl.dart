import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;
  final AuthDataSource _authDataSource;

  @override
  Future<Either<Failure, UserCredential?>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signUp(
        email: email,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(
        Failure(
          message: error.message ?? error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> createUser({
    required AppUser appUser,
  }) async {
    try {
      final response = await _authDataSource.createUser(
        appUser: appUser,
      );
      return Right(response);
    } on DioException catch (error) {
      return Left(
        Failure(
          message: error.response?.data.toString() ?? error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authDataSource.signIn(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return Left(
        Failure(
          message: error.message ?? error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> getUser({
    required String? id,
  }) async {
    try {
      final response = await _authDataSource.getUser(id: id);
      return Right(response);
    } on DioException catch (error) {
      debugPrint('Error ${error.response?.data}');
      return Left(
        Failure(
          message: error.response?.data.toString() ?? error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }
}

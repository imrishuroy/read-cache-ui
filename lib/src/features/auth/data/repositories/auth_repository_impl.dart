import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/network/dio_exception.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

class AuthRepositoryRepositoryImpl extends AuthRepository {
  AuthRepositoryRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;
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
    } on DioException catch (error) {
      return Left(
        Failure(
          message: DioExceptions.fromDioError(error).message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppUserDto?>> createUser({
    required SignUpReqDto signUpReqDto,
  }) async {
    try {
      final response = await _authDataSource.createUse(
        signUpReqDto: signUpReqDto,
      );
      return Right(response);
    } on DioException catch (error) {
      return Left(
        Failure(
          message: DioExceptions.fromDioError(error).message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authDataSource.login(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } on DioException catch (error) {
      return Left(
        Failure(
          message: DioExceptions.fromDioError(error).message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppUserDto?>> getUser({
    required String? id,
  }) async {
    try {
      final response = await _authDataSource.getUser(id: id);
      return Right(response);
    } on DioException catch (error) {
      return Left(
        Failure(
          message: DioExceptions.fromDioError(error).message,
        ),
      );
    }
  }
}

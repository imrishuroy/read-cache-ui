import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';

class AuthUseCase {
  AuthUseCase({
    required AuthRepositoryRepositoryImpl authRepositoryRepositoryImpl,
  }) : _authRepositoryRepositoryImpl = authRepositoryRepositoryImpl;

  final AuthRepositoryRepositoryImpl _authRepositoryRepositoryImpl;

  Future<Either<Failure, UserCredential?>> signUp({
    required String email,
    required String password,
  }) async {
    return _authRepositoryRepositoryImpl.signUp(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, AppUserDto?>> createUser({
    required SignUpReqDto signUpReqDto,
  }) async {
    return _authRepositoryRepositoryImpl.createUser(
      signUpReqDto: signUpReqDto,
    );
  }

  Future<Either<Failure, UserCredential?>> login({
    required String email,
    required String password,
  }) async {
    return _authRepositoryRepositoryImpl.login(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, AppUserDto?>> getUser({
    required String? id,
  }) async {
    return _authRepositoryRepositoryImpl.getUser(
      id: id,
    );
  }
}

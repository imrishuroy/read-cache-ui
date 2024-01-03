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
    required CreateUserReqDto createUserReqDto,
  }) async {
    return _authRepositoryRepositoryImpl.createUser(
      createUserReqDto: createUserReqDto,
    );
  }

  Future<Either<Failure, UserCredential?>> signIn({
    required String email,
    required String password,
  }) async {
    return _authRepositoryRepositoryImpl.signIn(
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

  Future<void> signOut() async {
    await _authRepositoryRepositoryImpl.signOut();
  }
}

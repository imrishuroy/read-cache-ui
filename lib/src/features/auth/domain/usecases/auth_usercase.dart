import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

class AuthUseCase {
  AuthUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Failure, UserCredential?>> signUp({
    required String email,
    required String password,
  }) async {
    return _authRepository.signUp(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, AppUserDto?>> createUser({
    required CreateUserReqDto createUserReqDto,
  }) async {
    return _authRepository.createUser(
      createUserReqDto: createUserReqDto,
    );
  }

  Future<Either<Failure, UserCredential?>> signIn({
    required String email,
    required String password,
  }) async {
    return _authRepository.signIn(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, AppUserDto?>> getUser({
    required String? id,
  }) async {
    return _authRepository.getUser(
      id: id,
    );
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}

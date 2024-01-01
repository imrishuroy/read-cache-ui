import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential?>> signUp({
    required String email,
    required String password,
  });

  Future<Either<Failure, AppUserDto?>> createUser({
    required SignUpReqDto signUpReqDto,
  });

  Future<Either<Failure, UserCredential?>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AppUserDto?>> getUser({
    required String id,
  });
}

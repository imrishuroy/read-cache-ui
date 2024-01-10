import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';


abstract class AuthRepository {
  Future<Either<Failure, UserCredential?>> signUp({
    required String email,
    required String password,
  });

  Future<Either<Failure, AppUser>> createUser({
    required AppUser appUser,
  });

  Future<Either<Failure, UserCredential?>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, AppUser>> getUser({
    required String? id,
  });

  Future<void> signOut();
}

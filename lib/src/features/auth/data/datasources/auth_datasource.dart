import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:read_cache_ui/src/core/network/read_cache_client.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';

class AuthDataSource {
  AuthDataSource({
    required FirebaseAuth firebaseAuth,
    required ReadCacheClient readCacheClient,
  })  : _firebaseAuth = firebaseAuth,
        _readCacheClient = readCacheClient;

  final FirebaseAuth _firebaseAuth;
  final ReadCacheClient _readCacheClient;

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (_) {
      rethrow;
    }
  }

  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (_) {
      rethrow;
    }
  }

  Future<String?> ping() async {
    try {
      return await _readCacheClient.ping();
    } catch (error) {
      debugPrint('Error in ping $error');
    }
    return null;
  }

  Future<AppUserDto?> createUse({
    required SignUpReqDto signUpReqDto,
  }) async {
    try {
      return await _readCacheClient.createUser(
        signUpReqDto,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<AppUserDto?> getUser({
    required String? id,
  }) async {
    try {
      return await _readCacheClient.getUser(id);
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

class AuthDataSource {
  AuthDataSource({
    required FirebaseAuth firebaseAuth,
    required CacheClient cacheClient,
  })  : _firebaseAuth = firebaseAuth,
        _readCacheClient = cacheClient;

  final FirebaseAuth _firebaseAuth;
  final CacheClient _readCacheClient;

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

  Future<UserCredential?> signIn({
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

  Future<AppUser> createUser({
    required AppUser appUser,
  }) async {
    try {
      return await _readCacheClient.createUser(
        appUser,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<AppUser> getUser({
    required String? id,
  }) async {
    try {
      return await _readCacheClient.getUser(id);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      rethrow;
    }
  }
}

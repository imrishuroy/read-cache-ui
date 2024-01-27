import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/constants/constants.dart';
import 'package:read_cache_ui/src/core/network/auth_interceptor.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/Tag/presentation/bloc/tag_bloc.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/cache/presentation/bloc/cache_bloc.dart';

@module
abstract class CacheModule {
  @Named('baseUrl')
  String get baseUrl => APIConstants.baseUrl;

  @singleton
  CacheClient cacheClient() {
    if (!getIt.isRegistered<Dio>()) {
      getIt.registerSingleton<Dio>(Dio());
    }

    final dioInstance = getIt<Dio>();
    dioInstance.options.baseUrl = baseUrl;
    dioInstance.interceptors.add(AuthInterceptor());
    final cacheClient = CacheClient(dioInstance, baseUrl: baseUrl);
    return cacheClient;
  }

  @singleton
  AuthDataSource authDataSource() {
    if (!getIt.isRegistered<Dio>()) {
      getIt.registerSingleton<Dio>(Dio());
    }

    final dioInstance = getIt<Dio>();
    dioInstance.options.baseUrl = baseUrl;
    dioInstance.interceptors.add(AuthInterceptor());
    final cacheClient = CacheClient(dioInstance, baseUrl: baseUrl);
    return AuthDataSource(
      firebaseAuth: FirebaseAuth.instance,
      cacheClient: cacheClient,
    );
  }

  @factory
  CacheBloc cacheBloc() {
    if (!getIt.isRegistered<TagBloc>()) {
      getIt.registerFactory<TagBloc>(() => TagBloc(tagUseCase: getIt()));
    }
    return CacheBloc(
      tagBloc: getIt(),
      cacheUseCase: getIt(),
    );
  }
}

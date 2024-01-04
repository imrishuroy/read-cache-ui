import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:read_cache_ui/src/core/constants/api_constants.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      authUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CacheBloc>(
    () => CacheBloc(
      cacheUseCase: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSource(
      firebaseAuth: FirebaseAuth.instance,
      readCacheClient: getIt(),
    ),
  );

  getIt.registerLazySingleton<CacheDataSource>(
    () => CacheDataSource(
      readCacheClient: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<CacheRepository>(
    () => CacheRepositoryImpl(
      cacheDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CacheUseCase>(
    () => CacheUseCase(
      cacheRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CacheClient>(
    () => CacheClient(
      getIt(),
      baseUrl: APIConstants.baseUrl,
    ),
  );

  getIt.registerLazySingleton<Dio>(() => Dio());
}

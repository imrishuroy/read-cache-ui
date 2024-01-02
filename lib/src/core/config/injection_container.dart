import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:read_cache_ui/src/core/constants/api_constants.dart';
import 'package:read_cache_ui/src/core/network/read_cache_client.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => AuthBloc(
      authUseCase: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthDataSource(
      firebaseAuth: FirebaseAuth.instance,
      readCacheClient: ReadCacheClient(
        getIt(),
        baseUrl: APIConstants.baseUrl,
      ),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthRepositoryRepositoryImpl(
      authDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => AuthUseCase(
      authRepositoryRepositoryImpl: getIt(),
    ),
  );

  getIt.registerLazySingleton<Dio>(() => Dio());
}

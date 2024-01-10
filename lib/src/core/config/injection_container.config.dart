// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/auth/data/data.dart' as _i3;
import '../../features/auth/data/repositories/auth_repository_impl.dart' as _i5;
import '../../features/auth/domain/domain.dart' as _i4;
import '../../features/auth/domain/usecases/auth_usercase.dart' as _i6;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i13;
import '../../features/cache/data/data.dart' as _i11;
import '../../features/cache/data/datasources/cache_datasource.dart' as _i8;
import '../../features/cache/data/repositories/cache_repository_impl.dart'
    as _i10;
import '../../features/cache/domain/domain.dart' as _i9;
import '../../features/cache/domain/usecases/cache_usecase.dart' as _i12;
import '../../features/cache/presentation/bloc/cache_bloc.dart' as _i14;
import '../network/cache_client.dart' as _i7;
import 'cache_module.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final cacheModule = _$CacheModule();
    gh.singleton<_i3.AuthDataSource>(cacheModule.authDataSource());
    gh.lazySingleton<_i4.AuthRepository>(
        () => _i5.AuthRepositoryImpl(authDataSource: gh<_i3.AuthDataSource>()));
    gh.lazySingleton<_i6.AuthUseCase>(
        () => _i6.AuthUseCase(authRepository: gh<_i4.AuthRepository>()));
    gh.singleton<_i7.CacheClient>(cacheModule.cacheClient());
    gh.lazySingleton<_i8.CacheDataSource>(
        () => _i8.CacheDataSource(cacheClient: gh<_i7.CacheClient>()));
    gh.lazySingleton<_i9.CacheRepository>(() =>
        _i10.CacheRepositoryImpl(cacheDataSource: gh<_i11.CacheDataSource>()));
    gh.lazySingleton<_i12.CacheUseCase>(
        () => _i12.CacheUseCase(cacheRepository: gh<_i9.CacheRepository>()));
    gh.factory<String>(
      () => cacheModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i13.AuthBloc>(
        () => _i13.AuthBloc(authUseCase: gh<_i4.AuthUseCase>()));
    gh.factory<_i14.CacheBloc>(
        () => _i14.CacheBloc(cacheUseCase: gh<_i9.CacheUseCase>()));
    return this;
  }
}

class _$CacheModule extends _i15.CacheModule {}

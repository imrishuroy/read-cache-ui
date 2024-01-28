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
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i23;
import '../../features/cache/data/data.dart' as _i12;
import '../../features/cache/data/datasources/cache_datasource.dart' as _i9;
import '../../features/cache/data/repositories/cache_repository_impl.dart'
    as _i11;
import '../../features/cache/domain/domain.dart' as _i10;
import '../../features/cache/domain/usecases/cache_usecase.dart' as _i13;
import '../../features/cache/presentation/bloc/cache_bloc.dart' as _i7;
import '../../features/public_cache/data/datasources/public_cache_datasource.dart'
    as _i14;
import '../../features/public_cache/data/repositories/public_cache_repository_impl.dart'
    as _i16;
import '../../features/public_cache/domain/domain.dart' as _i15;
import '../../features/public_cache/domain/usecases/public_cache_usecase.dart'
    as _i17;
import '../../features/public_cache/presentation/bloc/public_cache_bloc.dart'
    as _i24;
import '../../features/tag/data/data.dart' as _i21;
import '../../features/tag/data/datasources/tag_datasource.dart' as _i18;
import '../../features/tag/data/repositories/tag_repository_impl.dart' as _i20;
import '../../features/tag/domain/domain.dart' as _i19;
import '../../features/tag/domain/usecases/tag_usecase.dart' as _i22;
import '../../features/tag/presentation/bloc/tag_bloc.dart' as _i25;
import '../network/cache_client.dart' as _i8;
import 'cache_module.dart' as _i26;

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
    gh.factory<_i7.CacheBloc>(() => cacheModule.cacheBloc());
    gh.singleton<_i8.CacheClient>(cacheModule.cacheClient());
    gh.lazySingleton<_i9.CacheDataSource>(
        () => _i9.CacheDataSource(cacheClient: gh<_i8.CacheClient>()));
    gh.lazySingleton<_i10.CacheRepository>(() =>
        _i11.CacheRepositoryImpl(cacheDataSource: gh<_i12.CacheDataSource>()));
    gh.lazySingleton<_i13.CacheUseCase>(
        () => _i13.CacheUseCase(cacheRepository: gh<_i10.CacheRepository>()));
    gh.lazySingleton<_i14.PublicCacheDataSource>(
        () => _i14.PublicCacheDataSource(cacheClient: gh<_i8.CacheClient>()));
    gh.lazySingleton<_i15.PublicCacheRepository>(() =>
        _i16.PublicCacheRepositoryImpl(
            publicCacheDataSource: gh<_i14.PublicCacheDataSource>()));
    gh.lazySingleton<_i17.PublicCacheUseCase>(() => _i17.PublicCacheUseCase(
        publicCacheRepository: gh<_i15.PublicCacheRepository>()));
    gh.factory<String>(
      () => cacheModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i18.TagDataSource>(
        () => _i18.TagDataSource(cacheClient: gh<_i8.CacheClient>()));
    gh.lazySingleton<_i19.TagRepository>(
        () => _i20.TagRepositoryImpl(tagDataSource: gh<_i21.TagDataSource>()));
    gh.lazySingleton<_i22.TagUseCase>(
        () => _i22.TagUseCase(tagRepository: gh<_i19.TagRepository>()));
    gh.lazySingleton<_i23.AuthBloc>(
        () => _i23.AuthBloc(authUseCase: gh<_i4.AuthUseCase>()));
    gh.factory<_i24.PublicCacheBloc>(() => _i24.PublicCacheBloc(
        publicCacheUseCase: gh<_i15.PublicCacheUseCase>()));
    gh.factory<_i25.TagBloc>(
        () => _i25.TagBloc(tagUseCase: gh<_i19.TagUseCase>()));
    return this;
  }
}

class _$CacheModule extends _i26.CacheModule {}

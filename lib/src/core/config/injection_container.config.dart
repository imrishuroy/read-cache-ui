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
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i19;
import '../../features/cache/data/data.dart' as _i12;
import '../../features/cache/data/datasources/cache_datasource.dart' as _i9;
import '../../features/cache/data/repositories/cache_repository_impl.dart'
    as _i11;
import '../../features/cache/domain/domain.dart' as _i10;
import '../../features/cache/domain/usecases/cache_usecase.dart' as _i13;
import '../../features/cache/presentation/bloc/cache_bloc.dart' as _i7;
import '../../features/tag/data/data.dart' as _i17;
import '../../features/tag/data/datasources/tag_datasource.dart' as _i14;
import '../../features/tag/data/repositories/tag_repository_impl.dart' as _i16;
import '../../features/tag/domain/domain.dart' as _i15;
import '../../features/tag/domain/usecases/tag_usecase.dart' as _i18;
import '../../features/tag/presentation/bloc/tag_bloc.dart' as _i20;
import '../network/cache_client.dart' as _i8;
import 'cache_module.dart' as _i21;

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
    gh.factory<String>(
      () => cacheModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i14.TagDataSource>(
        () => _i14.TagDataSource(cacheClient: gh<_i8.CacheClient>()));
    gh.lazySingleton<_i15.TagRepository>(
        () => _i16.TagRepositoryImpl(tagDataSource: gh<_i17.TagDataSource>()));
    gh.lazySingleton<_i18.TagUseCase>(
        () => _i18.TagUseCase(tagRepository: gh<_i15.TagRepository>()));
    gh.lazySingleton<_i19.AuthBloc>(
        () => _i19.AuthBloc(authUseCase: gh<_i4.AuthUseCase>()));
    gh.factory<_i20.TagBloc>(
        () => _i20.TagBloc(tagUseCase: gh<_i15.TagUseCase>()));
    return this;
  }
}

class _$CacheModule extends _i21.CacheModule {}

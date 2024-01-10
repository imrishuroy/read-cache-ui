import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

@LazySingleton(as: CacheRepository)
class CacheRepositoryImpl extends CacheRepository {
  CacheRepositoryImpl({
    required CacheDataSource cacheDataSource,
  }) : _cacheDataSource = cacheDataSource;
  final CacheDataSource _cacheDataSource;

  @override
  Future<Either<Failure, Cache?>> createCache({
    required Cache cache,
  }) async {
    try {
      final cacheRes = await _cacheDataSource.createCache(
        cache: cache,
      );
      return Right(cacheRes);
    } on DioException catch (error) {
      return Left(
        Failure(
          statusCode: error.response?.statusCode,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  }) async {
    try {
      final cachesList = await _cacheDataSource.listCaches(
        pageSize: pageSize,
        pageId: pageId,
      );
      return Right(cachesList);
    } on DioException catch (error) {
      return Left(
        Failure(
          statusCode: error.response?.statusCode,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Cache?>> updateCache({
    required Cache cache,
  }) async {
    try {
      final cacheRes = await _cacheDataSource.updateCache(
        cache: cache,
      );
      return Right(cacheRes);
    } on DioException catch (error) {
      return Left(
        Failure(
          statusCode: error.response?.statusCode,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCache({
    required int id,
  }) async {
    try {
      return Right(
        await _cacheDataSource.deleteCache(
          id: id,
        ),
      );
    } on DioException catch (error) {
      return Left(
        Failure(
          statusCode: error.response?.statusCode,
          message: error.toString(),
        ),
      );
    }
  }
}

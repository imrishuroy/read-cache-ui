import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

class CacheRepositoryImpl extends CacheRepository {
  CacheRepositoryImpl({
    required CacheDataSource cacheDataSource,
  }) : _cacheDataSource = cacheDataSource;
  final CacheDataSource _cacheDataSource;

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
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/public_cache/data/datasources/public_cache_datasource.dart';
import 'package:read_cache_ui/src/features/public_cache/domain/domain.dart';

@LazySingleton(as: PublicCacheRepository)
class PublicCacheRepositoryImpl extends PublicCacheRepository {
  PublicCacheRepositoryImpl({
    required PublicCacheDataSource publicCacheDataSource,
  }) : _publicCacheDataSource = publicCacheDataSource;
  final PublicCacheDataSource _publicCacheDataSource;

  @override
  Future<Either<Failure, List<Cache?>>> listPublicCaches({
    required int pageSize,
    required int pageId,
    required List<int> tagIds,
  }) async {
    try {
      final response = await _publicCacheDataSource.listPublicCaches(
        pageSize: pageSize,
        pageId: pageId,
        tagIds: tagIds,
      );

      return Right(response);
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

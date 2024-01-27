import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/config/success.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';

@LazySingleton(as: TagRepository)
class TagRepositoryImpl extends TagRepository {
  TagRepositoryImpl({
    required TagDataSource tagDataSource,
  }) : _tagDataSource = tagDataSource;

  final TagDataSource _tagDataSource;

  @override
  Future<Either<Failure, List<Tag?>>> listTags() async {
    try {
      final tagsList = await _tagDataSource.listTags();
      return Right(tagsList);
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
  Future<Either<Failure, Tag?>> createTag({required Tag tag}) async {
    try {
      final tagCreated = await _tagDataSource.createTag(tag: tag);
      return Right(tagCreated);
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
  Future<Either<Failure, Success?>> addTagToCache({
    required int cacheId,
    required CacheAddTagsReq cacheAddTagsReq,
  }) async {
    try {
      final res = await _tagDataSource.addTagToCache(
        cacheId: cacheId,
        cacheAddTagsReq: cacheAddTagsReq,
      );
      return Right(res);
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
  Future<Either<Failure, List<Tag?>>> listTagsByCacheId({
    required int cacheId,
  }) async {
    try {
      final tagsList = await _tagDataSource.listTagsByCacheId(
        cacheId: cacheId,
      );
      return Right(tagsList);
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

import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/config/success.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';

abstract class TagRepository {
  Future<Either<Failure, List<Tag?>>> listTags();

  Future<Either<Failure, Tag?>> createTag({
    required Tag tag,
  });

  Future<Either<Failure, Success?>> addTagToCache({
    required int cacheId,
    required CacheAddTagsReq cacheAddTagsReq,
  });

  Future<Either<Failure, List<Tag?>>> listTagsByCacheId({
    required int cacheId,
  });
}

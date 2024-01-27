import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/config/success.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';

@lazySingleton
class TagUseCase {
  TagUseCase({
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository;

  final TagRepository _tagRepository;

  Future<Either<Failure, List<Tag?>>> getTags() async {
    return _tagRepository.listTags();
  }

  Future<Either<Failure, Tag?>> createTag({
    required Tag tag,
  }) async {
    return _tagRepository.createTag(
      tag: tag,
    );
  }

  Future<Either<Failure, Success?>> addTagToCache({
    required int cacheId,
    required CacheAddTagsReq cacheAddTagsReq,
  }) async {
    return _tagRepository.addTagToCache(
      cacheId: cacheId,
      cacheAddTagsReq: cacheAddTagsReq,
    );
  }

  Future<Either<Failure, List<Tag?>>> listTagsByCacheId({
    required int cacheId,
  }) async {
    return _tagRepository.listTagsByCacheId(
      cacheId: cacheId,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/public_cache/domain/domain.dart';

@lazySingleton
class PublicCacheUseCase {
  PublicCacheUseCase({
    required PublicCacheRepository publicCacheRepository,
  }) : _publicCacheRepository = publicCacheRepository;

  final PublicCacheRepository _publicCacheRepository;
  Future<Either<Failure, List<Cache?>>> listPublicCaches({
    required int pageSize,
    required int pageId,
    required List<int> tagIds,
  }) async {
    try {
      return await _publicCacheRepository.listPublicCaches(
        pageSize: pageSize,
        pageId: pageId,
        tagIds: tagIds,
      );
    } catch (_) {
      rethrow;
    }
  }
}

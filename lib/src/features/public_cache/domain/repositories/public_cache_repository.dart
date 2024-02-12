import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/entities/cache.dart';

abstract class PublicCacheRepository {
  Future<Either<Failure, List<Cache?>>> listPublicCaches({
    required int pageSize,
    required int pageId,
    required List<int> tagIds,
  });
}

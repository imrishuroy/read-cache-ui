import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

abstract class CacheRepository {
  Future<Either<Failure, Cache?>> createCache({
    required Cache cache,
  });

  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  });

  Future<Either<Failure, Cache?>> updateCache({
    required Cache cache,
  });

  Future<Either<Failure, void>> deleteCache({
    required int id,
  });
}

import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

abstract class CacheRepository {
  Future<Either<Failure, Cache?>> createCache({
    required CacheDto cacheDto,
  });

  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  });

  Future<Either<Failure, Cache?>> updateCache({
    required CacheDto cacheDto,
  });

  Future<Either<Failure, void>> deleteCache({
    required int id,
  });
}

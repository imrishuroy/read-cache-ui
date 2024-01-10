import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

class CacheUseCase {
  CacheUseCase({
    required CacheRepository cacheRepository,
  }) : _cacheRepository = cacheRepository;

  final CacheRepository _cacheRepository;

  Future<Either<Failure, Cache?>> createCache({
    required Cache cache,
  }) async {
    return _cacheRepository.createCache(
      cache: cache,
    );
  }

  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  }) async {
    return _cacheRepository.listCaches(
      pageSize: pageSize,
      pageId: pageId,
    );
  }

  Future<Either<Failure, Cache?>> updateCache({
    required Cache cache,
  }) async {
    return _cacheRepository.updateCache(
      cache: cache,
    );
  }

  Future<Either<Failure, void>> deleteCache({
    required int id,
  }) async {
    return _cacheRepository.deleteCache(
      id: id,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

class CacheUseCase {
  CacheUseCase({
    required CacheRepositoryImpl cacheRepositoryImpl,
  }) : _cacheRepositoryImpl = cacheRepositoryImpl;

  final CacheRepositoryImpl _cacheRepositoryImpl;

  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  }) async {
    return _cacheRepositoryImpl.listCaches(
      pageSize: pageSize,
      pageId: pageId,
    );
  }
}

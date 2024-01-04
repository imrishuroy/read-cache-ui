import 'package:dartz/dartz.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

abstract class CacheRepository {
  Future<Either<Failure, List<Cache?>>> listCaches({
    required int pageSize,
    required int pageId,
  });
}

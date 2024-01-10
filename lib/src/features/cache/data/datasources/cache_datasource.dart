import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

@lazySingleton
class CacheDataSource {
  CacheDataSource({
    required CacheClient cacheClient,
  }) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  Future<Cache?> createCache({
    required Cache cache,
  }) async {
    try {
      return _cacheClient.createCache(
        cache,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Cache?>> listCaches({
    required int pageSize,
    required int pageId,
  }) async {
    try {
      return await _cacheClient.listCaches(
        pageSize,
        pageId,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<Cache?> updateCache({
    required Cache cache,
  }) async {
    try {
      return _cacheClient.updateCache(
        cache,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteCache({
    required int id,
  }) async {
    try {
      return _cacheClient.deleteCache(
        id,
      );
    } catch (_) {
      rethrow;
    }
  }
}

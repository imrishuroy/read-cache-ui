import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';

class CacheDataSource {
  CacheDataSource({
    required CacheClient cacheClient,
  }) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  Future<CacheDto?> createCache({
    required CacheDto cacheDto,
  }) async {
    try {
      return _cacheClient.createCache(
        cacheDto,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CacheDto?>> listCaches({
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

  Future<CacheDto?> updateCache({
    required CacheDto cacheDto,
  }) async {
    try {
      return _cacheClient.updateCache(
        cacheDto,
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

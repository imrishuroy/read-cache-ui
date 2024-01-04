import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';

class CacheDataSource {
  CacheDataSource({
    required CacheClient readCacheClient,
  }) : _readCacheClient = readCacheClient;

  final CacheClient _readCacheClient;

  Future<CacheDto?> createCache({
    required CacheDto cacheDto,
  }) async {
    try {
      return _readCacheClient.createCache(
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
      return await _readCacheClient.listCaches(
        pageSize,
        pageId,
      );
    } catch (_) {
      rethrow;
    }
  }
}

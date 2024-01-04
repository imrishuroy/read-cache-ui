import 'package:read_cache_ui/src/core/network/read_cache_client.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';

class CacheDataSource {
  CacheDataSource({
    required ReadCacheClient readCacheClient,
  }) : _readCacheClient = readCacheClient;

  final ReadCacheClient _readCacheClient;

  Future<List<CacheDto?>> listCaches({
    required int pageSize,
    required int pageId,
  }) async {
    try {
      return await _readCacheClient.listCaches(
        pageSize,
        pageId,
      );
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

@lazySingleton
class PublicCacheDataSource {
  PublicCacheDataSource({
    required CacheClient cacheClient,
  }) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  Future<List<Cache?>> listPublicCaches({
    required int pageSize,
    required int pageId,
    required List<int> tagIds,
  }) async {
    try {
      final response = await _cacheClient.listPublicCaches(
        pageSize,
        pageId,
        tagIds,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }
}

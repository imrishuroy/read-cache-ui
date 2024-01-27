import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/success.dart';
import 'package:read_cache_ui/src/core/network/cache_client.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';

@lazySingleton
class TagDataSource {
  TagDataSource({
    required CacheClient cacheClient,
  }) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  Future<List<Tag?>> listTags() async {
    try {
      return await _cacheClient.listTags();
    } catch (_) {
      rethrow;
    }
  }

  Future<Tag?> createTag({
    required Tag tag,
  }) async {
    try {
      return _cacheClient.createTag(
        tag,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<Success?> addTagToCache({
    required int cacheId,
    required CacheAddTagsReq cacheAddTagsReq,
  }) async {
    try {
      return _cacheClient.addTagToCache(
        cacheId,
        cacheAddTagsReq,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Tag?>> listTagsByCacheId({
    required int cacheId,
  }) async {
    try {
      return _cacheClient.listTagsByCacheId(
        cacheId,
      );
    } catch (_) {
      rethrow;
    }
  }
}

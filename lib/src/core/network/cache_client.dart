import 'package:dio/dio.dart';
import 'package:read_cache_ui/src/core/config/success.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';
import 'package:retrofit/retrofit.dart';

part 'cache_client.g.dart';

@RestApi()
abstract class CacheClient {
  factory CacheClient(
    Dio dio, {
    String baseUrl,
  }) = _CacheClient;

  @GET('/')
  Future<String> ping();

  @GET('/users/{id}')
  Future<AppUser> getUser(@Path('id') String? id);

  @POST('/users')
  Future<AppUser> createUser(
    @Body() AppUser createUserReqDto,
  );

  @POST('/caches')
  Future<Cache?> createCache(@Body() Cache cache);

  @GET('/caches?page_size={page_size}&page_id={page_id}')
  Future<List<Cache?>> listCaches(
    @Path('page_size') int pageSize,
    @Path('page_id') int pageId,
  );

  @PUT('/caches')
  Future<Cache?> updateCache(@Body() Cache cacheDto);

  @DELETE('/caches/{id}')
  Future<void> deleteCache(@Path('id') int id);

  @GET('/tags')
  Future<List<Tag?>> listTags();

  @POST('/tags')
  Future<Tag?> createTag(@Body() Tag tag);

  @POST('/caches/{cache_id}/add-tag')
  Future<Success?> addTagToCache(
    @Path('cache_id') int cacheId,
    @Body() CacheAddTagsReq cacheAddTagsReq,
  );

  @GET('/caches/{cache_id}/tags')
  Future<List<Tag?>> listTagsByCacheId(@Path('cache_id') int cacheId);

  @DELETE('/caches/{cache_id}/tags')
  Future<Success?> deleteCacheTags(
    @Path('cache_id') int cacheId,
  );

  @GET('/caches/public')
  Future<List<Cache?>> listPublicCaches(
    @Query('page_size') int pageSize,
    @Query('page_id') int pageId,
    @Query('tag_ids') List<int> tagIds,
  );
}

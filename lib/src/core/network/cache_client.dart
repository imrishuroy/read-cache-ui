import 'package:dio/dio.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
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
  Future<AppUserDto?> getUser(@Path('id') String? id);

  @POST('/users')
  Future<AppUserDto?> createUser(
    @Body() CreateUserReqDto createUserReqDto,
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
}

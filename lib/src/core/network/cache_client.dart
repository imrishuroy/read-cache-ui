import 'package:dio/dio.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
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
  Future<CacheDto?> createCache(@Body() CacheDto cacheDto);

  @GET('/caches?page_size={page_size}&page_id={page_id}')
  Future<List<CacheDto?>> listCaches(
    @Path('page_size') int pageSize,
    @Path('page_id') int pageId,
  );

  @PUT('/caches')
  Future<CacheDto?> updateCache(@Body() CacheDto cacheDto);

  @DELETE('/caches/{id}')
  Future<void> deleteCache(@Path('id') int id);
}

import 'package:dio/dio.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'read_cache_client.g.dart';

@RestApi()
abstract class ReadCacheClient {
  factory ReadCacheClient(
    Dio dio, {
    String baseUrl,
  }) = _ReadCacheClient;

  @GET('/')
  Future<String> ping();

  @GET('/users/{id}')
  Future<AppUserDto?> getUser(@Path('id') String? id);

  @POST('/users')
  Future<AppUserDto?> createUser(
    @Body() CreateUserReqDto createUserReqDto,
  );

  @GET('/caches?page_size={page_size}&page_id={page_id}')
  Future<List<CacheDto?>> listCaches(
    @Path('page_size') int pageSize,
    @Path('page_id') int pageId,
  );
}

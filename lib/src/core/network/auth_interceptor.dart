import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString('token');
    debugPrint('token from inceptor $token');
    if (token != null) {
      options.headers.addAll({
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        //'Access-Control-Allow-Origin': '*',
      });
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // final prefs = getIt<SharedPreferences>();
    // final refreshToken = response.headers.value('token');
    // if (refreshToken != null) {
    //   prefs.setString('accessToken', refreshToken);
    // }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint(
      'Error in API Code: ${err.response?.statusCode}, '
      'Message: ${err.message}',
    );
    super.onError(err, handler);

    if (err.response?.statusCode == 401) {
      // perform logout
    }
  }
}

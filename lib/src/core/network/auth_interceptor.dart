import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:read_cache_ui/src/core/config/logout_manager.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = SharedPrefs.getToken();
    //  debugPrint('token from inceptor $token');
    if (token != null) {
      options.headers.addAll(
        {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
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
      'Error code: ${err.response?.statusCode}, '
      'Message: ${err.message}',
    );

    if (err.response?.statusCode == 401) {
      await LogoutManager.performLogout();
    }
    super.onError(err, handler);
  }
}

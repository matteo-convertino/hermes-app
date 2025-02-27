import 'dart:io';

import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.token});

  final String token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    super.onRequest(options, handler);
  }
}
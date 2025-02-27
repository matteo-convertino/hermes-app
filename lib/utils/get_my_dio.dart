import 'package:dio/dio.dart';
import 'package:hermes_app/utils/token_inteceptor.dart';

Dio getMyDio({String? token, String baseUrl = ''}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      /*validateStatus: (int? status) {
        return status != null;
        // return status != null && status >= 200 && status < 300;
      },*/
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  if (token != null) dio.interceptors.add(TokenInterceptor(token: token));

  return dio;
}

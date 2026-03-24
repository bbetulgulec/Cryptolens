import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = dotenv.env['token'];

    if (token != null && token.isNotEmpty) {
      options.headers['x-access-token'] = token;
    }

    handler.next(options);
  }
}
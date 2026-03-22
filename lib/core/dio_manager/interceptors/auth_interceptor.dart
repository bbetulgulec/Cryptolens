import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
   String token="coinranking45bf7a5bd24f32a61759217361ab0d9baf9c9e62546f2b96";

  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token.isNotEmpty) {
      options.headers['x-access-token'] = token;
    }
    handler.next(options);
  }
}

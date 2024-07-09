import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(String baseUrl, String token)
      : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }
}

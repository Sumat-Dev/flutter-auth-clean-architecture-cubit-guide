import 'package:dio/dio.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.enableLogging = true});
  final bool enableLogging;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enableLogging) {
      // print('''
      // REQUEST[${options.method}]
      // PATH: ${options.path}
      // BASE_URL: ${options.baseUrl}
      // HEADERS: ${options.headers}
      // DATA: ${options.data}
      // QUERY_PARAMS: ${options.queryParameters}
      // ''');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (enableLogging) {
      // print('''
      // RESPONSE[${response.statusCode}]
      // PATH: ${response.requestOptions.path}
      // DATA: ${response.data}
      // HEADERS: ${response.headers}
      // ''');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enableLogging) {
      // print('''
      // ERROR[${err.response?.statusCode}]
      // PATH: ${err.requestOptions.path}
      // MESSAGE: ${err.message}
      // DATA: ${err.response?.data}
      // TYPE: ${err.type}
      // ''');
    }
    return handler.next(err);
  }
}

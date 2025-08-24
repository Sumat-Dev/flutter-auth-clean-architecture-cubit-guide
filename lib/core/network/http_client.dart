import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';

/// Interface for HTTP client operations
abstract class HttpClient {
  /// Performs a GET request
  Future<Result<Response<dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// Performs a POST request
  Future<Result<Response<dynamic>>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// Performs a PUT request
  Future<Result<Response<dynamic>>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// Performs a DELETE request
  Future<Result<Response<dynamic>>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Performs a PATCH request
  Future<Result<Response<dynamic>>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}

/// Implementation of HTTP client using Dio
class HttpClientImpl implements HttpClient {
  HttpClientImpl({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    AuthInterceptor? authInterceptor,
    LoggingInterceptor? loggingInterceptor,
  }) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = connectTimeout ?? const Duration(seconds: 30);
    _dio.options.receiveTimeout = receiveTimeout ?? const Duration(seconds: 30);
    _dio.options.sendTimeout = sendTimeout ?? const Duration(seconds: 30);

    // Add interceptors
    if (loggingInterceptor != null) {
      _dio.interceptors.add(loggingInterceptor);
    }

    if (authInterceptor != null) {
      _dio.interceptors.add(authInterceptor);
    }
  }
  final Dio _dio;

  @override
  Future<Result<Response<dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ErrorMapper.mapException(e));
    }
  }

  @override
  Future<Result<Response<dynamic>>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ErrorMapper.mapException(e));
    }
  }

  @override
  Future<Result<Response<dynamic>>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ErrorMapper.mapException(e));
    }
  }

  @override
  Future<Result<Response<dynamic>>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ErrorMapper.mapException(e));
    }
  }

  @override
  Future<Result<Response<dynamic>>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ErrorMapper.mapException(e));
    }
  }
}

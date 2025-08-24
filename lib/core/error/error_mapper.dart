import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';

/// Maps exceptions to domain-level failures
class ErrorMapper {
  /// Maps DioException to appropriate domain failures
  static Failure mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');

      case DioExceptionType.badResponse:
        return _mapResponseError(exception.response);

      case DioExceptionType.cancel:
        return const NetworkFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Invalid certificate');

      case DioExceptionType.unknown:
        return const UnknownFailure('An unknown network error occurred');
    }
  }

  /// Maps HTTP response errors to domain failures
  static Failure _mapResponseError(Response<dynamic>? response) {
    if (response == null) {
      return const NetworkFailure('No response received');
    }

    switch (response.statusCode) {
      case 400:
        return const ValidationFailure('Bad request');

      case 401:
        return const AuthFailure('Unauthorized');

      case 403:
        return const AuthFailure('Forbidden');

      case 404:
        return const UserNotFoundFailure('Resource not found');

      case 409:
        return const UserAlreadyExistsFailure('Resource already exists');

      case 422:
        return const ValidationFailure();

      case 500:
        return const ServerFailure('Internal server error');

      case 502:
        return const ServerFailure('Bad gateway');

      case 503:
        return const ServerFailure('Service unavailable');

      default:
        return NetworkFailure(
          'HTTP ${response.statusCode}: ${response.statusMessage}',
        );
    }
  }

  /// Maps general exceptions to domain failures
  static Failure mapException(dynamic exception) {
    if (exception is DioException) {
      return mapDioException(exception);
    }

    if (exception is FormatException) {
      return const ValidationFailure('Invalid data format');
    }

    if (exception is ArgumentError) {
      return const ValidationFailure('Invalid argument');
    }

    return const UnknownFailure('An unexpected error occurred');
  }
}

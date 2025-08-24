import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/constants/app_keys.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/storage/secure_storage.dart';

/// Interceptor for handling authentication headers and token refresh
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);
  final SecureStorage _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for login and register endpoints
    if (options.path.contains('/auth/login') ||
        options.path.contains('/auth/register')) {
      return handler.next(options);
    }

    // Add authorization header if token exists
    final token = await _secureStorage.read(AppKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid, try to refresh
      final refreshToken = await _secureStorage.read(AppKeys.refreshToken);

      if (refreshToken != null) {
        try {
          // Attempt to refresh the token
          final response = await Dio().post<dynamic>(
            '${err.requestOptions.baseUrl}/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final data = response.data as Map<String, dynamic>;
            final newAccessToken = data['access_token'] as String;
            final newRefreshToken = data['refresh_token'] as String;

            // Store new tokens
            await _secureStorage.write(AppKeys.accessToken, newAccessToken);
            await _secureStorage.write(AppKeys.refreshToken, newRefreshToken);

            // Retry the original request with new token
            final originalRequest = err.requestOptions;
            originalRequest.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await Dio().fetch<dynamic>(originalRequest);
            return handler.resolve(retryResponse);
          }
        } on Exception catch (_) {
          // Refresh failed, clear tokens and redirect to login
          await _secureStorage.deleteAll();
          // You might want to emit an event here
          // to notify the app to redirect to login
        }
      } else {
        // No refresh token, clear all tokens
        await _secureStorage.deleteAll();
      }
    }

    return handler.next(err);
  }
}

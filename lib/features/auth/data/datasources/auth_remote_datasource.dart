import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/http_client.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/user_model.dart';

/// Remote data source for authentication operations
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<Result<AuthTokensModel>> login(String email, String password);

  /// Register a new user
  Future<Result<AuthTokensModel>> register({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  });

  /// Refresh the access token
  Future<Result<AuthTokensModel>> refreshToken(String refreshToken);

  /// Get the current authenticated user
  Future<Result<UserModel>> getCurrentUser();

  /// Logout the current user
  Future<Result<void>> logout();
}

/// Implementation of auth remote data source
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  const AuthRemoteDataSourceImpl(this._httpClient);
  final HttpClient _httpClient;

  @override
  Future<Result<AuthTokensModel>> login(String email, String password) async {
    final response = await _httpClient.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.isSuccess) {
      try {
        final data = response.value.data as Map<String, dynamic>;
        final tokens = AuthTokensModel.fromJson(data);
        return Result.success(tokens);
      } on Exception catch (e) {
        return Result.failure(
          ValidationFailure('Invalid response format: $e'),
        );
      }
    }

    return Result.failure(response.failure);
  }

  @override
  Future<Result<AuthTokensModel>> register({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  }) async {
    final response = await _httpClient.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        if (displayName != null) 'display_name': displayName,
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      },
    );

    if (response.isSuccess) {
      try {
        final data = response.value.data as Map<String, dynamic>;
        final tokens = AuthTokensModel.fromJson(data);
        return Result.success(tokens);
      } on Exception catch (e) {
        return Result.failure(
          ValidationFailure('Invalid response format: $e'),
        );
      }
    }

    return Result.failure(response.failure);
  }

  @override
  Future<Result<AuthTokensModel>> refreshToken(String refreshToken) async {
    final response = await _httpClient.post(
      '/auth/refresh',
      data: {
        'refresh_token': refreshToken,
      },
    );

    if (response.isSuccess) {
      try {
        final data = response.value.data as Map<String, dynamic>;
        final tokens = AuthTokensModel.fromJson(data);
        return Result.success(tokens);
      } on Exception catch (e) {
        return Result.failure(
          ValidationFailure('Invalid response format: $e'),
        );
      }
    }

    return Result.failure(response.failure);
  }

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    final response = await _httpClient.get('/auth/me');

    if (response.isSuccess) {
      try {
        final data = response.value.data as Map<String, dynamic>;
        final user = UserModel.fromJson(data);
        return Result.success(user);
      } on Exception catch (e) {
        return Result.failure(
          ValidationFailure('Invalid response format: $e'),
        );
      }
    }

    return Result.failure(response.failure);
  }

  @override
  Future<Result<void>> logout() async {
    final response = await _httpClient.post('/auth/logout');

    if (response.isSuccess) {
      return const Result.success(null);
    }

    return Result.failure(response.failure);
  }
}

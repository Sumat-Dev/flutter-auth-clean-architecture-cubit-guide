import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/storage/key_value_store.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/storage/secure_storage.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/user_model.dart';

/// Local data source for authentication operations
abstract class AuthLocalDataSource {
  /// Store authentication tokens
  Future<Result<void>> storeTokens(AuthTokensModel tokens);

  /// Get stored authentication tokens
  Future<Result<AuthTokensModel?>> getStoredTokens();

  /// Clear stored tokens
  Future<Result<void>> clearTokens();

  /// Store user data
  Future<Result<void>> storeUser(UserModel user);

  /// Get stored user data
  Future<Result<UserModel?>> getStoredUser();

  /// Clear stored user data
  Future<Result<void>> clearUser();

  /// Check if user is logged in
  Future<Result<bool>> isLoggedIn();
}

/// Implementation of auth local data source
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._secureStorage, this._keyValueStore);
  final SecureStorage _secureStorage;
  final KeyValueStore _keyValueStore;

  @override
  Future<Result<void>> storeTokens(AuthTokensModel tokens) async {
    try {
      await _secureStorage.write('access_token', tokens.accessToken);
      await _secureStorage.write('refresh_token', tokens.refreshToken);
      await _secureStorage.write(
        'token_expiry',
        tokens.expiresAt.toIso8601String(),
      );
      await _keyValueStore.setBool('is_logged_in', value: true);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(StorageFailure('Failed to store tokens: $e'));
    }
  }

  @override
  Future<Result<AuthTokensModel?>> getStoredTokens() async {
    try {
      final accessToken = await _secureStorage.read('access_token');
      final refreshToken = await _secureStorage.read('refresh_token');
      final expiryString = await _secureStorage.read('token_expiry');

      if (accessToken == null || refreshToken == null || expiryString == null) {
        return const Result.success(null);
      }

      final expiry = DateTime.parse(expiryString);
      final tokens = AuthTokensModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: expiry,
      );

      return Result.success(tokens);
    } on Exception catch (e) {
      return Result.failure(StorageFailure('Failed to retrieve tokens: $e'));
    }
  }

  @override
  Future<Result<void>> clearTokens() async {
    try {
      await _secureStorage.delete('access_token');
      await _secureStorage.delete('refresh_token');
      await _secureStorage.delete('token_expiry');
      await _keyValueStore.setBool('is_logged_in', false);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(StorageFailure('Failed to clear tokens: $e'));
    }
  }

  @override
  Future<Result<void>> storeUser(UserModel user) async {
    try {
      await _keyValueStore.setString('user_id', value: user.id ?? '');
      await _keyValueStore.setString('user_email', value: user.email ?? '');
      if (user.displayName != null) {
        await _keyValueStore.setString(
          'user_display_name',
          value: user.displayName!,
        );
      }
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(StorageFailure('Failed to store user data: $e'));
    }
  }

  @override
  Future<Result<UserModel?>> getStoredUser() async {
    try {
      final id = _keyValueStore.getString('user_id');
      final email = _keyValueStore.getString('user_email');
      final displayName = _keyValueStore.getString('user_display_name');

      if (id == null || email == null) {
        return const Result.success(null);
      }

      final user = UserModel(
        id: id,
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(), // Default value
      );

      return Result.success(user);
    } on Exception catch (e) {
      return Result.failure(StorageFailure('Failed to retrieve user data: $e'));
    }
  }

  @override
  Future<Result<void>> clearUser() async {
    try {
      await _keyValueStore.remove('user_id');
      await _keyValueStore.remove('user_email');
      await _keyValueStore.remove('user_display_name');
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(
        StorageFailure('Failed to clear user data: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    try {
      final isLoggedIn = _keyValueStore.getBool('is_logged_in') ?? false;
      return Result.success(isLoggedIn);
    } on Exception catch (e) {
      return Result.failure(
        StorageFailure('Failed to check login status: $e'),
      );
    }
  }
}

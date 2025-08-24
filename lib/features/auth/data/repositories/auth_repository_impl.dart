import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of auth repository
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<AuthTokens>> login(String email, String password) async {
    try {
      final result = await _remoteDataSource.login(email, password);

      if (result.isSuccess) {
        final tokens = result.value;
        await _localDataSource.storeTokens(tokens);

        // Get user data from the current user endpoint
        final userResult = await _remoteDataSource.getCurrentUser();
        if (userResult.isSuccess) {
          await _localDataSource.storeUser(userResult.value);
        }

        return Result.success(tokens.toEntity());
      }

      return Result.failure(result.failure);
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Login failed: $e'));
    }
  }

  @override
  Future<Result<AuthTokens>> register({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final result = await _remoteDataSource.register(
        email: email,
        password: password,
        displayName: displayName,
        firstName: firstName,
        lastName: lastName,
      );

      if (result.isSuccess) {
        final tokens = result.value;
        await _localDataSource.storeTokens(tokens);

        // Get user data from the current user endpoint
        final userResult = await _remoteDataSource.getCurrentUser();
        if (userResult.isSuccess) {
          await _localDataSource.storeUser(userResult.value);
        }

        return Result.success(tokens.toEntity());
      }

      return Result.failure(result.failure);
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Registration failed: $e'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      // Call remote logout
      await _remoteDataSource.logout();

      // Clear local data
      await _localDataSource.clearTokens();
      await _localDataSource.clearUser();

      return const Result.success(null);
    } on Exception catch (e) {
      // Even if remote logout fails, clear local data
      await _localDataSource.clearTokens();
      await _localDataSource.clearUser();
      return Result.failure(UnknownFailure('Logout failed: $e'));
    }
  }

  @override
  Future<Result<AuthTokens>> refreshToken() async {
    try {
      final storedTokens = await _localDataSource.getStoredTokens();

      if (storedTokens.isSuccess && storedTokens.value != null) {
        final refreshToken = storedTokens.value!.refreshToken;
        final result = await _remoteDataSource.refreshToken(refreshToken);

        if (result.isSuccess) {
          final newTokens = result.value;
          await _localDataSource.storeTokens(newTokens);
          return Result.success(newTokens.toEntity());
        }

        return Result.failure(result.failure);
      }

      return const Result.failure(TokenFailure('No refresh token available'));
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Token refresh failed: $e'));
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      // Try to get from local storage first
      final localUser = await _localDataSource.getStoredUser();

      if (localUser.isSuccess && localUser.value != null) {
        return Result.success(localUser.value!.toEntity());
      }

      // If not in local storage, try to get from remote
      final remoteUser = await _remoteDataSource.getCurrentUser();

      if (remoteUser.isSuccess) {
        final user = remoteUser.value;
        await _localDataSource.storeUser(user);
        return Result.success(user.toEntity());
      }

      return Result.failure(remoteUser.failure);
    } on Exception catch (e) {
      return Result.failure(
        UnknownFailure('Failed to get current user: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    try {
      final result = await _localDataSource.isLoggedIn();

      if (result.isSuccess && result.value == true) {
        // Check if tokens are still valid
        final tokens = await _localDataSource.getStoredTokens();

        if (tokens.isSuccess && tokens.value != null) {
          final authTokens = tokens.value!.toEntity();
          return Result.success(!authTokens.isExpired);
        }

        return const Result.success(false);
      }

      return result;
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Failed to check login status: $e'));
    }
  }

  @override
  Future<Result<AuthTokens?>> getStoredTokens() async {
    try {
      final result = await _localDataSource.getStoredTokens();

      if (result.isSuccess) {
        return Result.success(result.value?.toEntity());
      }

      return Result.failure(result.failure);
    } on Exception catch (e) {
      return Result.failure(
        UnknownFailure('Failed to get stored tokens: $e'),
      );
    }
  }

  @override
  Future<Result<void>> storeTokens(AuthTokens tokens) async {
    try {
      final tokensModel = AuthTokensModel.fromEntity(tokens);
      return await _localDataSource.storeTokens(tokensModel);
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Failed to store tokens: $e'));
    }
  }

  @override
  Future<Result<void>> clearTokens() async {
    try {
      return await _localDataSource.clearTokens();
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Failed to clear tokens: $e'));
    }
  }

  @override
  Future<Result<User>> updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) async {
    // This would typically call a remote API to update the profile
    // For now, we'll just update the local storage
    try {
      final currentUser = await getCurrentUser();

      if (currentUser.isSuccess) {
        final updatedUser = currentUser.value.copyWith(
          displayName: displayName,
          firstName: firstName,
          lastName: lastName,
          avatarUrl: avatarUrl,
        );

        final userModel = UserModel.fromEntity(updatedUser);
        await _localDataSource.storeUser(userModel);

        return Result.success(updatedUser);
      }

      return Result.failure(currentUser.failure);
    } on Exception catch (e) {
      return Result.failure(
        UnknownFailure('Failed to update profile: $e'),
      );
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // This would typically call a remote API to change the password
    // For now, we'll just return success
    return const Result.success(null);
  }

  @override
  Future<Result<void>> requestPasswordReset(String email) async {
    // This would typically call a remote API to request password reset
    // For now, we'll just return success
    return const Result.success(null);
  }

  @override
  Future<Result<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // This would typically call a remote API to reset the password
    // For now, we'll just return success
    return const Result.success(null);
  }

  @override
  Future<Result<void>> verifyEmail(String token) async {
    // This would typically call a remote API to verify the email
    // For now, we'll just return success
    return const Result.success(null);
  }

  @override
  Future<Result<void>> resendEmailVerification() async {
    // This would typically call a remote API to resend email verification
    // For now, we'll just return success
    return const Result.success(null);
  }
}

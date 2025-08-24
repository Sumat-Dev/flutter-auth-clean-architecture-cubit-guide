import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/user.dart';

/// Repository interface for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<Result<AuthTokens>> login(String email, String password);
  
  /// Register a new user
  Future<Result<AuthTokens>> register({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  });
  
  /// Logout the current user
  Future<Result<void>> logout();
  
  /// Refresh the access token
  Future<Result<AuthTokens>> refreshToken();
  
  /// Get the current authenticated user
  Future<Result<User>> getCurrentUser();
  
  /// Check if the user is currently logged in
  Future<Result<bool>> isLoggedIn();
  
  /// Get stored auth tokens
  Future<Result<AuthTokens?>> getStoredTokens();
  
  /// Store auth tokens
  Future<Result<void>> storeTokens(AuthTokens tokens);
  
  /// Clear stored tokens
  Future<Result<void>> clearTokens();
  
  /// Update user profile
  Future<Result<User>> updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  });
  
  /// Change password
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  
  /// Request password reset
  Future<Result<void>> requestPasswordReset(String email);
  
  /// Reset password with token
  Future<Result<void>> resetPassword({
    required String token,
    required String newPassword,
  });
  
  /// Verify email with token
  Future<Result<void>> verifyEmail(String token);
  
  /// Resend email verification
  Future<Result<void>> resendEmailVerification();
}

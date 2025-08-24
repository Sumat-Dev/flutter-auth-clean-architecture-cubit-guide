import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/state/cubit/auth_state.dart';

/// Cubit for managing authentication state
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required IsLoggedInUseCase isLoggedInUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _isLoggedInUseCase = isLoggedInUseCase,
       super(const AuthInitial());
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;

  /// Check if user is logged in on app start
  Future<void> checkAuthStatus() async {
    emit(const AuthChecking());

    try {
      final result = await _isLoggedInUseCase();

      if (result.isSuccess) {
        if (result.value) {
          await _loadCurrentUser();
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Failed to check authentication status $e'));
    }
  }

  /// Login with email and password
  Future<void> login(String email, String password) async {
    emit(const AuthLoginLoading());

    try {
      final result = await _loginUseCase(email, password);

      if (result.isSuccess) {
        // final tokens = result.value;
        // Store tokens in local storage and navigate to home screen
        await _loadCurrentUser();
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Login failed $e'));
    }
  }

  /// Register a new user
  Future<void> register({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  }) async {
    emit(const AuthRegisterLoading());

    try {
      final result = await _registerUseCase(
        email: email,
        password: password,
        displayName: displayName,
        firstName: firstName,
        lastName: lastName,
      );

      if (result.isSuccess) {
        // final tokens = result.value;
        // Store tokens in local storage and navigate to home screen
        await _loadCurrentUser();
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Registration failed $e'));
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    emit(const AuthLogoutLoading());

    try {
      final result = await _logoutUseCase();

      if (result.isSuccess) {
        emit(const AuthUnauthenticated());
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Logout failed $e'));
    }
  }

  /// Refresh the access token
  Future<void> refreshToken() async {
    emit(const AuthRefreshLoading());

    try {
      final result = await _refreshTokenUseCase();

      if (result.isSuccess) {
        // final tokens = result.value;
        await _loadCurrentUser();
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Token refresh failed $e'));
    }
  }

  /// Load the current user
  Future<void> _loadCurrentUser() async {
    try {
      final result = await _getCurrentUserUseCase();

      if (result.isSuccess) {
        final user = result.value;
        // For now, we'll create a mock AuthTokens since
        // we don't have them in the user entity
        // In a real app, you'd store and retrieve the tokens separately
        final tokens = AuthTokens(
          accessToken: 'mock_token',
          refreshToken: 'mock_refresh_token',
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );

        emit(AuthAuthenticated(user: user, tokens: tokens));
      } else {
        emit(AuthError(message: result.failure.message));
      }
    } on Exception catch (e) {
      emit(AuthError(message: 'Failed to load current user $e'));
    }
  }

  /// Clear any error state
  void clearError() {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }
}

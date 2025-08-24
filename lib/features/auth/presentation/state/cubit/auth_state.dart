import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/user.dart';

/// Base class for authentication states
abstract class AuthState extends Equatable {
  const AuthState();
}

/// Initial state when the app starts
class AuthInitial extends AuthState {
  const AuthInitial();
  
  @override
  List<Object?> get props => [];
}

/// Loading state during authentication operations
class AuthLoading extends AuthState {
  const AuthLoading();
  
  @override
  List<Object?> get props => [];
}

/// State when user is authenticated
class AuthAuthenticated extends AuthState {
  
  const AuthAuthenticated({
    required this.user,
    required this.tokens,
  });
  final User user;
  final AuthTokens tokens;
  
  @override
  List<Object?> get props => [user, tokens];
}

/// State when user is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
  
  @override
  List<Object?> get props => [];
}

/// State when authentication fails
class AuthError extends AuthState {
  
  const AuthError({
    required this.message,
    this.code,
  });
  final String message;
  final String? code;
  
  @override
  List<Object?> get props => [message, code];
}

/// State during login process
class AuthLoginLoading extends AuthState {
  const AuthLoginLoading();
  
  @override
  List<Object?> get props => [];
}

/// State during registration process
class AuthRegisterLoading extends AuthState {
  const AuthRegisterLoading();
  
  @override
  List<Object?> get props => [];
}

/// State during logout process
class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading();
  
  @override
  List<Object?> get props => [];
}

/// State during token refresh process
class AuthRefreshLoading extends AuthState {
  const AuthRefreshLoading();
  
  @override
  List<Object?> get props => [];
}

/// State when checking authentication status
class AuthChecking extends AuthState {
  const AuthChecking();
  
  @override
  List<Object?> get props => [];
}

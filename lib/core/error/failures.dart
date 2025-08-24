import 'package:equatable/equatable.dart';

/// Base class for all domain-level failures
abstract class Failure extends Equatable {
  const Failure([this.message = 'An error occurred']);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Failure that occurs during network operations
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

/// Failure that occurs during authentication
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

/// Failure that occurs when credentials are invalid
class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([super.message = 'Invalid credentials']);
}

/// Failure that occurs when a user is not found
class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure([super.message = 'User not found']);
}

/// Failure that occurs when a user already exists
class UserAlreadyExistsFailure extends Failure {
  const UserAlreadyExistsFailure([super.message = 'User already exists']);
}

/// Failure that occurs when a token is invalid or expired
class TokenFailure extends Failure {
  const TokenFailure([super.message = 'Token is invalid or expired']);
}

/// Failure that occurs during local storage operations
class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Storage operation failed']);
}

/// Failure that occurs when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Failure that occurs when a server error happens
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Failure that occurs when an unknown error happens
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}

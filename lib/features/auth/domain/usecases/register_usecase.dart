import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user registration
class RegisterUseCase {
  const RegisterUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the register use case
  Future<Result<AuthTokens>> call({
    required String email,
    required String password,
    String? displayName,
    String? firstName,
    String? lastName,
  }) async {
    try {
      return await _authRepository.register(
        email: email,
        password: password,
        displayName: displayName,
        firstName: firstName,
        lastName: lastName,
      );
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Registration failed $e'));
    }
  }
}

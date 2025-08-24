import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user login
class LoginUseCase {
  const LoginUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the login use case
  Future<Result<AuthTokens>> call(String email, String password) async {
    try {
      return await _authRepository.login(email, password);
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Login failed $e'));
    }
  }
}

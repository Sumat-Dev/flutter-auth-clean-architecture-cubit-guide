import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for refreshing authentication tokens
class RefreshTokenUseCase {
  const RefreshTokenUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the refresh token use case
  Future<Result<AuthTokens>> call() async {
    try {
      return await _authRepository.refreshToken();
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Token refresh failed $e'));
    }
  }
}

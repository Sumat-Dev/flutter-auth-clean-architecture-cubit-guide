import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user logout
class LogoutUseCase {
  const LogoutUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the logout use case
  Future<Result<void>> call() async {
    try {
      return await _authRepository.logout();
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Logout failed $e'));
    }
  }
}

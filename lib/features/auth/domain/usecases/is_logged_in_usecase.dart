import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for checking if user is logged in
class IsLoggedInUseCase {
  const IsLoggedInUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the is logged in use case
  Future<Result<bool>> call() async {
    try {
      return await _authRepository.isLoggedIn();
    } on Exception catch (e) {
      return Result.failure(
        UnknownFailure('Failed to check login status $e'),
      );
    }
  }
}

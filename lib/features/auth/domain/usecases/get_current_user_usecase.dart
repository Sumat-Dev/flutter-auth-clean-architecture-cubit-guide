import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/utils/result.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';

/// Use case for getting the current authenticated user
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._authRepository);
  final AuthRepository _authRepository;

  /// Execute the get current user use case
  Future<Result<User>> call() async {
    try {
      return await _authRepository.getCurrentUser();
    } on Exception catch (e) {
      return Result.failure(UnknownFailure('Failed to get current user $e'));
    }
  }
}

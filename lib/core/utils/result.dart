import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/error/failures.dart';

/// A functional programming Result type that represents either success or failure
sealed class Result<T> extends Equatable {
  const Result();

  /// Creates a success result with the given value
  const factory Result.success(T value) = Success<T>;

  /// Creates a failure result with the given failure
  const factory Result.failure(Failure failure) = FailureResult<T>;

  /// Returns true if this is a success result
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failure result
  bool get isFailure => this is FailureResult<T>;

  /// Gets the success value, or throws if this is a failure
  T get value => switch (this) {
    Success(value: final v) => v,
    FailureResult() => throw StateError('Cannot get value from failure result'),
  };

  /// Gets the failure, or throws if this is a success
  Failure get failure => switch (this) {
    Success() => throw StateError('Cannot get failure from success result'),
    FailureResult(failure: final f) => f,
  };

  /// Maps the success value using the given function
  Result<R> map<R>(R Function(T value) mapper) => switch (this) {
    Success(value: final v) => Result.success(mapper(v)),
    FailureResult(failure: final f) => Result.failure(f),
  };

  /// Maps the success value using the given async function
  Future<Result<R>> mapAsync<R>(Future<R> Function(T value) mapper) async =>
      switch (this) {
        Success(value: final v) => Result.success(await mapper(v)),
        FailureResult(failure: final f) => Result.failure(f),
      };

  /// Flat maps the success value using the given function
  Result<R> flatMap<R>(Result<R> Function(T value) mapper) => switch (this) {
    Success(value: final v) => mapper(v),
    FailureResult(failure: final f) => Result.failure(f),
  };

  /// Executes the given function if this is a success
  Result<T> onSuccess(void Function(T value) action) {
    if (this is Success<T>) {
      action((this as Success<T>).value);
    }
    return this;
  }

  /// Executes the given function if this is a failure
  Result<T> onFailure(void Function(Failure failure) action) {
    if (this is FailureResult<T>) {
      action((this as FailureResult<T>).failure);
    }
    return this;
  }

  @override
  List<Object?> get props => [];
}

/// A success result containing a value
class Success<T> extends Result<T> {
  const Success(this.value);
  @override
  final T value;

  @override
  List<Object?> get props => [value];
}

/// A failure result containing a failure
class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);
  @override
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

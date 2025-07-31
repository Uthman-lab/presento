import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Base failure class for the application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server failure for API and Firebase related errors
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Cache failure for local storage errors
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Network failure for connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

/// Validation failure for input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Authentication failure for login/auth errors
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

/// Permission failure for access control errors
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied']);
}

/// Extension to handle Either&lt;Failure, T&gt; consistently
extension EitherExtensions<L, R> on Either<L, R> {
  R getRight() => (this as Right<L, R>).value;
  L getLeft() => (this as Left<L, R>).value;

  /// For use in UI to map to different widgets based on success/failure
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold((l) => failure(l), (r) => success(r));
  }

  /// Simplify chaining operations that can fail
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold((l) => Left(l), (r) => f(r));
  }
}

part of '../core.dart';

/// Base class for Firebase data sources that provides centralized
/// Firebase exception handling and conversion to custom exceptions.
abstract class FirebaseBaseDataSource {
  /// Executes a Firebase operation and converts any Firebase exceptions
  /// to custom exceptions before they reach the repository layer.
  @protected
  Future<T> executeFirebaseOperation<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } on FirebaseFunctionsException catch (e) {
      throw handleFirebaseFunctionsException(e);
    } on FirebaseException catch (e) {
      throw handleFirebaseException(e);
    }
  }

  /// Converts FirebaseAuthException to AuthException with appropriate error messages.
  @protected
  AuthException handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthException(message: 'No user found with this email');
      case 'wrong-password':
        return const AuthException(message: 'Incorrect password');
      case 'invalid-email':
        return const AuthException(message: 'Invalid email address');
      case 'user-disabled':
        return const AuthException(message: 'This account has been disabled');
      case 'too-many-requests':
        return const AuthException(
          message: 'Too many failed attempts. Please try again later',
        );
      case 'network-request-failed':
        return const AuthException(
          message: 'Network error. Please check your connection',
        );
      default:
        return AuthException(message: 'Authentication failed: ${e.message}');
    }
  }

  /// Converts FirebaseFunctionsException to AuthException or ServerException
  /// based on error codes.
  @protected
  Exception handleFirebaseFunctionsException(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'permission-denied':
        return AuthException(message: e.message ?? 'Permission denied');
      case 'already-exists':
        return AuthException(message: e.message ?? 'Resource already exists');
      case 'unauthenticated':
        return const AuthException(message: 'Authentication required');
      case 'not-found':
        return AuthException(message: e.message ?? 'Resource not found');
      case 'invalid-argument':
        return AuthException(
          message: e.message ?? 'Invalid arguments provided',
        );
      default:
        return ServerException(
          message: 'Firebase function error: ${e.message ?? e.code}',
        );
    }
  }

  /// Converts generic FirebaseException to ServerException.
  @protected
  ServerException handleFirebaseException(FirebaseException e) {
    return ServerException(message: 'Firebase error: ${e.message}');
  }
}

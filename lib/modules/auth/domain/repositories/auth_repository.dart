import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../entities/institution.dart';

/// Abstract interface for authentication operations
abstract class AuthRepository {
  /// Login with email, password, and institution
  Future<Either<Failure, User>> login(
    String email,
    String password,
    String institutionId,
  );

  /// Logout the current user
  Future<Either<Failure, Unit>> logout();

  /// Get the currently authenticated user
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();

  /// Get list of available institutions
  Future<Either<Failure, List<Institution>>> getInstitutions();

  /// Register a new user
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String name,
    String institutionId,
    String role,
  );

  /// Update user profile
  Future<Either<Failure, User>> updateProfile(User user);

  /// Change user password
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  );

  /// Reset password
  Future<Either<Failure, Unit>> resetPassword(String email);

  /// Refresh authentication token
  Future<Either<Failure, Unit>> refreshToken();
}

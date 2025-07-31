import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user login
class Login {
  final AuthRepository repository;

  Login(this.repository);

  /// Execute login with email, password, and institution
  Future<Either<Failure, User>> call(
    String email,
    String password,
    String institutionId,
  ) async {
    return await repository.login(email, password, institutionId);
  }
}

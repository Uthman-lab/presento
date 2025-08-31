import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for user logout
class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  /// Execute logout
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}

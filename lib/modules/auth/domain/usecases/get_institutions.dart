import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/institution.dart';
import '../repositories/auth_repository.dart';

/// Use case for getting available institutions
class GetInstitutions {
  final AuthRepository repository;

  GetInstitutions(this.repository);

  /// Execute get institutions
  Future<Either<Failure, List<Institution>>> call() async {
    return await repository.getInstitutions();
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/class.dart';
import '../repositories/class_repository.dart';

/// Use case for updating a class
class UpdateClass {
  final ClassRepository repository;

  UpdateClass(this.repository);

  /// Execute update class
  Future<Either<Failure, Unit>> call(
    String institutionId,
    Class updatedClass,
  ) async {
    return await repository.updateClass(institutionId, updatedClass);
  }
}

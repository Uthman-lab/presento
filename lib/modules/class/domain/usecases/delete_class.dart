import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/class_repository.dart';

/// Use case for deleting a class
class DeleteClass {
  final ClassRepository repository;

  DeleteClass(this.repository);

  /// Execute delete class
  Future<Either<Failure, Unit>> call(
    String institutionId,
    String classId,
  ) async {
    return await repository.deleteClass(institutionId, classId);
  }
}

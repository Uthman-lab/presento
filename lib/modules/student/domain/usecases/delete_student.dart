import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/student_repository.dart';

/// Use case for deleting a student
class DeleteStudent {
  final StudentRepository repository;

  DeleteStudent(this.repository);

  /// Execute delete student
  Future<Either<Failure, Unit>> call(
    String institutionId,
    String studentId,
  ) async {
    return await repository.deleteStudent(institutionId, studentId);
  }
}

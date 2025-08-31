import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

/// Use case for updating a student
class UpdateStudent {
  final StudentRepository repository;

  UpdateStudent(this.repository);

  /// Execute update student
  Future<Either<Failure, Unit>> call(
    String institutionId,
    Student updatedStudent,
  ) async {
    return await repository.updateStudent(institutionId, updatedStudent);
  }
}

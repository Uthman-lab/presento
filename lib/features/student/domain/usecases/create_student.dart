import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

/// Use case for creating a student
class CreateStudent {
  final StudentRepository repository;

  CreateStudent(this.repository);

  /// Execute create student
  Future<Either<Failure, Unit>> call(
    String institutionId,
    Student newStudent,
  ) async {
    return await repository.createStudent(institutionId, newStudent);
  }
}

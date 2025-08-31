import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

/// Use case for getting all students
class GetStudents {
  final StudentRepository repository;

  GetStudents(this.repository);

  /// Execute get students
  Future<Either<Failure, List<Student>>> call(
    String institutionId,
    String classId,
  ) async {
    return await repository.getStudents(institutionId, classId);
  }
}

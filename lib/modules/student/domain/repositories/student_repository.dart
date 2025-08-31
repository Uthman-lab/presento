import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student.dart';

/// Abstract interface for student operations
abstract class StudentRepository {
  /// Get all students for a class
  Future<Either<Failure, List<Student>>> getStudents(
    String institutionId,
    String classId,
  );

  /// Get a single student by ID
  Future<Either<Failure, Student>> getStudent(
    String institutionId,
    String studentId,
  );

  /// Create a new student
  Future<Either<Failure, Unit>> createStudent(
    String institutionId,
    Student newStudent,
  );

  /// Update an existing student
  Future<Either<Failure, Unit>> updateStudent(
    String institutionId,
    Student updatedStudent,
  );

  /// Delete a student
  Future<Either<Failure, Unit>> deleteStudent(
    String institutionId,
    String studentId,
  );
}

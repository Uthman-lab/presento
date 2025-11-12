part of '../domain.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<StudentEntity>>> getStudents(
    String institutionId, {
    String? classId,
  });

  Future<Either<Failure, StudentEntity>> getStudentById(
    String institutionId,
    String studentId,
  );

  Future<Either<Failure, StudentEntity>> createStudent(
    String institutionId,
    StudentEntity studentEntity,
  );

  Future<Either<Failure, StudentEntity>> updateStudent(
    String institutionId,
    String studentId,
    StudentEntity studentEntity,
  );

  Future<Either<Failure, void>> deleteStudent(
    String institutionId,
    String studentId,
  );
}



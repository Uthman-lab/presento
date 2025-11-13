part of '../domain.dart';

class UpdateStudentUseCase {
  final StudentRepository repository;

  UpdateStudentUseCase({required this.repository});

  Future<Either<Failure, StudentEntity>> call(
    String institutionId,
    String studentId,
    StudentEntity studentEntity,
  ) async {
    return await repository.updateStudent(
      institutionId,
      studentId,
      studentEntity,
    );
  }
}




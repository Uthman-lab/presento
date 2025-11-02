part of '../domain.dart';

class CreateStudentUseCase {
  final StudentRepository repository;

  CreateStudentUseCase({required this.repository});

  Future<Either<Failure, StudentEntity>> call(
    String institutionId,
    StudentEntity studentEntity,
  ) async {
    return await repository.createStudent(institutionId, studentEntity);
  }
}


part of '../domain.dart';

class GetStudentByIdUseCase {
  final StudentRepository repository;

  GetStudentByIdUseCase({required this.repository});

  Future<Either<Failure, StudentEntity>> call(
    String institutionId,
    String studentId,
  ) async {
    return await repository.getStudentById(institutionId, studentId);
  }
}




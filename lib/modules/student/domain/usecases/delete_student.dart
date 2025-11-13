part of '../domain.dart';

class DeleteStudentUseCase {
  final StudentRepository repository;

  DeleteStudentUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    String institutionId,
    String studentId,
  ) async {
    return await repository.deleteStudent(institutionId, studentId);
  }
}




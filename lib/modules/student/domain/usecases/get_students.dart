part of '../domain.dart';

class GetStudentsUseCase {
  final StudentRepository repository;

  GetStudentsUseCase({required this.repository});

  Future<Either<Failure, List<StudentEntity>>> call(
    String institutionId, {
    String? classId,
  }) async {
    return await repository.getStudents(institutionId, classId: classId);
  }
}



part of '../domain.dart';

class DeleteClassUseCase {
  final ClassRepository repository;

  DeleteClassUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    String institutionId,
    String classId,
  ) async {
    return await repository.deleteClass(institutionId, classId);
  }
}



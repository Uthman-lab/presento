part of '../domain.dart';

class GetClassByIdUseCase {
  final ClassRepository repository;

  GetClassByIdUseCase({required this.repository});

  Future<Either<Failure, ClassEntity>> call(
    String institutionId,
    String classId,
  ) async {
    return await repository.getClassById(institutionId, classId);
  }
}


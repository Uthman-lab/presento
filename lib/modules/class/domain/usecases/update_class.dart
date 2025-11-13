part of '../domain.dart';

class UpdateClassUseCase {
  final ClassRepository repository;

  UpdateClassUseCase({required this.repository});

  Future<Either<Failure, ClassEntity>> call(
    String institutionId,
    String classId,
    ClassEntity classEntity,
  ) async {
    return await repository.updateClass(institutionId, classId, classEntity);
  }
}




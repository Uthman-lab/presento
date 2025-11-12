part of '../domain.dart';

class CreateClassUseCase {
  final ClassRepository repository;

  CreateClassUseCase({required this.repository});

  Future<Either<Failure, ClassEntity>> call(
    String institutionId,
    ClassEntity classEntity,
  ) async {
    return await repository.createClass(institutionId, classEntity);
  }
}



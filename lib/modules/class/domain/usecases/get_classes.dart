part of '../domain.dart';

class GetClassesUseCase {
  final ClassRepository repository;

  GetClassesUseCase({required this.repository});

  Future<Either<Failure, List<ClassEntity>>> call(String institutionId) async {
    return await repository.getClasses(institutionId);
  }
}


part of '../domain.dart';

class CreateInstitutionUseCase {
  final InstitutionRepository repository;

  CreateInstitutionUseCase({required this.repository});

  Future<Either<Failure, Institution>> call(String name) async {
    return await repository.createInstitution(name);
  }
}


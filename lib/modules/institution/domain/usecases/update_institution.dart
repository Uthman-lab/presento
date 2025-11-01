part of '../domain.dart';

class UpdateInstitutionUseCase {
  final InstitutionRepository repository;

  UpdateInstitutionUseCase({required this.repository});

  Future<Either<Failure, Institution>> call(String institutionId, String name) async {
    return await repository.updateInstitution(institutionId, name);
  }
}


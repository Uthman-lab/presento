part of '../domain.dart';

class DeleteInstitutionUseCase {
  final InstitutionRepository repository;

  DeleteInstitutionUseCase({required this.repository});

  Future<Either<Failure, void>> call(String institutionId) async {
    return await repository.deleteInstitution(institutionId);
  }
}


part of '../domain.dart';

class SelectInstitutionUseCase {
  final InstitutionRepository repository;

  SelectInstitutionUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String userEmail,
    String? institutionId,
  }) async {
    return await repository.selectInstitution(userEmail, institutionId);
  }
}


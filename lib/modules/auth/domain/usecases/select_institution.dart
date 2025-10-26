part of '../domain.dart';

class SelectInstitutionUseCase {
  final AuthRepository repository;

  SelectInstitutionUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String userEmail,
    required String institutionId,
  }) async {
    return await repository.selectInstitution(userEmail, institutionId);
  }
}

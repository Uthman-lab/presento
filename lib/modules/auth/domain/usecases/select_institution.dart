part of '../domain.dart';

class SelectInstitutionUseCase {
  final AuthRepository repository;

  SelectInstitutionUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String userId,
    required String institutionId,
  }) async {
    return await repository.selectInstitution(userId, institutionId);
  }
}



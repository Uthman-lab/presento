part of '../domain.dart';

class GetInstitutionsUseCase {
  final InstitutionRepository repository;

  GetInstitutionsUseCase({required this.repository});

  Future<Either<Failure, List<Institution>>> call({
    required List<String> institutionIds,
  }) async {
    return await repository.getInstitutions(institutionIds);
  }
}


part of '../domain.dart';

class GetAllInstitutionsUseCase {
  final InstitutionRepository repository;

  GetAllInstitutionsUseCase({required this.repository});

  Future<Either<Failure, List<Institution>>> call() async {
    return await repository.getAllInstitutions();
  }
}


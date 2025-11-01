part of '../domain.dart';

class GetAllInstitutionsUseCase {
  final AuthRepository repository;

  GetAllInstitutionsUseCase({required this.repository});

  Future<Either<Failure, List<Institution>>> call() async {
    return await repository.getAllInstitutions();
  }
}


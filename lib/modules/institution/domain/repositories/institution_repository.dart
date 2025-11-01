part of '../domain.dart';

abstract class InstitutionRepository {
  Future<Either<Failure, List<Institution>>> getInstitutions(
    List<String> institutionIds,
  );

  Future<Either<Failure, List<Institution>>> getAllInstitutions();

  Future<Either<Failure, void>> selectInstitution(
    String userEmail,
    String? institutionId,
  );
}


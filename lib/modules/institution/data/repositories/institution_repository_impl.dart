part of '../data.dart';

class InstitutionRepositoryImpl extends BaseRepository
    implements InstitutionRepository {
  final InstitutionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  InstitutionRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Institution>>> getInstitutions(
    List<String> institutionIds,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getInstitutions(institutionIds);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, List<Institution>>> getAllInstitutions() async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getAllInstitutions();
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, void>> selectInstitution(
    String userEmail,
    String? institutionId,
  ) async {
    return executeWithErrorHandling(() async {
      await remoteDataSource.selectInstitution(userEmail, institutionId);
    }, networkInfo: networkInfo);
  }
}


part of '../data.dart';

class ClassRepositoryImpl extends BaseRepository implements ClassRepository {
  final ClassRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ClassRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ClassEntity>>> getClasses(
    String institutionId,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getClasses(institutionId);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, ClassEntity>> getClassById(
    String institutionId,
    String classId,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getClassById(institutionId, classId);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, ClassEntity>> createClass(
    String institutionId,
    ClassEntity classEntity,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.createClass(institutionId, classEntity);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, ClassEntity>> updateClass(
    String institutionId,
    String classId,
    ClassEntity classEntity,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.updateClass(
        institutionId,
        classId,
        classEntity,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, void>> deleteClass(
    String institutionId,
    String classId,
  ) async {
    return executeWithErrorHandling(() async {
      await remoteDataSource.deleteClass(institutionId, classId);
    }, networkInfo: networkInfo);
  }
}



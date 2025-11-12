part of '../data.dart';

class StudentRepositoryImpl extends BaseRepository
    implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StudentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents(
    String institutionId, {
    String? classId,
  }) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getStudents(
        institutionId,
        classId: classId,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentById(
    String institutionId,
    String studentId,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getStudentById(institutionId, studentId);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, StudentEntity>> createStudent(
    String institutionId,
    StudentEntity studentEntity,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.createStudent(
        institutionId,
        studentEntity,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, StudentEntity>> updateStudent(
    String institutionId,
    String studentId,
    StudentEntity studentEntity,
  ) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.updateStudent(
        institutionId,
        studentId,
        studentEntity,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, void>> deleteStudent(
    String institutionId,
    String studentId,
  ) async {
    return executeWithErrorHandling(() async {
      await remoteDataSource.deleteStudent(institutionId, studentId);
    }, networkInfo: networkInfo);
  }
}



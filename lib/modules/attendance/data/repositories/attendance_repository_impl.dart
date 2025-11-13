part of '../data.dart';

class AttendanceRepositoryImpl extends BaseRepository
    implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AttendanceEntity?>> getAttendanceByDate(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.getAttendanceByDate(
        institutionId,
        classId,
        date,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, List<AttendanceRecordEntity>>>
      getAttendanceRecords(
    String institutionId,
    String attendanceId,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.getAttendanceRecords(
        institutionId,
        attendanceId,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendanceHistory(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.getAttendanceHistory(
        institutionId,
        classId,
        startDate,
        endDate,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, AttendanceEntity>> markAttendance(
    String institutionId,
    AttendanceEntity attendance,
    List<AttendanceRecordEntity> records,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.markAttendance(
        institutionId,
        attendance,
        records,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, AttendanceRecordEntity>> updateAttendanceRecord(
    String institutionId,
    String attendanceId,
    AttendanceRecordEntity record,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.updateAttendanceRecord(
        institutionId,
        attendanceId,
        record,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, void>> submitAttendance(
    String institutionId,
    String attendanceId,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.submitAttendance(
        institutionId,
        attendanceId,
      ),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, void>> deleteAttendance(
    String institutionId,
    String attendanceId,
  ) async {
    return executeWithErrorHandling(
      () async => await remoteDataSource.deleteAttendance(
        institutionId,
        attendanceId,
      ),
      networkInfo: networkInfo,
    );
  }
}




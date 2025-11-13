part of '../domain.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, AttendanceEntity?>> getAttendanceByDate(
    String institutionId,
    String classId,
    DateTime date,
  );

  Future<Either<Failure, List<AttendanceRecordEntity>>> getAttendanceRecords(
    String institutionId,
    String attendanceId,
  );

  Future<Either<Failure, List<AttendanceEntity>>> getAttendanceHistory(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<Either<Failure, AttendanceEntity>> markAttendance(
    String institutionId,
    AttendanceEntity attendance,
    List<AttendanceRecordEntity> records,
  );

  Future<Either<Failure, AttendanceRecordEntity>> updateAttendanceRecord(
    String institutionId,
    String attendanceId,
    AttendanceRecordEntity record,
  );

  Future<Either<Failure, void>> submitAttendance(
    String institutionId,
    String attendanceId,
  );

  Future<Either<Failure, void>> deleteAttendance(
    String institutionId,
    String attendanceId,
  );
}




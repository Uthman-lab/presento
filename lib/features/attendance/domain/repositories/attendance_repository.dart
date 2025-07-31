import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance.dart';

/// Abstract interface for attendance repository
abstract class AttendanceRepository {
  /// Get attendance records for a specific class and date
  Future<Either<Failure, List<Attendance>>> getAttendance(
    String institutionId,
    String classId,
    DateTime date,
  );

  /// Submit attendance records for a class on a specific date
  Future<Either<Failure, Unit>> submitAttendance(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  );

  /// Get attendance records for a student
  Future<Either<Failure, List<Attendance>>> getStudentAttendance(
    String institutionId,
    String studentId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get attendance statistics for a class
  Future<Either<Failure, Map<String, dynamic>>> getAttendanceStats(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Check if attendance has already been submitted for a class on a date
  Future<Either<Failure, bool>> isAttendanceSubmitted(
    String institutionId,
    String classId,
    DateTime date,
  );

  Future<Either<Failure, List<Attendance>>> getAttendanceByDateRange(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );
}

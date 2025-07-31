import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// Use case to submit attendance records for a class
class SubmitAttendance {
  final AttendanceRepository repository;

  SubmitAttendance(this.repository);

  Future<Either<Failure, Unit>> call(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  ) async {
    return await repository.submitAttendance(
      institutionId,
      classId,
      date,
      attendanceRecords,
    );
  }
}

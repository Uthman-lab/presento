import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// Use case to get attendance records for a class on a specific date
class GetAttendance {
  final AttendanceRepository repository;

  GetAttendance(this.repository);

  Future<Either<Failure, List<Attendance>>> call(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    return await repository.getAttendance(institutionId, classId, date);
  }
}

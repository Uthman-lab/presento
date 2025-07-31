import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

/// Use case to check if attendance has been submitted for a class on a date
class IsAttendanceSubmitted {
  final AttendanceRepository repository;

  IsAttendanceSubmitted(this.repository);

  Future<Either<Failure, bool>> call(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    return await repository.isAttendanceSubmitted(institutionId, classId, date);
  }
}

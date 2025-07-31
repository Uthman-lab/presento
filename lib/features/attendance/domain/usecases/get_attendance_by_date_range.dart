import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';

class GetAttendanceByDateRange
    implements UseCase<List<Attendance>, GetAttendanceByDateRangeParams> {
  final AttendanceRepository repository;

  GetAttendanceByDateRange(this.repository);

  @override
  Future<Either<Failure, List<Attendance>>> call(
    GetAttendanceByDateRangeParams params,
  ) async {
    return await repository.getAttendanceByDateRange(
      params.institutionId,
      params.classId,
      params.startDate,
      params.endDate,
    );
  }
}

class GetAttendanceByDateRangeParams {
  final String institutionId;
  final String classId;
  final DateTime startDate;
  final DateTime endDate;

  GetAttendanceByDateRangeParams({
    required this.institutionId,
    required this.classId,
    required this.startDate,
    required this.endDate,
  });
}

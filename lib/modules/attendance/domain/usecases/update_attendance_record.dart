part of '../domain.dart';

class UpdateAttendanceRecordUseCase {
  final AttendanceRepository repository;

  UpdateAttendanceRecordUseCase({required this.repository});

  Future<Either<Failure, AttendanceRecordEntity>> call(
    String institutionId,
    String attendanceId,
    AttendanceRecordEntity record,
  ) async {
    return await repository.updateAttendanceRecord(
      institutionId,
      attendanceId,
      record,
    );
  }
}



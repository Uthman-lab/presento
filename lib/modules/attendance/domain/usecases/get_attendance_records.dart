part of '../domain.dart';

class GetAttendanceRecordsUseCase {
  final AttendanceRepository repository;

  GetAttendanceRecordsUseCase({required this.repository});

  Future<Either<Failure, List<AttendanceRecordEntity>>> call(
    String institutionId,
    String attendanceId,
  ) async {
    return await repository.getAttendanceRecords(institutionId, attendanceId);
  }
}


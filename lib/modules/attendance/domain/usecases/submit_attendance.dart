part of '../domain.dart';

class SubmitAttendanceUseCase {
  final AttendanceRepository repository;

  SubmitAttendanceUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    String institutionId,
    String attendanceId,
  ) async {
    return await repository.submitAttendance(institutionId, attendanceId);
  }
}



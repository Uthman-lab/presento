part of '../domain.dart';

class DeleteAttendanceUseCase {
  final AttendanceRepository repository;

  DeleteAttendanceUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    String institutionId,
    String attendanceId,
  ) async {
    return await repository.deleteAttendance(institutionId, attendanceId);
  }
}


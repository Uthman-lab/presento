part of '../domain.dart';

class MarkAttendanceUseCase {
  final AttendanceRepository repository;

  MarkAttendanceUseCase({required this.repository});

  Future<Either<Failure, AttendanceEntity>> call(
    String institutionId,
    AttendanceEntity attendance,
    List<AttendanceRecordEntity> records,
  ) async {
    return await repository.markAttendance(
      institutionId,
      attendance,
      records,
    );
  }
}



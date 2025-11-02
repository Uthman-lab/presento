part of '../domain.dart';

class GetAttendanceHistoryUseCase {
  final AttendanceRepository repository;

  GetAttendanceHistoryUseCase({required this.repository});

  Future<Either<Failure, List<AttendanceEntity>>> call(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await repository.getAttendanceHistory(
      institutionId,
      classId,
      startDate,
      endDate,
    );
  }
}


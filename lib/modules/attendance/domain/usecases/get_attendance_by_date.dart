part of '../domain.dart';

class GetAttendanceByDateUseCase {
  final AttendanceRepository repository;

  GetAttendanceByDateUseCase({required this.repository});

  Future<Either<Failure, AttendanceEntity?>> call(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    return await repository.getAttendanceByDate(institutionId, classId, date);
  }
}



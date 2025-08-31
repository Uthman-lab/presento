import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';
import '../models/attendance_model.dart';

/// Implementation of AttendanceRepository
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Attendance>>> getAttendance(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await remoteDataSource.getAttendance(
          institutionId,
          classId,
          date,
        );
        return Right(
          remoteAttendance.map((model) => model.toDomain()).toList(),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> submitAttendance(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final attendanceModels = attendanceRecords
            .map((record) => AttendanceModel.fromDomain(record))
            .toList();
        await remoteDataSource.submitAttendance(
          institutionId,
          classId,
          date,
          attendanceModels,
        );
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Attendance>>> getStudentAttendance(
    String institutionId,
    String studentId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAttendance = await remoteDataSource.getStudentAttendance(
          institutionId,
          studentId,
          startDate,
          endDate,
        );
        return Right(
          remoteAttendance.map((model) => model.toDomain()).toList(),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAttendanceStats(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final stats = await remoteDataSource.getAttendanceStats(
          institutionId,
          classId,
          startDate,
          endDate,
        );
        return Right(stats);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAttendanceSubmitted(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final isSubmitted = await remoteDataSource.isAttendanceSubmitted(
          institutionId,
          classId,
          date,
        );
        return Right(isSubmitted);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Attendance>>> getAttendanceByDateRange(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final attendanceRecords = await remoteDataSource
            .getAttendanceByDateRange(
              institutionId,
              classId,
              startDate,
              endDate,
            );
        return Right(
          attendanceRecords.map((model) => model.toDomain()).toList(),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

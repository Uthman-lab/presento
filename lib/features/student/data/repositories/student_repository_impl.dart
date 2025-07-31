import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_remote_data_source.dart';
import '../models/student_model.dart';

/// Implementation of StudentRepository
class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StudentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Student>>> getStudents(
    String institutionId,
    String classId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStudents = await remoteDataSource.getStudents(
          institutionId,
          classId,
        );
        return Right(remoteStudents.map((model) => model.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Student>> getStudent(
    String institutionId,
    String studentId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        // This is a simplification. In a real app you might get a single doc from Firestore
        final remoteStudents = await remoteDataSource.getStudents(
          institutionId,
          '',
        );
        final studentEntity = remoteStudents.firstWhere(
          (s) => s.id == studentId,
        );
        return Right(studentEntity.toDomain());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createStudent(
    String institutionId,
    Student newStudent,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final studentModel = StudentModel.fromDomain(newStudent);
        await remoteDataSource.createStudent(institutionId, studentModel);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateStudent(
    String institutionId,
    Student updatedStudent,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final studentModel = StudentModel.fromDomain(updatedStudent);
        await remoteDataSource.updateStudent(institutionId, studentModel);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStudent(
    String institutionId,
    String studentId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteStudent(institutionId, studentId);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/class.dart';
import '../../domain/repositories/class_repository.dart';
import '../datasources/class_remote_data_source.dart';
import '../models/class_model.dart';

/// Implementation of ClassRepository
class ClassRepositoryImpl implements ClassRepository {
  final ClassRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ClassRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Class>>> getClasses(String institutionId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClasses = await remoteDataSource.getClasses(institutionId);
        return Right(remoteClasses.map((model) => model.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Class>> getClass(
    String institutionId,
    String classId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        // This is a simplification. In a real app you might get a single doc from Firestore
        final remoteClasses = await remoteDataSource.getClasses(institutionId);
        final classEntity = remoteClasses.firstWhere((c) => c.id == classId);
        return Right(classEntity.toDomain());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createClass(
    String institutionId,
    Class newClass,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final classModel = ClassModel.fromDomain(newClass);
        await remoteDataSource.createClass(institutionId, classModel);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateClass(
    String institutionId,
    Class updatedClass,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final classModel = ClassModel.fromDomain(updatedClass);
        await remoteDataSource.updateClass(institutionId, classModel);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteClass(
    String institutionId,
    String classId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteClass(institutionId, classId);
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

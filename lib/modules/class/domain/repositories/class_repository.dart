part of '../domain.dart';

abstract class ClassRepository {
  Future<Either<Failure, List<ClassEntity>>> getClasses(String institutionId);

  Future<Either<Failure, ClassEntity>> getClassById(
    String institutionId,
    String classId,
  );

  Future<Either<Failure, ClassEntity>> createClass(
    String institutionId,
    ClassEntity classEntity,
  );

  Future<Either<Failure, ClassEntity>> updateClass(
    String institutionId,
    String classId,
    ClassEntity classEntity,
  );

  Future<Either<Failure, void>> deleteClass(
    String institutionId,
    String classId,
  );
}


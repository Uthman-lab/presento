import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/class.dart';

/// Abstract interface for class operations
abstract class ClassRepository {
  /// Get all classes for an institution
  Future<Either<Failure, List<Class>>> getClasses(String institutionId);

  /// Get a single class by ID
  Future<Either<Failure, Class>> getClass(String institutionId, String classId);

  /// Create a new class
  Future<Either<Failure, Unit>> createClass(
    String institutionId,
    Class newClass,
  );

  /// Update an existing class
  Future<Either<Failure, Unit>> updateClass(
    String institutionId,
    Class updatedClass,
  );

  /// Delete a class
  Future<Either<Failure, Unit>> deleteClass(
    String institutionId,
    String classId,
  );
}

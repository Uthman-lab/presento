import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/class.dart';
import '../repositories/class_repository.dart';

/// Use case for creating a class
class CreateClass {
  final ClassRepository repository;

  CreateClass(this.repository);

  /// Execute create class
  Future<Either<Failure, Unit>> call(
    String institutionId,
    Class newClass,
  ) async {
    return await repository.createClass(institutionId, newClass);
  }
}

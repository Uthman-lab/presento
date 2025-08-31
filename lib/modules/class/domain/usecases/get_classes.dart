import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/class.dart';
import '../repositories/class_repository.dart';

/// Use case for getting all classes
class GetClasses {
  final ClassRepository repository;

  GetClasses(this.repository);

  /// Execute get classes
  Future<Either<Failure, List<Class>>> call(String institutionId) async {
    return await repository.getClasses(institutionId);
  }
}

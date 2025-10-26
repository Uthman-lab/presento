part of '../domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, bool>> isSessionValid();

  Future<Either<Failure, List<Institution>>> getInstitutions(
    List<String> institutionIds,
  );

  Future<Either<Failure, void>> selectInstitution(
    String userEmail,
    String institutionId,
  );
}

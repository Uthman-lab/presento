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

  Future<Either<Failure, List<Institution>>> getAllInstitutions();

  Future<Either<Failure, void>> selectInstitution(
    String userEmail,
    String? institutionId,
  );

  // User Management Methods
  Future<Either<Failure, List<User>>> getAllUsers({String? institutionId});

  Future<Either<Failure, User>> getUserById(String userId);

  Future<Either<Failure, User>> createUser({
    required String email,
    required String password,
    required String name,
    bool isSuperAdmin = false,
    Map<String, InstitutionRole> roles = const {},
  });

  Future<Either<Failure, User>> updateUser({
    required String userId,
    String? name,
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  });

  Future<Either<Failure, void>> deleteUser(String userId);
}

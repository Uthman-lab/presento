part of '../domain.dart';

abstract class UserRepository {
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

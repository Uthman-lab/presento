part of '../data.dart';

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers({
    String? institutionId,
  }) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getAllUsers(institutionId: institutionId);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.getUserById(userId);
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, User>> createUser({
    required String email,
    required String password,
    required String name,
    bool isSuperAdmin = false,
    Map<String, InstitutionRole> roles = const {},
  }) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.createUser(
        email: email,
        password: password,
        name: name,
        isSuperAdmin: isSuperAdmin,
        roles: roles,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String userId,
    String? name,
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  }) async {
    return executeWithErrorHandling(() async {
      return await remoteDataSource.updateUser(
        userId: userId,
        name: name,
        isSuperAdmin: isSuperAdmin,
        roles: roles,
      );
    }, networkInfo: networkInfo);
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    return executeWithErrorHandling(() async {
      await remoteDataSource.deleteUser(userId);
    }, networkInfo: networkInfo);
  }
}

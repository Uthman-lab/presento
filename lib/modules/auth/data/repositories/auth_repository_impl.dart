import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/institution.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(
    String email,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.login(
          email,
          password,
        );
        localDataSource.cacheUser(remoteUser);
        return Right(remoteUser.toDomain());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearUser();
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await localDataSource.getLastUser();
      return Right(user.toDomain());
    } catch (e) {
      if (await networkInfo.isConnected) {
        try {
          final remoteUser = await remoteDataSource.getCurrentUser();
          localDataSource.cacheUser(remoteUser);
          return Right(remoteUser.toDomain());
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      } else {
        return Left(AuthFailure('Not authenticated'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      await localDataSource.getLastUser();
      return Right(true);
    } catch (e) {
      return Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Institution>>> getInstitutions() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteInstitutions = await remoteDataSource.getInstitutions();
        return Right(
          remoteInstitutions.map((model) => model.toDomain()).toList(),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String name,
    String institutionId,
    String role,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.register(
          email,
          password,
          name,
          institutionId,
          role,
        );
        return Right(remoteUser.toDomain());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(User user) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
}

part of '../data.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    return executeWithErrorHandling(() async {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(userModel);
      return userModel;
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return executeWithErrorHandling(() async {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
    });
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    return executeWithErrorHandling(() async {
      // Check if session is valid first
      final isSessionValid = await localDataSource.isSessionValid();
      if (!isSessionValid) {
        await localDataSource.clearCache();
        return null;
      }

      // Try to get cached user first
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return cachedUser;
      }

      // If no cached user, try to get from remote
      if (await networkInfo.isConnected) {
        final remoteUser = await remoteDataSource.getCurrentUser();
        if (remoteUser != null) {
          await localDataSource.cacheUser(remoteUser);
        }
        return remoteUser;
      }

      return null;
    });
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    return executeWithErrorHandling(() async {
      await remoteDataSource.resetPassword(email: email);
    });
  }

  @override
  Future<Either<Failure, bool>> isSessionValid() async {
    return executeWithErrorHandling(() async {
      return await localDataSource.isSessionValid();
    });
  }
}

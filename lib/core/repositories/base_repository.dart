part of '../core.dart';

abstract class BaseRepository {
  @protected
  Future<Either<Failure, T>> executeWithErrorHandling<T>(
    Future<T> Function() operation, {
    NetworkInfo? networkInfo,
  }) async {
    try {
      // if (networkInfo != null && !await networkInfo.isConnected) {
      //   return Left(NetworkFailure(message: AppConstants.networkErrorMessage));
      // }
      final result = await operation();
      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}

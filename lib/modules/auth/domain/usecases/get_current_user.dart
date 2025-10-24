part of '../domain.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}

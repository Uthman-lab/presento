part of '../domain.dart';

class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase({required this.repository});

  Future<Either<Failure, void>> call(DeleteUserParams params) async {
    return await repository.deleteUser(params.userId);
  }
}

class DeleteUserParams extends Equatable {
  final String userId;

  const DeleteUserParams({required this.userId});

  @override
  List<Object> get props => [userId];
}


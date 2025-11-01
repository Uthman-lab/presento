part of '../domain.dart';

class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase({required this.repository});

  Future<Either<Failure, User>> call(GetUserByIdParams params) async {
    return await repository.getUserById(params.userId);
  }
}

class GetUserByIdParams extends Equatable {
  final String userId;

  const GetUserByIdParams({required this.userId});

  @override
  List<Object> get props => [userId];
}


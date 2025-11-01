part of '../domain.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase({required this.repository});

  Future<Either<Failure, List<User>>> call(GetAllUsersParams params) async {
    return await repository.getAllUsers(institutionId: params.institutionId);
  }
}

class GetAllUsersParams extends Equatable {
  final String? institutionId;

  const GetAllUsersParams({this.institutionId});

  @override
  List<Object?> get props => [institutionId];
}


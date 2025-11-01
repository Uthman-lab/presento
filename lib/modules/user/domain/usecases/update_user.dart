part of '../domain.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await repository.updateUser(
      userId: params.userId,
      name: params.name,
      isSuperAdmin: params.isSuperAdmin,
      roles: params.roles,
    );
  }
}

class UpdateUserParams extends Equatable {
  final String userId;
  final String? name;
  final bool? isSuperAdmin;
  final Map<String, InstitutionRole>? roles;

  const UpdateUserParams({
    required this.userId,
    this.name,
    this.isSuperAdmin,
    this.roles,
  });

  @override
  List<Object?> get props => [userId, name, isSuperAdmin, roles];
}


part of '../domain.dart';

class UpdateUserUseCase {
  final AuthRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await repository.updateUser(
      userId: params.userId,
      name: params.name,
      email: params.email,
      isSuperAdmin: params.isSuperAdmin,
      roles: params.roles,
    );
  }
}

class UpdateUserParams extends Equatable {
  final String userId;
  final String? name;
  final String? email;
  final bool? isSuperAdmin;
  final Map<String, InstitutionRole>? roles;

  const UpdateUserParams({
    required this.userId,
    this.name,
    this.email,
    this.isSuperAdmin,
    this.roles,
  });

  @override
  List<Object?> get props => [userId, name, email, isSuperAdmin, roles];
}


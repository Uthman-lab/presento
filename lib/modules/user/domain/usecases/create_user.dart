part of '../domain.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase({required this.repository});

  Future<Either<Failure, User>> call(CreateUserParams params) async {
    return await repository.createUser(
      email: params.email,
      password: params.password,
      name: params.name,
      isSuperAdmin: params.isSuperAdmin ?? false,
      roles: params.roles ?? {},
    );
  }
}

class CreateUserParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final bool? isSuperAdmin;
  final Map<String, InstitutionRole>? roles;

  const CreateUserParams({
    required this.email,
    required this.password,
    required this.name,
    this.isSuperAdmin,
    this.roles,
  });

  @override
  List<Object?> get props => [email, password, name, isSuperAdmin, roles];
}


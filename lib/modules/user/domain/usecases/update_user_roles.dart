part of '../domain.dart';

class UpdateUserRolesUseCase {
  final UserRepository repository;

  UpdateUserRolesUseCase({required this.repository});

  Future<Either<Failure, User>> call(UpdateUserRolesParams params) async {
    // First get the current user
    final getUserResult = await repository.getUserById(params.userId);
    
    return getUserResult.fold(
      (failure) => Left(failure),
      (user) async {
        // Merge existing roles with updates
        final updatedRoles = Map<String, InstitutionRole>.from(user.roles);
        
        // Update or add roles
        if (params.rolesToAdd != null) {
          updatedRoles.addAll(params.rolesToAdd!);
        }
        
        // Remove roles
        if (params.roleInstitutionIdsToRemove != null) {
          for (final institutionId in params.roleInstitutionIdsToRemove!) {
            updatedRoles.remove(institutionId);
          }
        }
        
        // Update user with new roles
        return await repository.updateUser(
          userId: params.userId,
          roles: updatedRoles,
        );
      },
    );
  }
}

class UpdateUserRolesParams extends Equatable {
  final String userId;
  final Map<String, InstitutionRole>? rolesToAdd;
  final List<String>? roleInstitutionIdsToRemove;

  const UpdateUserRolesParams({
    required this.userId,
    this.rolesToAdd,
    this.roleInstitutionIdsToRemove,
  });

  @override
  List<Object?> get props => [userId, rolesToAdd, roleInstitutionIdsToRemove];
}


part of '../domain.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final Map<String, InstitutionRole> roles;
  final String? currentInstitutionId;
  final bool isSuperAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.roles,
    this.currentInstitutionId,
    this.isSuperAdmin = false,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasActiveRoles =>
      isSuperAdmin || roles.values.any((role) => role.isActive);

  List<String> get activeInstitutionIds {
    // Super admin doesn't need institution IDs as they have access to all
    if (isSuperAdmin) return [];
    return roles.entries
        .where((entry) => entry.value.isActive)
        .map((entry) => entry.key)
        .toList();
  }

  InstitutionRole? getRoleForInstitution(String institutionId) {
    return roles[institutionId];
  }

  bool get hasMultipleInstitutions {
    // Super admin doesn't need institution selection
    if (isSuperAdmin) return false;
    return activeInstitutionIds.length > 1;
  }

  String? get currentRole {
    if (isSuperAdmin) return 'super_admin';
    if (currentInstitutionId == null) return null;
    return roles[currentInstitutionId]?.role;
  }

  UserRole? get currentRoleEnum {
    if (isSuperAdmin) return UserRole.superAdmin;
    return UserRole.fromString(currentRole);
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    name,
    roles,
    currentInstitutionId,
    isSuperAdmin,
    createdAt,
    updatedAt,
  ];
}

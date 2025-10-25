part of '../domain.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final Map<String, InstitutionRole> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasActiveRoles => roles.values.any((role) => role.isActive);

  List<String> get activeInstitutionIds {
    return roles.entries
        .where((entry) => entry.value.isActive)
        .map((entry) => entry.key)
        .toList();
  }

  InstitutionRole? getRoleForInstitution(String institutionId) {
    return roles[institutionId];
  }

  @override
  List<Object> get props => [uid, email, name, roles, createdAt, updatedAt];
}

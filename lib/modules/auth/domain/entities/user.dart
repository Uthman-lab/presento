part of '../domain.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final Map<String, InstitutionRole> roles;
  final String? currentInstitutionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.roles,
    this.currentInstitutionId,
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

  bool get hasMultipleInstitutions {
    return activeInstitutionIds.length > 1;
  }

  String? get currentRole {
    if (currentInstitutionId == null) return null;
    return roles[currentInstitutionId]?.role;
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    name,
    roles,
    currentInstitutionId,
    createdAt,
    updatedAt,
  ];
}

part of '../data.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.roles,
    super.currentInstitutionId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rolesMap = <String, InstitutionRoleModel>{};
    final rolesJson = json['roles'] as Map<String, dynamic>? ?? {};

    for (final entry in rolesJson.entries) {
      rolesMap[entry.key] = InstitutionRoleModel.fromJson(entry.value);
    }

    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      roles: rolesMap,
      currentInstitutionId: json['currentInstitutionId'] as String?,
      createdAt: parseDateTime(json['createdAt']),
      updatedAt: parseDateTime(json['updatedAt']),
    );
  }

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      roles: const {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final rolesJson = <String, dynamic>{};
    for (final entry in roles.entries) {
      rolesJson[entry.key] = (entry.value as InstitutionRoleModel).toJson();
    }

    return {
      'uid': uid,
      'email': email,
      'name': name,
      'roles': rolesJson,
      'currentInstitutionId': currentInstitutionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

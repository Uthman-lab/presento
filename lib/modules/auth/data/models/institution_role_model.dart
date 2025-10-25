part of '../data.dart';

class InstitutionRoleModel extends InstitutionRole {
  const InstitutionRoleModel({
    required super.role,
    super.assignedClassId,
    required super.isActive,
    required super.joinedAt,
  });

  factory InstitutionRoleModel.fromJson(Map<String, dynamic> json) {
    return InstitutionRoleModel(
      role: json['role'] as String,
      assignedClassId: json['assignedClassId'] as String?,
      isActive: json['isActive'] as bool,
      joinedAt: parseDateTime(json['joinedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'assignedClassId': assignedClassId,
      'isActive': isActive,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}

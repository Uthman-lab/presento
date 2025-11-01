part of '../domain.dart';

class InstitutionRole extends Equatable {
  final String role;
  final String? assignedClassId;
  final bool isActive;
  final DateTime joinedAt;

  const InstitutionRole({
    required this.role,
    this.assignedClassId,
    required this.isActive,
    required this.joinedAt,
  });

  @override
  List<Object?> get props => [role, assignedClassId, isActive, joinedAt];
}


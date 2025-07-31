import 'package:equatable/equatable.dart';

/// User entity representing a user in the system
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role; // admin, supervisor, class_rep, stakeholder
  final String institutionId;
  final String? profilePictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.institutionId,
    this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    role,
    institutionId,
    profilePictureUrl,
    createdAt,
    updatedAt,
  ];

  /// Create a copy of the user with updated fields
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? institutionId,
    String? profilePictureUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      institutionId: institutionId ?? this.institutionId,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if user is an admin
  bool get isAdmin => role == 'admin';

  /// Check if user is a supervisor
  bool get isSupervisor => role == 'supervisor';

  /// Check if user is a class representative
  bool get isClassRep => role == 'class_rep';

  /// Check if user is a stakeholder
  bool get isStakeholder => role == 'stakeholder';
}

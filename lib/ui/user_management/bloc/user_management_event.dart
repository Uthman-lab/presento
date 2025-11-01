part of '../user_management.ui.dart';

abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserManagementEvent {
  final String? institutionId;
  final String? searchQuery;

  const LoadUsers({this.institutionId, this.searchQuery});

  @override
  List<Object?> get props => [institutionId, searchQuery];
}

class LoadUser extends UserManagementEvent {
  final String userId;

  const LoadUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateUser extends UserManagementEvent {
  final String email;
  final String password;
  final String name;
  final bool isSuperAdmin;
  final Map<String, InstitutionRole> roles;

  const CreateUser({
    required this.email,
    required this.password,
    required this.name,
    this.isSuperAdmin = false,
    this.roles = const {},
  });

  @override
  List<Object?> get props => [email, password, name, isSuperAdmin, roles];
}

class UpdateUser extends UserManagementEvent {
  final String userId;
  final String? name;
  final String? email;
  final bool? isSuperAdmin;
  final Map<String, InstitutionRole>? roles;

  const UpdateUser({
    required this.userId,
    this.name,
    this.email,
    this.isSuperAdmin,
    this.roles,
  });

  @override
  List<Object?> get props => [userId, name, email, isSuperAdmin, roles];
}

class DeleteUser extends UserManagementEvent {
  final String userId;

  const DeleteUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SearchUsers extends UserManagementEvent {
  final String query;
  final String? institutionId;

  const SearchUsers({required this.query, this.institutionId});

  @override
  List<Object?> get props => [query, institutionId];
}

class RefreshUsers extends UserManagementEvent {
  final String? institutionId;

  const RefreshUsers({this.institutionId});

  @override
  List<Object?> get props => [institutionId];
}


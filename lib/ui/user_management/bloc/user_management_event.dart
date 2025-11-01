part of '../user_management.ui.dart';

abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserManagementEvent {
  final String? institutionId;
  final String? searchQuery;
  final UserFilters? filters;
  final UserSortOption? sortOption;

  const LoadUsers({
    this.institutionId,
    this.searchQuery,
    this.filters,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
        institutionId,
        searchQuery,
        filters,
        sortOption,
      ];
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
  final bool? isSuperAdmin;
  final Map<String, InstitutionRole>? roles;

  const UpdateUser({
    required this.userId,
    this.name,
    this.isSuperAdmin,
    this.roles,
  });

  @override
  List<Object?> get props => [userId, name, isSuperAdmin, roles];
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
  final UserFilters? filters;
  final UserSortOption? sortOption;

  const SearchUsers({
    required this.query,
    this.institutionId,
    this.filters,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
        query,
        institutionId,
        filters,
        sortOption,
      ];
}

class RefreshUsers extends UserManagementEvent {
  final String? institutionId;
  final UserFilters? filters;
  final UserSortOption? sortOption;

  const RefreshUsers({
    this.institutionId,
    this.filters,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
        institutionId,
        filters,
        sortOption,
      ];
}

class FilterUsers extends UserManagementEvent {
  final UserFilters filters;
  final String? institutionId;
  final String? searchQuery;
  final UserSortOption? sortOption;

  const FilterUsers({
    required this.filters,
    this.institutionId,
    this.searchQuery,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
        filters,
        institutionId,
        searchQuery,
        sortOption,
      ];
}

class SortUsers extends UserManagementEvent {
  final UserSortOption sortOption;
  final String? institutionId;
  final String? searchQuery;
  final UserFilters? filters;

  const SortUsers({
    required this.sortOption,
    this.institutionId,
    this.searchQuery,
    this.filters,
  });

  @override
  List<Object?> get props => [
        sortOption,
        institutionId,
        searchQuery,
        filters,
      ];
}


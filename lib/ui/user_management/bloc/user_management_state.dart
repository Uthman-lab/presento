part of '../user_management.ui.dart';

// Sentinel class to distinguish between "not provided" and "explicitly null"
class _Unset {
  const _Unset();
}

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object?> get props => [];
}

class UserManagementInitial extends UserManagementState {
  const UserManagementInitial();
}

class UserManagementLoading extends UserManagementState {
  const UserManagementLoading();
}

enum UserSortOption {
  none,
  nameAsc,
  nameDesc,
  emailAsc,
  emailDesc,
  roleAsc,
  roleDesc,
  createdAtAsc,
  createdAtDesc,
  updatedAtAsc,
  updatedAtDesc;

  String get displayName {
    switch (this) {
      case UserSortOption.none:
        return 'No Sorting';
      case UserSortOption.nameAsc:
        return 'Name (A-Z)';
      case UserSortOption.nameDesc:
        return 'Name (Z-A)';
      case UserSortOption.emailAsc:
        return 'Email (A-Z)';
      case UserSortOption.emailDesc:
        return 'Email (Z-A)';
      case UserSortOption.roleAsc:
        return 'Role (Ascending)';
      case UserSortOption.roleDesc:
        return 'Role (Descending)';
      case UserSortOption.createdAtAsc:
        return 'Created Date (Oldest)';
      case UserSortOption.createdAtDesc:
        return 'Created Date (Newest)';
      case UserSortOption.updatedAtAsc:
        return 'Updated Date (Oldest)';
      case UserSortOption.updatedAtDesc:
        return 'Updated Date (Newest)';
    }
  }
}

class UserFilters extends Equatable {
  final Set<UserRole>? selectedRoles;
  final bool? showActiveOnly;
  final bool? showInactiveOnly;
  final bool? showSuperAdminOnly;

  const UserFilters({
    this.selectedRoles,
    this.showActiveOnly,
    this.showInactiveOnly,
    this.showSuperAdminOnly,
  });

  bool get hasActiveFilters {
    return (selectedRoles != null && selectedRoles!.isNotEmpty) ||
        showActiveOnly == true ||
        showInactiveOnly == true ||
        showSuperAdminOnly == true;
  }

  UserFilters copyWith({
    Object? selectedRoles = const _Unset(),
    Object? showActiveOnly = const _Unset(),
    Object? showInactiveOnly = const _Unset(),
    Object? showSuperAdminOnly = const _Unset(),
  }) {
    return UserFilters(
      selectedRoles: selectedRoles is _Unset
          ? this.selectedRoles
          : selectedRoles as Set<UserRole>?,
      showActiveOnly: showActiveOnly is _Unset
          ? this.showActiveOnly
          : showActiveOnly as bool?,
      showInactiveOnly: showInactiveOnly is _Unset
          ? this.showInactiveOnly
          : showInactiveOnly as bool?,
      showSuperAdminOnly: showSuperAdminOnly is _Unset
          ? this.showSuperAdminOnly
          : showSuperAdminOnly as bool?,
    );
  }

  UserFilters clear() {
    return const UserFilters();
  }

  @override
  List<Object?> get props => [
    selectedRoles,
    showActiveOnly,
    showInactiveOnly,
    showSuperAdminOnly,
  ];
}

class UsersLoaded extends UserManagementState {
  final List<User> users;
  final String? searchQuery;
  final UserFilters activeFilters;
  final UserSortOption sortOption;

  const UsersLoaded({
    required this.users,
    this.searchQuery,
    this.activeFilters = const UserFilters(),
    this.sortOption = UserSortOption.none,
  });

  @override
  List<Object?> get props => [users, searchQuery, activeFilters, sortOption];
}

class UserLoaded extends UserManagementState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserOperationSuccess extends UserManagementState {
  final String message;
  final User? user;

  const UserOperationSuccess({required this.message, this.user});

  @override
  List<Object?> get props => [message, user];
}

class UserManagementError extends UserManagementState {
  final String message;

  const UserManagementError({required this.message});

  @override
  List<Object> get props => [message];
}

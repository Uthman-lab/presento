part of '../user_management.ui.dart';

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

class UsersLoaded extends UserManagementState {
  final List<User> users;
  final String? searchQuery;

  const UsersLoaded({required this.users, this.searchQuery});

  @override
  List<Object?> get props => [users, searchQuery];
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

  const UserOperationSuccess({
    required this.message,
    this.user,
  });

  @override
  List<Object?> get props => [message, user];
}

class UserManagementError extends UserManagementState {
  final String message;

  const UserManagementError({required this.message});

  @override
  List<Object> get props => [message];
}


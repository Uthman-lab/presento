part of '../auth.ui.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class PasswordResetSent extends AuthState {
  final String email;

  const PasswordResetSent({required this.email});

  @override
  List<Object> get props => [email];
}

class InstitutionsLoaded extends Authenticated {
  final List<Institution> institutions;

  const InstitutionsLoaded({required super.user, required this.institutions});

  @override
  List<Object> get props => [user, institutions];
}

class InstitutionSelected extends Authenticated {
  const InstitutionSelected({required super.user});

  @override
  List<Object> get props => [user];
}

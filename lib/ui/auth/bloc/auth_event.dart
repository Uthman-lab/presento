part of '../auth.ui.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class InstitutionsLoadRequested extends AuthEvent {
  const InstitutionsLoadRequested();
}

class InstitutionSelectionRequested extends AuthEvent {
  final String institutionId;

  const InstitutionSelectionRequested({required this.institutionId});

  @override
  List<Object> get props => [institutionId];
}

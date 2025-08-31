part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested(
    String email,
    String password,
    String institutionId,
  ) = AuthLoginRequested;
  const factory AuthEvent.logoutRequested() = AuthLogoutRequested;
  const factory AuthEvent.authStatusChanged() = AuthStatusChanged;
  const factory AuthEvent.getInstitutionsRequested() =
      AuthGetInstitutionsRequested;
}

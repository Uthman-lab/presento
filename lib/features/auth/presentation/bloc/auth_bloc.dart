import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/institution.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/get_institutions.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;
  final GetInstitutions _getInstitutions;

  AuthBloc({
    required Login login,
    required Logout logout,
    required GetCurrentUser getCurrentUser,
    required GetInstitutions getInstitutions,
  }) : _login = login,
       _logout = logout,
       _getCurrentUser = getCurrentUser,
       _getInstitutions = getInstitutions,
       super(const AuthState.initial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthGetInstitutionsRequested>(_onGetInstitutionsRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _login(
      event.email,
      event.password,
      event.institutionId,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getCurrentUser();
    result.fold(
      (_) => emit(const AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onGetInstitutionsRequested(
    AuthGetInstitutionsRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _getInstitutions();
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (institutions) => emit(AuthState.institutionsLoaded(institutions)),
    );
  }
}

part of '../auth.ui.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetInstitutionsUseCase getInstitutionsUseCase;
  final SelectInstitutionUseCase selectInstitutionUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.resetPasswordUseCase,
    required this.getInstitutionsUseCase,
    required this.selectInstitutionUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<InstitutionsLoadRequested>(_onInstitutionsLoadRequested);
    on<InstitutionSelectionRequested>(_onInstitutionSelectionRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getCurrentUserUseCase();

    result.fold((failure) => emit(AuthError(message: failure.message)), (user) {
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await resetPasswordUseCase(
      ResetPasswordParams(email: event.email),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(PasswordResetSent(email: event.email)),
    );
  }

  Future<void> _onInstitutionsLoadRequested(
    InstitutionsLoadRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    // Get current user to extract institution IDs
    final currentUserResult = await getCurrentUserUseCase();

    if (currentUserResult.isLeft()) {
      emit(
        AuthError(message: currentUserResult.fold((l) => l.message, (r) => '')),
      );
      return;
    }

    final user = currentUserResult.fold((l) => null, (r) => r);
    if (user == null) {
      emit(const Unauthenticated());
      return;
    }

    // Super admin doesn't need institution loading, they have access to all
    if (user.isSuperAdmin) {
      emit(Authenticated(user: user));
      return;
    }

    final institutionIds = user.activeInstitutionIds;
    if (institutionIds.isEmpty) {
      emit(const AuthError(message: 'No institutions found'));
      return;
    }

    // Await the institutions loading
    final result = await getInstitutionsUseCase(institutionIds: institutionIds);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (institutions) =>
          emit(InstitutionsLoaded(user: user, institutions: institutions)),
    );
  }

  Future<void> _onInstitutionSelectionRequested(
    InstitutionSelectionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    // Get current user first
    final currentUserResult = await getCurrentUserUseCase();

    if (currentUserResult.isLeft()) {
      emit(
        AuthError(message: currentUserResult.fold((l) => l.message, (r) => '')),
      );
      return;
    }

    final user = currentUserResult.fold((l) => null, (r) => r);
    if (user == null) {
      emit(const Unauthenticated());
      return;
    }

    // Super admin doesn't need institution selection, but handle gracefully if called
    if (user.isSuperAdmin) {
      emit(Authenticated(user: user));
      return;
    }

    // Await the institution selection
    final result = await selectInstitutionUseCase(
      userEmail: user.email,
      institutionId: event.institutionId,
    );

    result.fold((failure) => emit(AuthError(message: failure.message)), (_) {
      // Create updated user with selected institution
      final updatedUser = User(
        uid: user.uid,
        email: user.email,
        name: user.name,
        roles: user.roles,
        currentInstitutionId: event.institutionId,
        isSuperAdmin: user.isSuperAdmin,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );
      emit(InstitutionSelected(user: updatedUser));
    });
  }
}

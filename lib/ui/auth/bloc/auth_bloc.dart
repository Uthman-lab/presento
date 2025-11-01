part of '../auth.ui.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetInstitutionsUseCase getInstitutionsUseCase;
  final GetAllInstitutionsUseCase getAllInstitutionsUseCase;
  final SelectInstitutionUseCase selectInstitutionUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.resetPasswordUseCase,
    required this.getInstitutionsUseCase,
    required this.getAllInstitutionsUseCase,
    required this.selectInstitutionUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<InstitutionsLoadRequested>(_onInstitutionsLoadRequested);
    on<AllInstitutionsLoadRequested>(_onAllInstitutionsLoadRequested);
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

  Future<void> _onAllInstitutionsLoadRequested(
    AllInstitutionsLoadRequested event,
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

    // Only super admin should be able to load all institutions
    if (!user.isSuperAdmin) {
      emit(
        const AuthError(message: 'Only super admin can load all institutions'),
      );
      return;
    }

    // Load all institutions
    final result = await getAllInstitutionsUseCase();

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (institutions) =>
          emit(AllInstitutionsLoaded(user: user, institutions: institutions)),
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

    // Convert empty string to null for clearing
    final institutionId = event.institutionId.isEmpty
        ? null
        : event.institutionId;

    // For super admin, allow clearing institution (setting to null)
    // and also allow setting an institution for viewing context
    if (user.isSuperAdmin) {
      // Call selectInstitution to update Firestore
      final result = await selectInstitutionUseCase(
        userEmail: user.email,
        institutionId: institutionId,
      );

      result.fold((failure) => emit(AuthError(message: failure.message)), (_) {
        // Create updated user with selected/cleared institution
        final updatedUser = User(
          uid: user.uid,
          email: user.email,
          name: user.name,
          roles: user.roles,
          currentInstitutionId: institutionId,
          isSuperAdmin: user.isSuperAdmin,
          createdAt: user.createdAt,
          updatedAt: DateTime.now(),
        );
        emit(Authenticated(user: updatedUser));
      });
      return;
    }

    // Await the institution selection for regular users
    final result = await selectInstitutionUseCase(
      userEmail: user.email,
      institutionId: institutionId,
    );

    result.fold((failure) => emit(AuthError(message: failure.message)), (_) {
      // Create updated user with selected institution
      final updatedUser = User(
        uid: user.uid,
        email: user.email,
        name: user.name,
        roles: user.roles,
        currentInstitutionId: institutionId,
        isSuperAdmin: user.isSuperAdmin,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );
      emit(InstitutionSelected(user: updatedUser));
    });
  }
}

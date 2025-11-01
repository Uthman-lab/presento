part of '../user_management.ui.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserManagementBloc({
    required this.getAllUsersUseCase,
    required this.getUserByIdUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(const UserManagementInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadUser>(_onLoadUser);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
    on<SearchUsers>(_onSearchUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onLoadUsers(
    LoadUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(const UserManagementLoading());

    final result = await getAllUsersUseCase(
      GetAllUsersParams(institutionId: event.institutionId),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (users) {
        // Apply search filter if provided
        List<User> filteredUsers = users;
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          final query = event.searchQuery!.toLowerCase();
          filteredUsers = users.where((user) {
            return user.name.toLowerCase().contains(query) ||
                user.email.toLowerCase().contains(query);
          }).toList();
        }

        emit(UsersLoaded(
          users: filteredUsers,
          searchQuery: event.searchQuery,
        ));
      },
    );
  }

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(const UserManagementLoading());

    final result = await getUserByIdUseCase(
      GetUserByIdParams(userId: event.userId),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (user) => emit(UserLoaded(user: user)),
    );
  }

  Future<void> _onCreateUser(
    CreateUser event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(const UserManagementLoading());

    final result = await createUserUseCase(
      CreateUserParams(
        email: event.email,
        password: event.password,
        name: event.name,
        isSuperAdmin: event.isSuperAdmin,
        roles: event.roles,
      ),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (user) => emit(
        UserOperationSuccess(
          message: 'User created successfully',
          user: user,
        ),
      ),
    );
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(const UserManagementLoading());

    final result = await updateUserUseCase(
      UpdateUserParams(
        userId: event.userId,
        name: event.name,
        email: event.email,
        isSuperAdmin: event.isSuperAdmin,
        roles: event.roles,
      ),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (user) => emit(
        UserOperationSuccess(
          message: 'User updated successfully',
          user: user,
        ),
      ),
    );
  }

  Future<void> _onDeleteUser(
    DeleteUser event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(const UserManagementLoading());

    final result = await deleteUserUseCase(
      DeleteUserParams(userId: event.userId),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (_) => emit(
        const UserOperationSuccess(
          message: 'User deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    // Reload users with search query
    add(LoadUsers(
      institutionId: event.institutionId,
      searchQuery: event.query,
    ));
  }

  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    add(LoadUsers(institutionId: event.institutionId));
  }
}


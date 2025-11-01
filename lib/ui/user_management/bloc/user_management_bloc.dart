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
    on<FilterUsers>(_onFilterUsers);
    on<SortUsers>(_onSortUsers);
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
        List<User> processedUsers = users;
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          final query = event.searchQuery!.toLowerCase();
          processedUsers = users.where((user) {
            return user.name.toLowerCase().contains(query) ||
                user.email.toLowerCase().contains(query);
          }).toList();
        }

        // Apply filters if provided
        final filters = event.filters ?? const UserFilters();
        processedUsers = _applyFilters(processedUsers, filters);

        // Apply sorting if provided
        final sortOption = event.sortOption ?? UserSortOption.none;
        processedUsers = _applySorting(processedUsers, sortOption);

        emit(
          UsersLoaded(
            users: processedUsers,
            searchQuery: event.searchQuery,
            activeFilters: filters,
            sortOption: sortOption,
          ),
        );
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
        UserOperationSuccess(message: 'User created successfully', user: user),
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
        isSuperAdmin: event.isSuperAdmin,
        roles: event.roles,
      ),
    );

    result.fold(
      (failure) => emit(UserManagementError(message: failure.message)),
      (user) => emit(
        UserOperationSuccess(message: 'User updated successfully', user: user),
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
        const UserOperationSuccess(message: 'User deleted successfully'),
      ),
    );
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    // Reload users with search query, preserving filters and sorting
    final currentState = state;
    final filters =
        event.filters ??
        (currentState is UsersLoaded ? currentState.activeFilters : null);
    final sortOption =
        event.sortOption ??
        (currentState is UsersLoaded ? currentState.sortOption : null);

    add(
      LoadUsers(
        institutionId: event.institutionId,
        searchQuery: event.query.isEmpty ? null : event.query,
        filters: filters ?? const UserFilters(),
        sortOption: sortOption ?? UserSortOption.none,
      ),
    );
  }

  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    // Preserve filters and sorting when refreshing
    final currentState = state;
    final filters =
        event.filters ??
        (currentState is UsersLoaded ? currentState.activeFilters : null);
    final sortOption =
        event.sortOption ??
        (currentState is UsersLoaded ? currentState.sortOption : null);

    add(
      LoadUsers(
        institutionId: event.institutionId,
        filters: filters ?? const UserFilters(),
        sortOption: sortOption ?? UserSortOption.none,
      ),
    );
  }

  Future<void> _onFilterUsers(
    FilterUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is UsersLoaded) {
      // Reload with new filters, preserving search and sort
      add(
        LoadUsers(
          institutionId: event.institutionId,
          searchQuery: event.searchQuery ?? currentState.searchQuery,
          filters: event.filters,
          sortOption: event.sortOption ?? currentState.sortOption,
        ),
      );
    } else {
      // If not loaded yet, just load with filters
      add(
        LoadUsers(
          institutionId: event.institutionId,
          filters: event.filters,
          sortOption: event.sortOption,
        ),
      );
    }
  }

  Future<void> _onSortUsers(
    SortUsers event,
    Emitter<UserManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is UsersLoaded) {
      // Apply sorting to current filtered users
      final sortedUsers = _applySorting(currentState.users, event.sortOption);

      emit(
        UsersLoaded(
          users: sortedUsers,
          searchQuery: event.searchQuery ?? currentState.searchQuery,
          activeFilters: event.filters ?? currentState.activeFilters,
          sortOption: event.sortOption,
        ),
      );
    } else {
      // If not loaded yet, load with sort option
      add(
        LoadUsers(
          institutionId: event.institutionId,
          filters: event.filters,
          sortOption: event.sortOption,
        ),
      );
    }
  }

  List<User> _applyFilters(List<User> users, UserFilters filters) {
    if (!filters.hasActiveFilters) {
      return users;
    }

    return users.where((user) {
      // Role filter
      if (filters.selectedRoles != null && filters.selectedRoles!.isNotEmpty) {
        bool roleMatches = false;

        // Check if user is super admin and super admin role is selected
        if (user.isSuperAdmin &&
            filters.selectedRoles!.contains(UserRole.superAdmin)) {
          roleMatches = true;
        } else {
          // Check if any of user's roles match selected roles
          for (final role in user.roles.values) {
            final userRole = UserRole.fromString(role.role);
            if (userRole != null && filters.selectedRoles!.contains(userRole)) {
              roleMatches = true;
              break;
            }
          }
        }

        if (!roleMatches) return false;
      }

      // Super admin filter
      if (filters.showSuperAdminOnly == true && !user.isSuperAdmin) {
        return false;
      }

      // Active/Inactive filter
      if (filters.showActiveOnly == true) {
        // Show active users only
        if (!user.isSuperAdmin) {
          // For non-super admins, check if they have any active role
          final hasActiveRole = user.roles.values.any((role) => role.isActive);
          if (!hasActiveRole) return false;
        }
        // Super admins are always considered active
      } else if (filters.showInactiveOnly == true) {
        // Show inactive users only
        if (user.isSuperAdmin) {
          // Super admins are always active, so exclude them
          return false;
        }
        // Check if all roles are inactive
        final allInactive = user.roles.values.every((role) => !role.isActive);
        if (!allInactive) return false;
      }

      return true;
    }).toList();
  }

  List<User> _applySorting(List<User> users, UserSortOption sortOption) {
    if (sortOption == UserSortOption.none) {
      return users;
    }

    final sortedUsers = List<User>.from(users);

    switch (sortOption) {
      case UserSortOption.nameAsc:
        sortedUsers.sort((a, b) => a.name.compareTo(b.name));
        break;
      case UserSortOption.nameDesc:
        sortedUsers.sort((a, b) => b.name.compareTo(a.name));
        break;
      case UserSortOption.emailAsc:
        sortedUsers.sort((a, b) => a.email.compareTo(b.email));
        break;
      case UserSortOption.emailDesc:
        sortedUsers.sort((a, b) => b.email.compareTo(a.email));
        break;
      case UserSortOption.roleAsc:
        sortedUsers.sort(
          (a, b) => _getRolePriority(a).compareTo(_getRolePriority(b)),
        );
        break;
      case UserSortOption.roleDesc:
        sortedUsers.sort(
          (a, b) => _getRolePriority(b).compareTo(_getRolePriority(a)),
        );
        break;
      case UserSortOption.createdAtAsc:
        sortedUsers.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case UserSortOption.createdAtDesc:
        sortedUsers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case UserSortOption.updatedAtAsc:
        sortedUsers.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case UserSortOption.updatedAtDesc:
        sortedUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case UserSortOption.none:
        // Already handled above
        break;
    }

    return sortedUsers;
  }

  int _getRolePriority(User user) {
    if (user.isSuperAdmin) return 0;

    // Get the highest priority role from user's roles
    int minPriority = 999;
    for (final role in user.roles.values) {
      final userRole = UserRole.fromString(role.role);
      if (userRole != null) {
        final priority = _getRolePriorityValue(userRole);
        if (priority < minPriority) {
          minPriority = priority;
        }
      }
    }

    return minPriority == 999 ? 99 : minPriority;
  }

  int _getRolePriorityValue(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
        return 0;
      case UserRole.admin:
        return 1;
      case UserRole.teacher:
        return 2;
      case UserRole.classRepresentative:
        return 3;
      case UserRole.student:
        return 4;
      case UserRole.stakeholder:
        return 5;
    }
  }
}

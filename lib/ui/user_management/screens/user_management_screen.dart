part of '../user_management.ui.dart';

class UserManagementScreen extends StatefulWidget {
  final String? institutionId;

  const UserManagementScreen({super.key, this.institutionId});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserManagementBloc>().add(
      LoadUsers(institutionId: widget.institutionId),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final currentState = context.read<UserManagementBloc>().state;
    final filters = currentState is UsersLoaded
        ? currentState.activeFilters
        : null;
    final sortOption = currentState is UsersLoaded
        ? currentState.sortOption
        : null;

    context.read<UserManagementBloc>().add(
      SearchUsers(
        query: query,
        institutionId: widget.institutionId,
        filters: filters,
        sortOption: sortOption,
      ),
    );
  }

  void _refreshUsers() {
    final currentState = context.read<UserManagementBloc>().state;
    final filters = currentState is UsersLoaded
        ? currentState.activeFilters
        : null;
    final sortOption = currentState is UsersLoaded
        ? currentState.sortOption
        : null;

    context.read<UserManagementBloc>().add(
      RefreshUsers(
        institutionId: widget.institutionId,
        filters: filters,
        sortOption: sortOption,
      ),
    );
  }

  void _onFilterChanged(UserFilters filters) {
    final currentState = context.read<UserManagementBloc>().state;
    final searchQuery = currentState is UsersLoaded
        ? currentState.searchQuery
        : null;
    final sortOption = currentState is UsersLoaded
        ? currentState.sortOption
        : null;

    context.read<UserManagementBloc>().add(
      FilterUsers(
        filters: filters,
        institutionId: widget.institutionId,
        searchQuery: searchQuery,
        sortOption: sortOption,
      ),
    );
  }

  void _onSortChanged(UserSortOption sortOption) {
    final currentState = context.read<UserManagementBloc>().state;
    final searchQuery = currentState is UsersLoaded
        ? currentState.searchQuery
        : null;
    final filters = currentState is UsersLoaded
        ? currentState.activeFilters
        : null;

    context.read<UserManagementBloc>().add(
      SortUsers(
        sortOption: sortOption,
        institutionId: widget.institutionId,
        searchQuery: searchQuery,
        filters: filters,
      ),
    );
  }

  void _clearFilters() {
    final currentState = context.read<UserManagementBloc>().state;
    final searchQuery = currentState is UsersLoaded
        ? currentState.searchQuery
        : null;
    final sortOption = currentState is UsersLoaded
        ? currentState.sortOption
        : null;

    context.read<UserManagementBloc>().add(
      FilterUsers(
        filters: const UserFilters(),
        institutionId: widget.institutionId,
        searchQuery: searchQuery,
        sortOption: sortOption,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = context.select<AuthBloc, User?>((bloc) {
      final state = bloc.state;
      if (state is Authenticated) return state.user;
      if (state is AllInstitutionsLoaded) return state.user;
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: currentUser?.isSuperAdmin == true
            ? Colors.red
            : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUsers,
            tooltip: 'Refresh',
          ),
          if (currentUser?.isSuperAdmin == true)
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () async {
                // Push create user screen and wait for result
                final result = await context.push('/users/create/');
                // Refresh users list when returning from create screen
                if (result == true || mounted) {
                  _refreshUsers();
                }
              },
              tooltip: 'Create User',
            ),
        ],
      ),
      body: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _refreshUsers();
            if (state.user != null) {
              // Navigate to user detail if user was created/updated
              context.push('/users/${state.user!.email}');
            }
          } else if (state is UserManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UserManagementBloc, UserManagementState>(
          builder: (context, state) {
            final currentFilters = state is UsersLoaded
                ? state.activeFilters
                : const UserFilters();
            final currentSort = state is UsersLoaded
                ? state.sortOption
                : UserSortOption.none;

            return Column(
              children: [
                // Filter section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                            maxWidth: 250,
                          ),
                          child: RoleFilterDropdown(
                            selectedRoles: currentFilters.selectedRoles,
                            onChanged: (roles) {
                              _onFilterChanged(
                                currentFilters.copyWith(selectedRoles: roles),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                            maxWidth: 250,
                          ),
                          child: StatusFilterDropdown(
                            showActiveOnly: currentFilters.showActiveOnly,
                            showInactiveOnly: currentFilters.showInactiveOnly,
                            showSuperAdminOnly:
                                currentFilters.showSuperAdminOnly,
                            onChanged:
                                ({
                                  bool? showActiveOnly,
                                  bool? showInactiveOnly,
                                  bool? showSuperAdminOnly,
                                }) {
                                  _onFilterChanged(
                                    currentFilters.copyWith(
                                      showActiveOnly: showActiveOnly,
                                      showInactiveOnly: showInactiveOnly,
                                      showSuperAdminOnly: showSuperAdminOnly,
                                    ),
                                  );
                                },
                          ),
                        ),
                        const SizedBox(width: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                            maxWidth: 250,
                          ),
                          child: SortDropdown(
                            currentSort: currentSort,
                            onChanged: _onSortChanged,
                          ),
                        ),
                        if (currentFilters.hasActiveFilters)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: IconButton(
                              icon: const Icon(Icons.clear_all),
                              onPressed: _clearFilters,
                              tooltip: 'Clear Filters',
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Active filter chips
                if (currentFilters.hasActiveFilters)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (currentFilters.selectedRoles != null &&
                            currentFilters.selectedRoles!.isNotEmpty)
                          ...currentFilters.selectedRoles!.map((role) {
                            return Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(role.icon, size: 16, color: role.color),
                                  const SizedBox(width: 4),
                                  Text(role.displayName),
                                ],
                              ),
                              onDeleted: () {
                                final newRoles = Set<UserRole>.from(
                                  currentFilters.selectedRoles!,
                                );
                                newRoles.remove(role);
                                _onFilterChanged(
                                  currentFilters.copyWith(
                                    selectedRoles: newRoles.isEmpty
                                        ? null
                                        : newRoles,
                                  ),
                                );
                              },
                              deleteIcon: const Icon(Icons.close, size: 18),
                            );
                          }),
                        if (currentFilters.showActiveOnly == true)
                          Chip(
                            label: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text('Active Only'),
                              ],
                            ),
                            onDeleted: () {
                              _onFilterChanged(
                                currentFilters.copyWith(showActiveOnly: null),
                              );
                            },
                            deleteIcon: const Icon(Icons.close, size: 18),
                          ),
                        if (currentFilters.showInactiveOnly == true)
                          Chip(
                            label: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.cancel,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 4),
                                Text('Inactive Only'),
                              ],
                            ),
                            onDeleted: () {
                              _onFilterChanged(
                                currentFilters.copyWith(showInactiveOnly: null),
                              );
                            },
                            deleteIcon: const Icon(Icons.close, size: 18),
                          ),
                        if (currentFilters.showSuperAdminOnly == true)
                          Chip(
                            label: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.admin_panel_settings,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 4),
                                Text('Super Admins Only'),
                              ],
                            ),
                            onDeleted: () {
                              _onFilterChanged(
                                currentFilters.copyWith(
                                  showSuperAdminOnly: null,
                                ),
                              );
                            },
                            deleteIcon: const Icon(Icons.close, size: 18),
                          ),
                      ],
                    ),
                  ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search users by name or email...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),

                // User list
                Expanded(
                  child: BlocBuilder<UserManagementBloc, UserManagementState>(
                    builder: (context, state) {
                      if (state is UserManagementLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is UsersLoaded) {
                        if (state.users.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.searchQuery != null &&
                                          state.searchQuery!.isNotEmpty
                                      ? 'No users found matching "${state.searchQuery}"'
                                      : 'No users found',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async => _refreshUsers(),
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return UserListTile(
                                user: user,
                                onTap: () {
                                  context.push('/users/${user.email}');
                                },
                              );
                            },
                          ),
                        );
                      }

                      if (state is UserManagementError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.red[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refreshUsers,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      return const Center(child: Text('No data available'));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

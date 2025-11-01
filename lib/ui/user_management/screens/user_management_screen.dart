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
    context.read<UserManagementBloc>().add(
      SearchUsers(query: query, institutionId: widget.institutionId),
    );
  }

  void _refreshUsers() {
    context.read<UserManagementBloc>().add(
      RefreshUsers(institutionId: widget.institutionId),
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
              onPressed: () {
                context.push('/users/create/');
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
        child: Column(
          children: [
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
        ),
      ),
    );
  }
}

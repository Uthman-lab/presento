part of '../user_management.ui.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  bool _isSuperAdmin = false;
  late Map<String, InstitutionRole> _roles;
  bool _isEditing = false;
  List<Institution> _institutions = [];

  @override
  void initState() {
    super.initState();
    context.read<UserManagementBloc>().add(LoadUser(userId: widget.userId));
    _loadInstitutions();
  }

  Future<void> _loadInstitutions() async {
    final authBloc = context.read<AuthBloc>();
    final currentState = authBloc.state;
    if (currentState is AllInstitutionsLoaded) {
      setState(() {
        _institutions = currentState.institutions;
      });
    } else {
      authBloc.add(const AllInstitutionsLoadRequested());
    }
  }

  void _initializeControllers(User user) {
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _isSuperAdmin = user.isSuperAdmin;
    _roles = Map<String, InstitutionRole>.from(user.roles);
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final currentUser = context.select<AuthBloc, User?>((bloc) {
        final state = bloc.state;
        if (state is Authenticated) return state.user;
        if (state is AllInstitutionsLoaded) return state.user;
        return null;
      });

      // Check permissions
      if (currentUser?.isSuperAdmin != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Only super admins can edit users'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<UserManagementBloc>().add(
        UpdateUser(
          userId: widget.userId,
          name: _nameController?.text.trim(),
          email: _emailController?.text.trim(),
          isSuperAdmin: _isSuperAdmin,
          roles: _roles,
        ),
      );
      _toggleEdit();
    }
  }

  void _showDeleteConfirmation() {
    final bloc = context.read<UserManagementBloc>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text(
          'Are you sure you want to delete this user? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              bloc.add(DeleteUser(userId: widget.userId));
              context.pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    super.dispose();
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
        title: const Text('User Details'),
        backgroundColor: currentUser?.isSuperAdmin == true
            ? Colors.red
            : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (currentUser?.isSuperAdmin == true)
            IconButton(
              icon: Icon(_isEditing ? Icons.close : Icons.edit),
              onPressed: _isEditing ? _toggleEdit : _toggleEdit,
            ),
          if (currentUser?.isSuperAdmin == true && !_isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _showDeleteConfirmation,
              color: Colors.red[300],
            ),
        ],
      ),
      body: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          if (state is UserLoaded && !_isEditing) {
            _initializeControllers(state.user);
          } else if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            if (state.user != null) {
              _initializeControllers(state.user!);
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
            if (state is UserManagementLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserLoaded || state is UserOperationSuccess) {
              final user = state is UserLoaded
                  ? state.user
                  : (state as UserOperationSuccess).user;

              // If user is null, show error or loading
              if (user == null) {
                return const Center(child: Text('User data not available'));
              }

              if (!_isEditing && _nameController?.text.isEmpty == true) {
                _initializeControllers(user);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: user.isSuperAdmin
                                        ? Colors.red
                                        : theme.primaryColor,
                                    child: Text(
                                      user.name.isNotEmpty
                                          ? user.name[0].toUpperCase()
                                          : '?',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _isEditing
                                              ? 'Editing User'
                                              : user.name,
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          user.email,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: Colors.grey[600],
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (user.isSuperAdmin)
                                const UserRoleChip(
                                  role: 'super_admin',
                                  isSuperAdmin: true,
                                ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: user.roles.entries
                                    .where((e) => e.value.isActive)
                                    .map(
                                      (entry) => UserRoleChip(
                                        role: entry.value.role,
                                        institutionId: entry.key,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Edit Form
                      if (_isEditing) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          enabled: _isEditing,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          enabled: _isEditing,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@')) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        if (currentUser?.isSuperAdmin == true)
                          SwitchListTile(
                            title: const Text('Super Admin'),
                            subtitle: const Text(
                              'Grant super administrator privileges',
                            ),
                            value: _isSuperAdmin,
                            onChanged: _isEditing
                                ? (value) {
                                    setState(() {
                                      _isSuperAdmin = value;
                                    });
                                  }
                                : null,
                          ),
                        const SizedBox(height: 24),
                        if (_institutions.isNotEmpty)
                          InstitutionRoleEditor(
                            user: user,
                            institutions: _institutions,
                            onRolesChanged: (roles) {
                              setState(() {
                                _roles = roles;
                              });
                            },
                          ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveChanges,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Save Changes'),
                          ),
                        ),
                      ] else ...[
                        // Read-only view
                        _buildInfoRow('Email', user.email, Icons.email),
                        _buildInfoRow(
                          'Created',
                          _formatDate(user.createdAt),
                          Icons.calendar_today,
                        ),
                        _buildInfoRow(
                          'Last Updated',
                          _formatDate(user.updatedAt),
                          Icons.update,
                        ),
                        if (user.currentInstitutionId != null)
                          _buildInfoRow(
                            'Current Institution',
                            user.currentInstitutionId!,
                            Icons.business,
                          ),
                      ],
                    ],
                  ),
                ),
              );
            }

            if (state is UserManagementError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.red[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

part of '../presentation.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return const Scaffold(
            body: Center(child: Text('No user data available')),
          );
        }

        final user = state.user;

        return Scaffold(
          appBar: AppBar(
            title: const Text('User Details'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(const LogoutRequested());
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('ID', user.uid),
                        _buildInfoRow('Name', user.name),
                        _buildInfoRow('Email', user.email),
                        _buildInfoRow(
                          'Created At',
                          _formatDate(user.createdAt),
                        ),
                        _buildInfoRow(
                          'Updated At',
                          _formatDate(user.updatedAt),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Roles Information
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Institution Roles',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (user.roles.isEmpty)
                          const Text(
                            'No roles assigned',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          )
                        else
                          ...user.roles.entries.map(
                            (entry) => _buildRoleCard(entry.key, entry.value),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Active Roles Summary
                if (user.hasActiveRoles)
                  Card(
                    elevation: 4,
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Roles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'User has ${user.activeInstitutionIds.length} active role(s)',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(String institutionId, InstitutionRole role) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: role.isActive ? Colors.blue.shade50 : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Institution: $institutionId',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: role.isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    role.isActive ? 'Active' : 'Inactive',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Role: ${role.role}'),
            if (role.assignedClassId != null)
              Text('Assigned Class: ${role.assignedClassId}'),
            Text('Joined: ${_formatDate(role.joinedAt)}'),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

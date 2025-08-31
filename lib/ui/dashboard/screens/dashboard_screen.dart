import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auth/bloc/auth_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            unauthenticated: () {
              context.go('/');
            },
            orElse: () {},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    authenticated: (user) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user.name}!',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Role: ${user.role}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email: ${user.email}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    orElse: () => const Text('Loading user...'),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Text(
                'Admin Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildManagementCard(
                      context,
                      'Class Management',
                      Icons.school,
                      Colors.blue,
                      () {
                        // For now, use a placeholder institution ID
                        // In a real app, this would come from the authenticated user
                        context.push(
                          '/class-management',
                          extra: 'institution_placeholder',
                        );
                      },
                    ),
                    _buildManagementCard(
                      context,
                      'Student Management',
                      Icons.people,
                      Colors.green,
                      () {
                        // For now, use placeholder IDs
                        // In a real app, this would come from the authenticated user and selected class
                        context.push(
                          '/student-management',
                          extra: {
                            'institutionId': 'institution_placeholder',
                            'classId': 'class_placeholder',
                          },
                        );
                      },
                    ),
                    _buildManagementCard(
                      context,
                      'Attendance',
                      Icons.checklist,
                      Colors.orange,
                      () {
                        // Navigate to attendance taking screen
                        context.push(
                          '/attendance-taking',
                          extra: {
                            'institutionId': 'institution_placeholder',
                            'classId': 'class_placeholder',
                          },
                        );
                      },
                    ),
                    _buildManagementCard(
                      context,
                      'Attendance Report',
                      Icons.assessment,
                      Colors.purple,
                      () {
                        // Navigate to attendance report screen
                        context.push(
                          '/attendance-report',
                          extra: {
                            'institutionId': 'institution_placeholder',
                            'classId': 'class_placeholder',
                          },
                        );
                      },
                    ),
                    _buildManagementCard(
                      context,
                      'Reports',
                      Icons.analytics,
                      Colors.purple,
                      () {
                        // TODO: Navigate to reports screen
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManagementCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class InstitutionAdminDashboard extends StatelessWidget {
  const InstitutionAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Institution Admin Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Header with Institution Switch
            const UserInfoHeader(),
            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            QuickActions(
              actions: [
                QuickAction(
                  icon: Icons.add,
                  label: 'Add\nClass',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.person_add,
                  label: 'Add\nStudent',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.person_add_alt,
                  label: 'Add\nTeacher',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.assessment,
                  label: 'View\nReports',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Institution Statistics
            Text(
              'Institution Statistics',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: const [
                    StatisticsCard(
                      icon: Icons.class_,
                      label: 'Total Classes',
                      value: '24',
                      trend: '+3 this month',
                      color: Colors.blue,
                    ),
                    StatisticsCard(
                      icon: Icons.school,
                      label: 'Total Students',
                      value: '456',
                      trend: '+12 this week',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.person,
                      label: 'Total Teachers',
                      value: '18',
                      trend: '+2 this month',
                      color: Colors.orange,
                    ),
                    StatisticsCard(
                      icon: Icons.check_circle,
                      label: 'Attendance Rate',
                      value: '94.2%',
                      trend: '+1.2% this week',
                      color: Colors.green,
                      isPlaceholder: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Management Cards
            Text(
              'Institution Management',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    DashboardCard(
                      icon: Icons.class_,
                      title: 'Class Management',
                      subtitle:
                          'Create and manage classes within the institution',
                      onTap: () {
                        final authBloc = context.read<AuthBloc>();
                        final state = authBloc.state;
                        String? institutionId;

                        if (state is AllInstitutionsLoaded ||
                            state is Authenticated) {
                          final user = state is AllInstitutionsLoaded
                              ? state.user
                              : (state as Authenticated).user;
                          institutionId = user.currentInstitutionId;
                        }

                        if (institutionId != null && institutionId.isNotEmpty) {
                          context.push('/institutions/$institutionId/classes');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select an institution first',
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      iconColor: Colors.blue,
                    ),
                    DashboardCard(
                      icon: Icons.school,
                      title: 'Student Management',
                      subtitle:
                          'Add and manage student information and enrollment',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.green,
                    ),
                    DashboardCard(
                      icon: Icons.people,
                      title: 'User Management',
                      subtitle: 'Manage institution users and assign roles',
                      onTap: () {
                        final authBloc = context.read<AuthBloc>();
                        final state = authBloc.state;
                        String? institutionId;

                        if (state is AllInstitutionsLoaded ||
                            state is Authenticated) {
                          final user = state is AllInstitutionsLoaded
                              ? state.user
                              : (state as Authenticated).user;
                          institutionId = user.currentInstitutionId;
                        }

                        if (institutionId != null && institutionId.isNotEmpty) {
                          context.push(
                            '${AppRouter.usersRoute}?institutionId=$institutionId',
                          );
                        } else {
                          context.push(AppRouter.usersRoute);
                        }
                      },
                      iconColor: Colors.orange,
                    ),
                    DashboardCard(
                      icon: Icons.assessment,
                      title: 'Attendance Reports',
                      subtitle:
                          'View institution-wide attendance reports and analytics',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.purple,
                    ),
                    DashboardCard(
                      icon: Icons.settings,
                      title: 'Institution Settings',
                      subtitle:
                          'Configure institution preferences and policies',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.teal,
                    ),
                    DashboardCard(
                      icon: Icons.analytics,
                      title: 'Institution Analytics',
                      subtitle: 'View insights and trends for your institution',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.indigo,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

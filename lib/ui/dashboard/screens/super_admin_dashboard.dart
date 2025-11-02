import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/modules/auth/auth.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        backgroundColor: Colors.red,
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Header
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
                      icon: Icons.business,
                      label: 'View\nInstitutions',
                      onTap: () {
                        context.push(AppRouter.institutionsRoute);
                      },
                    ),
                    QuickAction(
                      icon: Icons.people,
                      label: 'View All\nUsers',
                      onTap: () {
                        context.push(AppRouter.usersRoute);
                      },
                    ),
                    QuickAction(
                      icon: Icons.settings,
                      label: 'System\nSettings',
                      onTap: () => _showComingSoon(context),
                    ),
                    QuickAction(
                      icon: Icons.analytics,
                      label: 'System\nAnalytics',
                      onTap: () => _showComingSoon(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // System Statistics
                Text(
                  'System Statistics',
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
                          icon: Icons.business,
                          label: 'Total Institutions',
                          value: '12',
                          trend: '+2 this month',
                          color: Colors.blue,
                        ),
                        StatisticsCard(
                          icon: Icons.people,
                          label: 'Total Users',
                          value: '1,247',
                          trend: '+45 this week',
                          color: Colors.green,
                        ),
                        StatisticsCard(
                          icon: Icons.school,
                          label: 'Total Students',
                          value: '8,934',
                          trend: '+123 this week',
                          color: Colors.orange,
                        ),
                        StatisticsCard(
                          icon: Icons.check_circle,
                          label: 'System Health',
                          value: '99.9%',
                          trend: 'Uptime',
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
                  'System Management',
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
                          icon: Icons.business,
                          title: 'Institution Management',
                          subtitle:
                              'Create, view, and manage institutions across the system',
                          onTap: () {
                            context.push(AppRouter.institutionsRoute);
                          },
                          iconColor: Colors.blue,
                        ),
                        DashboardCard(
                          icon: Icons.people,
                          title: 'Global User Management',
                          subtitle:
                              'Manage users across all institutions and roles',
                          onTap: () {
                            context.push(AppRouter.usersRoute);
                          },
                          iconColor: Colors.green,
                        ),
                        DashboardCard(
                          icon: Icons.settings,
                          title: 'System Configuration',
                          subtitle:
                              'Configure system-wide settings and preferences',
                          onTap: () => _showComingSoon(context),
                          iconColor: Colors.orange,
                        ),
                        DashboardCard(
                          icon: Icons.analytics,
                          title: 'System Analytics',
                          subtitle:
                              'View global metrics, reports, and insights',
                          onTap: () => _showComingSoon(context),
                          iconColor: Colors.purple,
                        ),
                        DashboardCard(
                          icon: Icons.backup,
                          title: 'Data Management',
                          subtitle: 'Backup, restore, and maintain system data',
                          onTap: () => _showComingSoon(context),
                          iconColor: Colors.teal,
                        ),
                        DashboardCard(
                          icon: Icons.security,
                          title: 'Security Management',
                          subtitle:
                              'Monitor security, access control, and audit logs',
                          onTap: () => _showComingSoon(context),
                          iconColor: Colors.red,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
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

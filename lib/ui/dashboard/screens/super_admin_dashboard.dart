import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/modules/auth/auth.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';
import 'package:presento/ui/dashboard/widgets/super_admin_institution_selector.dart';
import 'package:presento/ui/user_management/user_management.ui.dart';
import 'package:presento/core/di/injection_container.dart' as di;

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  @override
  void initState() {
    super.initState();
    // Load all institutions when dashboard initializes (if not already loaded)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authBloc = context.read<AuthBloc>();
      final currentState = authBloc.state;

      // Only load if we don't already have AllInstitutionsLoaded state
      if (currentState is! AllInstitutionsLoaded) {
        authBloc.add(const AllInstitutionsLoadRequested());
      }
    });
  }

  void _handleInstitutionSelection(String institutionId) {
    final authBloc = context.read<AuthBloc>();
    final currentState = authBloc.state;

    if (currentState is Authenticated ||
        currentState is AllInstitutionsLoaded) {
      // Use InstitutionSelectionRequested which will handle both setting and clearing
      // Empty string will be converted to null in the bloc to clear the institution
      authBloc.add(InstitutionSelectionRequested(institutionId: institutionId));

      // After selection/clearing, reload all institutions to get updated state
      Future.delayed(const Duration(milliseconds: 500), () {
        authBloc.add(const AllInstitutionsLoadRequested());
      });
    }
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
              context.read<AuthBloc>().add(const LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          List<Institution> institutions = [];
          String? selectedInstitutionId;

          if (state is AllInstitutionsLoaded) {
            institutions = state.institutions;
            selectedInstitutionId = state.user.currentInstitutionId;
          } else if (state is Authenticated) {
            selectedInstitutionId = state.user.currentInstitutionId;
            // If loading, show loading indicator for institutions
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Header
                const UserInfoHeader(),
                const SizedBox(height: 24),

                // Institution Selector
                if (state is AllInstitutionsLoaded)
                  SuperAdminInstitutionSelector(
                    institutions: institutions,
                    selectedInstitutionId: selectedInstitutionId,
                    onInstitutionSelected: _handleInstitutionSelection,
                  )
                else if (state is AuthLoading)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
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
                      icon: Icons.add_business,
                      label: 'Create\nInstitution',
                      onTap: () => _showComingSoon(context),
                    ),
                    QuickAction(
                      icon: Icons.people,
                      label: 'View All\nUsers',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => di.sl<UserManagementBloc>(),
                              child: const UserManagementScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    if (selectedInstitutionId != null &&
                        selectedInstitutionId.isNotEmpty)
                      QuickAction(
                        icon: Icons.visibility,
                        label: 'View\nInstitution',
                        onTap: () => _showInstitutionView(context),
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

                // Institution Context (when selected)
                if (selectedInstitutionId != null &&
                    selectedInstitutionId.isNotEmpty)
                  _buildInstitutionContext(
                    context,
                    institutions,
                    selectedInstitutionId,
                  ),

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
                          onTap: () => _showComingSoon(context),
                          iconColor: Colors.blue,
                        ),
                        DashboardCard(
                          icon: Icons.people,
                          title: 'Global User Management',
                          subtitle:
                              'Manage users across all institutions and roles',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      di.sl<UserManagementBloc>(),
                                  child: const UserManagementScreen(),
                                ),
                              ),
                            );
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

  Widget _buildInstitutionContext(
    BuildContext context,
    List<Institution> institutions,
    String institutionId,
  ) {
    final theme = Theme.of(context);
    final institution = institutions
        .where((inst) => inst.id == institutionId)
        .firstOrNull;

    if (institution == null) return const SizedBox.shrink();

    return Card(
      color: theme.primaryColor.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.business, color: theme.primaryColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Viewing: ${institution.name}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You are viewing this institution\'s data',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => _handleInstitutionSelection(''),
              icon: const Icon(Icons.close),
              label: const Text('Clear'),
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

  void _showInstitutionView(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Institution view feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

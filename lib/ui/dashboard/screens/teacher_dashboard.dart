import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: Colors.green,
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
                // QuickAction(
                //   icon: Icons.check_circle,
                //   label: 'Mark\nAttendance',
                //   onTap: () => _navigateToAttendance(context, isMarking: true),
                // ),
                QuickAction(
                  icon: Icons.today,
                  label: "Today's\nClasses",
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.assessment,
                  label: 'Generate\nReport',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.history,
                  label: 'Attendance\nHistory',
                  onTap: () => _navigateToAttendance(context, isMarking: false),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Teacher Statistics
            Text(
              'My Statistics',
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
                      label: 'Classes Today',
                      value: '3',
                      trend: '2 more scheduled',
                      color: Colors.blue,
                    ),
                    StatisticsCard(
                      icon: Icons.school,
                      label: 'Total Students',
                      value: '89',
                      trend: 'Across 4 classes',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.check_circle,
                      label: 'Attendance Completion',
                      value: '100%',
                      trend: 'All classes marked',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.schedule,
                      label: 'Next Class',
                      value: '2:00 PM',
                      trend: 'Math Grade 5',
                      color: Colors.orange,
                      isPlaceholder: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Management Cards
            Text(
              'Class Management',
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
                    // DashboardCard(
                    //   icon: Icons.check_circle,
                    //   title: 'Mark Attendance',
                    //   subtitle: 'Take attendance for your assigned classes',
                    //   onTap: () =>
                    //       _navigateToAttendance(context, isMarking: true),
                    //   iconColor: Colors.green,
                    // ),
                    DashboardCard(
                      icon: Icons.class_,
                      title: 'My Classes',
                      subtitle: 'View assigned classes and student rosters',
                      onTap: () => _navigateToClasses(context),
                      iconColor: Colors.blue,
                    ),
                    DashboardCard(
                      icon: Icons.history,
                      title: 'Attendance History',
                      subtitle: 'View past attendance records and trends',
                      onTap: () =>
                          _navigateToAttendance(context, isMarking: false),
                      iconColor: Colors.orange,
                    ),
                    DashboardCard(
                      icon: Icons.assessment,
                      title: 'Reports',
                      subtitle: 'Generate class reports and analytics',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.purple,
                    ),
                    DashboardCard(
                      icon: Icons.school,
                      title: 'Student Management',
                      subtitle: 'Manage students in your assigned classes',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.teal,
                    ),
                    DashboardCard(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'View attendance alerts and announcements',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.indigo,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Recent Activity
            Text(
              'Recent Activity',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildActivityItem(
                      context,
                      Icons.check_circle,
                      'Marked attendance for Math Grade 5',
                      '2 hours ago',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildActivityItem(
                      context,
                      Icons.check_circle,
                      'Marked attendance for Science Grade 4',
                      '4 hours ago',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildActivityItem(
                      context,
                      Icons.schedule,
                      'Upcoming: English Grade 6 at 2:00 PM',
                      'In 30 minutes',
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
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

  void _navigateToAttendance(BuildContext context, {required bool isMarking}) {
    final authBloc = context.read<AuthBloc>();
    final state = authBloc.state;
    String? institutionId;

    if (state is AllInstitutionsLoaded || state is Authenticated) {
      final user = state is AllInstitutionsLoaded
          ? state.user
          : (state as Authenticated).user;
      institutionId = user.currentInstitutionId;
    }

    if (institutionId == null || institutionId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an institution first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Navigate to classes first, user can select class from there
    context.push('/institutions/$institutionId/classes');
  }

  void _navigateToClasses(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final state = authBloc.state;
    String? institutionId;

    if (state is AllInstitutionsLoaded || state is Authenticated) {
      final user = state is AllInstitutionsLoaded
          ? state.user
          : (state as Authenticated).user;
      institutionId = user.currentInstitutionId;
    }

    if (institutionId == null || institutionId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an institution first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.push('/institutions/$institutionId/classes');
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

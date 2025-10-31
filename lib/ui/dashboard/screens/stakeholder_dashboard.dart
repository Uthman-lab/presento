import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class StakeholderDashboard extends StatelessWidget {
  const StakeholderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stakeholder Dashboard'),
        backgroundColor: Colors.teal,
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
                QuickAction(
                  icon: Icons.school,
                  label: 'Student\nAttendance',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.assessment,
                  label: 'Student\nReports',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.person,
                  label: 'Update\nProfile',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Student Statistics
            Text(
              'Student Statistics',
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
                      icon: Icons.school,
                      label: 'Monitored Students',
                      value: '2',
                      trend: 'Active monitoring',
                      color: Colors.blue,
                    ),
                    StatisticsCard(
                      icon: Icons.check_circle,
                      label: 'Average Attendance',
                      value: '94.8%',
                      trend: '+1.2% this month',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.cancel,
                      label: 'Total Absences',
                      value: '3',
                      trend: 'This month',
                      color: Colors.orange,
                    ),
                    StatisticsCard(
                      icon: Icons.trending_up,
                      label: 'Attendance Trend',
                      value: 'Improving',
                      trend: 'Last 30 days',
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
              'Student Information',
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
                      icon: Icons.school,
                      title: 'Student Attendance',
                      subtitle:
                          'View attendance records for authorized students',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.green,
                    ),
                    DashboardCard(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Receive attendance alerts and announcements',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.orange,
                    ),
                    DashboardCard(
                      icon: Icons.assessment,
                      title: 'Student Reports',
                      subtitle: 'View student reports if authorized',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.purple,
                    ),
                    DashboardCard(
                      icon: Icons.person,
                      title: 'Profile',
                      subtitle: 'Update your personal information',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.teal,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Student Attendance Summary
            Text(
              'Student Attendance Summary',
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
                    _buildStudentItem(
                      context,
                      'Ahmad Hassan',
                      'Grade 5',
                      '96.2%',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildStudentItem(
                      context,
                      'Fatima Ali',
                      'Grade 4',
                      '93.4%',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildStudentItem(
                      context,
                      'Omar Ibrahim',
                      'Grade 6',
                      '89.1%',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Recent Notifications
            Text(
              'Recent Notifications',
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
                    _buildNotificationItem(
                      context,
                      Icons.check_circle,
                      'Ahmad Hassan was present today',
                      '2 hours ago',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildNotificationItem(
                      context,
                      Icons.cancel,
                      'Fatima Ali was absent from Science class',
                      '4 hours ago',
                      Colors.red,
                    ),
                    const Divider(),
                    _buildNotificationItem(
                      context,
                      Icons.schedule,
                      'Omar Ibrahim was late to Math class',
                      '6 hours ago',
                      Colors.orange,
                    ),
                    const Divider(),
                    _buildNotificationItem(
                      context,
                      Icons.notifications,
                      'Weekly attendance report available',
                      '1 day ago',
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

  Widget _buildStudentItem(
    BuildContext context,
    String name,
    String grade,
    String attendanceRate,
    Color rateColor,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            child: Icon(Icons.person, size: 20, color: theme.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  grade,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: rateColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: rateColor.withOpacity(0.3)),
            ),
            child: Text(
              attendanceRate,
              style: theme.textTheme.bodySmall?.copyWith(
                color: rateColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
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
}

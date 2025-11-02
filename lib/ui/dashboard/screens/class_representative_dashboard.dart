import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class ClassRepresentativeDashboard extends StatelessWidget {
  const ClassRepresentativeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Representative Dashboard'),
        backgroundColor: Colors.purple,
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
            // User Info Header with Dual Role Badge
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const UserInfoHeader(),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.purple.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.groups, size: 16, color: Colors.purple),
                          const SizedBox(width: 6),
                          Text(
                            'Dual Role: Student + Class Representative',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  icon: Icons.check_circle,
                  label: 'Mark\nAttendance',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.groups,
                  label: 'Class\nRoster',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.check_circle,
                  label: 'My\nAttendance',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.history,
                  label: 'Class\nHistory',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Class Representative Statistics
            Text(
              'Class Statistics',
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
                      icon: Icons.groups,
                      label: 'Total Students',
                      value: '28',
                      trend: 'In assigned class',
                      color: Colors.blue,
                    ),
                    StatisticsCard(
                      icon: Icons.check_circle,
                      label: "Today's Attendance",
                      value: '26/28',
                      trend: '92.9% present',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.schedule,
                      label: 'Pending Submissions',
                      value: '0',
                      trend: 'All marked',
                      color: Colors.orange,
                    ),
                    StatisticsCard(
                      icon: Icons.trending_up,
                      label: 'Class Average',
                      value: '94.2%',
                      trend: 'This month',
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
              'Class Representative Tools',
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
                    //   subtitle: 'Take attendance for your assigned class',
                    //   onTap: () => _showComingSoon(context),
                    //   iconColor: Colors.green,
                    // ),
                    DashboardCard(
                      icon: Icons.groups,
                      title: 'Class Roster',
                      subtitle: 'View all students in your assigned class',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.blue,
                    ),
                    DashboardCard(
                      icon: Icons.history,
                      title: 'Class Attendance History',
                      subtitle: 'View attendance records for your class',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.orange,
                    ),
                    DashboardCard(
                      icon: Icons.check_circle,
                      title: 'My Attendance',
                      subtitle: 'View your personal attendance as a student',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.purple,
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
                    const Divider(),
                    _buildActivityItem(
                      context,
                      Icons.notifications,
                      'Teacher reminder: Submit attendance by 3:00 PM',
                      '1 hour ago',
                      Colors.orange,
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

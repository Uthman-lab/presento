import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'package:presento/ui/dashboard/widgets/dashboard_widgets.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: Colors.orange,
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
                  icon: Icons.check_circle,
                  label: 'My\nAttendance',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.schedule,
                  label: 'Class\nSchedule',
                  onTap: () => _showComingSoon(context),
                ),
                QuickAction(
                  icon: Icons.notifications,
                  label: 'Notifications',
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
                      icon: Icons.check_circle,
                      label: 'Attendance Rate',
                      value: '96.5%',
                      trend: '+2.1% this month',
                      color: Colors.green,
                    ),
                    StatisticsCard(
                      icon: Icons.class_,
                      label: 'Classes Enrolled',
                      value: '6',
                      trend: 'All active',
                      color: Colors.blue,
                    ),
                    StatisticsCard(
                      icon: Icons.cancel,
                      label: 'Absences This Month',
                      value: '2',
                      trend: 'Both excused',
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
              'My Information',
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
                      icon: Icons.check_circle,
                      title: 'My Attendance',
                      subtitle:
                          'View your personal attendance record and history',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.green,
                    ),
                    DashboardCard(
                      icon: Icons.schedule,
                      title: 'Class Schedule',
                      subtitle: 'View your enrolled classes and timetable',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.blue,
                    ),
                    DashboardCard(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'View attendance alerts and announcements',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.orange,
                    ),
                    DashboardCard(
                      icon: Icons.person,
                      title: 'Profile',
                      subtitle: 'Update your personal information',
                      onTap: () => _showComingSoon(context),
                      iconColor: Colors.purple,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Recent Attendance Summary
            Text(
              'Recent Attendance (Last 7 Days)',
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
                    _buildAttendanceItem(
                      context,
                      'Monday',
                      'Math Grade 5',
                      'Present',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Monday',
                      'Science Grade 4',
                      'Present',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Tuesday',
                      'English Grade 6',
                      'Late',
                      Colors.orange,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Wednesday',
                      'Math Grade 5',
                      'Present',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Wednesday',
                      'Science Grade 4',
                      'Absent',
                      Colors.red,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Thursday',
                      'English Grade 6',
                      'Present',
                      Colors.green,
                    ),
                    const Divider(),
                    _buildAttendanceItem(
                      context,
                      'Friday',
                      'Math Grade 5',
                      'Present',
                      Colors.green,
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

  Widget _buildAttendanceItem(
    BuildContext context,
    String day,
    String subject,
    String status,
    Color statusColor,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              day,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(subject, style: theme.textTheme.bodyMedium)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Text(
              status,
              style: theme.textTheme.bodySmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
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

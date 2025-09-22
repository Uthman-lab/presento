import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Recent activity feed with role-relevant items
class RecentActivityFeed extends StatelessWidget {
  final User user;
  final dynamic dashboardData;

  const RecentActivityFeed({
    super.key,
    required this.user,
    required this.dashboardData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._getRecentActivities(
              user.role,
            ).map((activity) => _buildActivityItem(activity)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(activity.icon, color: activity.color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  activity.subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            activity.time,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  List<ActivityItem> _getRecentActivities(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return [
          ActivityItem(
            'New class created: Biology 202',
            'Added 25 students',
            '2 hours ago',
            Icons.add_circle,
            Colors.green,
          ),
          ActivityItem(
            'Attendance report generated',
            'Weekly summary for all classes',
            '5 hours ago',
            Icons.assessment,
            Colors.blue,
          ),
          ActivityItem(
            'User permissions updated',
            '3 staff members added',
            '1 day ago',
            Icons.people,
            Colors.orange,
          ),
        ];
      case 'supervisor':
        return [
          ActivityItem(
            'Attendance review completed',
            'Class A-101, A-102 reviewed',
            '1 hour ago',
            Icons.check_circle,
            Colors.green,
          ),
          ActivityItem(
            'Report exported',
            'Monthly attendance data',
            '3 hours ago',
            Icons.download,
            Colors.blue,
          ),
          ActivityItem(
            'Class visit completed',
            'Physics 301 - All present',
            '6 hours ago',
            Icons.visibility,
            Colors.purple,
          ),
        ];
      case 'class_rep':
        return [
          ActivityItem(
            'Attendance submitted',
            'Computer Science 101 - 28/30 present',
            '30 minutes ago',
            Icons.checklist,
            Colors.green,
          ),
          ActivityItem(
            'Late student marked',
            'John Doe arrived 15 mins late',
            '2 hours ago',
            Icons.schedule,
            Colors.orange,
          ),
          ActivityItem(
            'Attendance updated',
            'Previous correction applied',
            '1 day ago',
            Icons.edit,
            Colors.blue,
          ),
        ];
      case 'stakeholder':
        return [
          ActivityItem(
            'Monthly report generated',
            'Overall attendance: 94.2%',
            '2 hours ago',
            Icons.analytics,
            Colors.green,
          ),
          ActivityItem(
            'Trend analysis updated',
            'Positive growth of 2.5%',
            '1 day ago',
            Icons.trending_up,
            Colors.blue,
          ),
          ActivityItem(
            'Data export completed',
            'Q1 summary downloaded',
            '2 days ago',
            Icons.download,
            Colors.purple,
          ),
        ];
      default:
        return [
          ActivityItem(
            'Welcome to Task Master!',
            'Start by exploring your dashboard',
            'Just now',
            Icons.waving_hand,
            Colors.blue,
          ),
        ];
    }
  }
}

class ActivityItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;

  ActivityItem(this.title, this.subtitle, this.time, this.icon, this.color);
}


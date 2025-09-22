import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Today's statistics card with role-filtered data
class TodayStatsCard extends StatelessWidget {
  final User user;
  final dynamic dashboardData;

  const TodayStatsCard({
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
              'Today\'s Overview',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Present',
                    _getPresentCount(),
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatItem(
                    'Absent',
                    _getAbsentCount(),
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Late',
                    _getLateCount(),
                    Colors.orange,
                    Icons.schedule,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatItem(
                    'Total',
                    _getTotalCount(),
                    Colors.blue,
                    Icons.people,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(label, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder data - would be replaced with actual dashboard data
  String _getPresentCount() {
    // TODO: Extract from dashboardData
    return '25';
  }

  String _getAbsentCount() {
    // TODO: Extract from dashboardData
    return '3';
  }

  String _getLateCount() {
    // TODO: Extract from dashboardData
    return '2';
  }

  String _getTotalCount() {
    // TODO: Extract from dashboardData
    return '30';
  }
}


import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Quick actions card with role-specific actions
class QuickActionsCard extends StatelessWidget {
  final User user;

  const QuickActionsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _getQuickActions(
                user.role,
              ).map((action) => _buildActionChip(context, action)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(BuildContext context, QuickAction action) {
    return ActionChip(
      avatar: Icon(action.icon, size: 18),
      label: Text(action.label),
      onPressed: () {
        // TODO: Implement navigation to action.route
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${action.label} - Coming Soon')),
        );
      },
    );
  }

  List<QuickAction> _getQuickActions(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return [
          QuickAction('Manage Classes', Icons.class_, '/class-management'),
          QuickAction('Manage Students', Icons.people, '/student-management'),
          QuickAction('View Reports', Icons.assessment, '/reports'),
          QuickAction('Settings', Icons.settings, '/settings'),
        ];
      case 'supervisor':
        return [
          QuickAction('View All Classes', Icons.visibility, '/view-attendance'),
          QuickAction('Generate Reports', Icons.assessment, '/reports'),
          QuickAction('Export Data', Icons.download, '/export'),
        ];
      case 'class_rep':
        return [
          QuickAction('Take Attendance', Icons.checklist, '/attendance-taking'),
          QuickAction('View My Class', Icons.visibility, '/view-attendance'),
          QuickAction('Student List', Icons.people, '/students'),
        ];
      case 'stakeholder':
        return [
          QuickAction('View Reports', Icons.assessment, '/reports'),
          QuickAction('View Statistics', Icons.analytics, '/statistics'),
          QuickAction('Export Data', Icons.download, '/export'),
        ];
      default:
        return [QuickAction('View Dashboard', Icons.dashboard, '/dashboard')];
    }
  }
}

class QuickAction {
  final String label;
  final IconData icon;
  final String route;

  QuickAction(this.label, this.icon, this.route);
}

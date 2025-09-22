import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Context-aware floating action button that changes based on user role and current page
class ContextAwareFAB extends StatelessWidget {
  final User user;
  final String currentPage;

  const ContextAwareFAB({
    super.key,
    required this.user,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final fabConfig = _getFABConfig(user.role, currentPage);

    if (fabConfig == null) {
      return const SizedBox.shrink(); // No FAB for this role/page combination
    }

    return FloatingActionButton.extended(
      onPressed: () => _handleFABTap(context, fabConfig.action),
      icon: Icon(fabConfig.icon),
      label: Text(fabConfig.label),
      backgroundColor: fabConfig.color,
    );
  }

  FABConfig? _getFABConfig(String role, String currentPage) {
    switch (role.toLowerCase()) {
      case 'admin':
        switch (currentPage) {
          case 'today':
            return FABConfig(Icons.add, 'Add Class', Colors.blue, 'add_class');
          case 'people':
            return FABConfig(
              Icons.person_add,
              'Add Student',
              Colors.green,
              'add_student',
            );
          default:
            return FABConfig(
              Icons.add,
              'Quick Action',
              Colors.blue,
              'quick_action',
            );
        }
      case 'supervisor':
        switch (currentPage) {
          case 'reports':
            return FABConfig(
              Icons.assessment,
              'Generate Report',
              Colors.purple,
              'generate_report',
            );
          default:
            return FABConfig(
              Icons.visibility,
              'Review Classes',
              Colors.purple,
              'review_classes',
            );
        }
      case 'class_rep':
        switch (currentPage) {
          case 'today':
          case 'attendance':
            return FABConfig(
              Icons.checklist,
              'Take Attendance',
              Colors.green,
              'take_attendance',
            );
          default:
            return FABConfig(
              Icons.checklist,
              'Take Attendance',
              Colors.green,
              'take_attendance',
            );
        }
      case 'stakeholder':
        switch (currentPage) {
          case 'reports':
            return FABConfig(
              Icons.download,
              'Export Data',
              Colors.orange,
              'export_data',
            );
          default:
            return null; // Stakeholders mostly have read-only access
        }
      default:
        return null;
    }
  }

  void _handleFABTap(BuildContext context, String action) {
    switch (action) {
      case 'add_class':
        _showAddClassDialog(context);
        break;
      case 'add_student':
        _showAddStudentDialog(context);
        break;
      case 'take_attendance':
        _navigateToAttendanceTaking(context);
        break;
      case 'generate_report':
        _showReportDialog(context);
        break;
      case 'review_classes':
        _navigateToClassReview(context);
        break;
      case 'export_data':
        _showExportDialog(context);
        break;
      case 'quick_action':
        _showQuickActionSheet(context);
        break;
    }
  }

  void _showAddClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Class'),
        content: const Text('Add Class functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Student'),
        content: const Text('Add Student functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToAttendanceTaking(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Take Attendance - Navigation coming soon!'),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate Report'),
        content: const Text('Report generation coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToClassReview(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Class Review - Navigation coming soon!')),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Data export functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Quick action sheet coming soon!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class FABConfig {
  final IconData icon;
  final String label;
  final Color color;
  final String action;

  FABConfig(this.icon, this.label, this.color, this.action);
}


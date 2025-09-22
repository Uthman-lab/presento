import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Welcome card shown to all users on the unified dashboard
class WelcomeCard extends StatelessWidget {
  final User user;

  const WelcomeCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: _getRoleColor(user.role),
              child: Icon(
                _getRoleIcon(user.role),
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user.name}!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Role: ${_getRoleDisplayName(user.role)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'supervisor':
        return Colors.blue;
      case 'class_rep':
        return Colors.green;
      case 'stakeholder':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Icons.admin_panel_settings;
      case 'supervisor':
        return Icons.supervisor_account;
      case 'class_rep':
        return Icons.person;
      case 'stakeholder':
        return Icons.business;
      default:
        return Icons.person;
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return 'Administrator';
      case 'supervisor':
        return 'Supervisor';
      case 'class_rep':
        return 'Class Representative';
      case 'stakeholder':
        return 'Stakeholder';
      default:
        return 'User';
    }
  }
}


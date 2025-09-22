import 'package:flutter/material.dart';
import '../../../modules/auth/domain/entities/user.dart';

/// Role-based bottom navigation that adapts to user permissions
class RoleBasedBottomNav extends StatelessWidget {
  final User user;
  final int currentIndex;
  final Function(int) onTap;

  const RoleBasedBottomNav({
    super.key,
    required this.user,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = _getNavigationItems(user.role);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex < navItems.length ? currentIndex : 0,
      onTap: onTap,
      items: navItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
              tooltip: item.tooltip,
            ),
          )
          .toList(),
    );
  }

  List<NavItem> _getNavigationItems(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return [
          NavItem(Icons.home, 'Overview', 'Dashboard overview'),
          NavItem(Icons.class_, 'Classes', 'Manage classes'),
          NavItem(Icons.people, 'Students', 'Manage students'),
          NavItem(Icons.assessment, 'Reports', 'View reports'),
          NavItem(Icons.settings, 'Settings', 'App settings'),
        ];
      case 'supervisor':
        return [
          NavItem(Icons.home, 'Today', 'Today\'s overview'),
          NavItem(Icons.visibility, 'Classes', 'View classes'),
          NavItem(Icons.assessment, 'Reports', 'Generate reports'),
          NavItem(Icons.analytics, 'Analytics', 'View analytics'),
        ];
      case 'class_rep':
        return [
          NavItem(Icons.home, 'Today', 'Today\'s overview'),
          NavItem(Icons.checklist, 'Attendance', 'Take attendance'),
          NavItem(Icons.people, 'Students', 'View students'),
          NavItem(Icons.history, 'History', 'Attendance history'),
        ];
      case 'stakeholder':
        return [
          NavItem(Icons.home, 'Today', 'Today\'s overview'),
          NavItem(Icons.assessment, 'Reports', 'View reports'),
          NavItem(Icons.analytics, 'Analytics', 'View statistics'),
          NavItem(Icons.download, 'Export', 'Export data'),
        ];
      default:
        return [
          NavItem(Icons.home, 'Home', 'Home'),
          NavItem(Icons.info, 'Info', 'Information'),
        ];
    }
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final String tooltip;

  NavItem(this.icon, this.label, this.tooltip);
}


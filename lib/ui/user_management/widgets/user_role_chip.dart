part of '../user_management.ui.dart';

class UserRoleChip extends StatelessWidget {
  final String role;
  final String? institutionId;
  final bool isSuperAdmin;

  const UserRoleChip({
    super.key,
    required this.role,
    this.institutionId,
    this.isSuperAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final roleEnum = UserRole.fromString(role);
    Color chipColor;
    IconData icon;
    String label;

    if (isSuperAdmin) {
      chipColor = Colors.red;
      icon = Icons.admin_panel_settings;
      label = 'Super Admin';
    } else if (roleEnum != null) {
      chipColor = roleEnum.color;
      icon = roleEnum.icon;
      label = roleEnum.displayName;
    } else {
      chipColor = Colors.grey;
      icon = Icons.person;
      label = role;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: chipColor),
      label: Text(
        label,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.1),
      side: BorderSide(color: chipColor.withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}


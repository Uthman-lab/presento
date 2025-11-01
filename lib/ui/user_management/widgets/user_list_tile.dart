part of '../user_management.ui.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserListTile({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: user.isSuperAdmin
              ? Colors.red
              : theme.primaryColor,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (user.isSuperAdmin)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.verified, color: Colors.red, size: 20),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user.email,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                if (user.isSuperAdmin)
                  const UserRoleChip(
                    role: superAdminRole,
                    isSuperAdmin: true,
                  ),
                ...user.roles.entries.map((entry) {
                  if (!entry.value.isActive) return const SizedBox.shrink();
                  return UserRoleChip(
                    role: entry.value.role,
                    institutionId: entry.key,
                  );
                }),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}


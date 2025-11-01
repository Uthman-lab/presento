import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return const SizedBox.shrink();
        }

        final user = state.user;
        final roleEnum = user.currentRoleEnum;
        final roleDisplayName = roleEnum?.displayName ?? 'User';
        final roleIcon = roleEnum?.icon ?? Icons.person;

        // Determine institution name based on state
        final String institutionName;
        if (user.isSuperAdmin) {
          // Super admin has system-wide access, no institution needed
          institutionName = 'System Administrator';
        } else if (state is InstitutionsLoaded) {
          // Find institution name from institutions list
          final institution = state.institutions
              .where((inst) => inst.id == user.currentInstitutionId)
              .firstOrNull;
          institutionName = institution?.name ?? 'Unknown Institution';
        } else if (user.currentInstitutionId != null &&
            user.currentInstitutionId!.isNotEmpty) {
          // Institution ID exists but name not loaded yet
          institutionName =
              user.currentInstitutionId?.replaceAll("_", " ") ?? "";
        } else {
          // No institution selected
          institutionName = 'No Institution Selected';
        }

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Profile Picture Placeholder
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  child: Icon(roleIcon, size: 32, color: theme.primaryColor),
                ),
                const SizedBox(width: 16),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.badge,
                            size: 16,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              roleDisplayName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.school, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              institutionName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Institution Switch Button (not shown for super admin)
                if (!user.isSuperAdmin && user.hasMultipleInstitutions)
                  IconButton(
                    onPressed: () =>
                        context.push(AppRouter.institutionSelectionRoute),
                    icon: Icon(Icons.swap_horiz, color: theme.primaryColor),
                    tooltip: 'Switch Institution',
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

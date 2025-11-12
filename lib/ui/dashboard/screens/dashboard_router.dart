import 'package:presento/imports.dart';
import 'package:presento/modules/auth/auth.dart';
import '../dashboard.ui.dart';

class DashboardRouter extends StatelessWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.push(AppRouter.loginRoute);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        // Handle loading state - show loading instead of fallback
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Handle all authenticated state variants
        User? user;
        if (state is Authenticated) {
          user = state.user;
        } else if (state is AllInstitutionsLoaded) {
          user = state.user;
        } else if (state is InstitutionSelected) {
          user = state.user;
        } else if (state is InstitutionsLoaded) {
          user = state.user;
        }

        if (user != null) {
          final roleEnum = user.currentRoleEnum;

          // If roleEnum is null, show fallback with error message
          if (roleEnum == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Dashboard')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Unable to determine user role',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User role: ${user.currentRole ?? "null"}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Is Super Admin: ${user.isSuperAdmin}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return switch (roleEnum) {
            UserRole.superAdmin => const SuperAdminDashboard(),
            UserRole.admin => const InstitutionAdminDashboard(),
            UserRole.teacher => const TeacherDashboard(),
            UserRole.student => const StudentDashboard(),
            UserRole.classRepresentative =>
              const ClassRepresentativeDashboard(),
            UserRole.stakeholder => const StakeholderDashboard(),
          };
        }

        // Fallback for unhandled states or if user is null
        return const DashboardScreen();
      },
    );
  }
}

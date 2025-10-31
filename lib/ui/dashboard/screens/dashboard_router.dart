import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
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
        if (state is Authenticated) {
          final roleEnum = state.user.currentRoleEnum;
          return switch (roleEnum) {
            UserRole.superAdmin => const SuperAdminDashboard(),
            UserRole.admin => const InstitutionAdminDashboard(),
            UserRole.teacher => const TeacherDashboard(),
            UserRole.student => const StudentDashboard(),
            UserRole.classRepresentative =>
              const ClassRepresentativeDashboard(),
            UserRole.stakeholder => const StakeholderDashboard(),
            _ => const DashboardScreen(),
          };
        }
        return const DashboardScreen(); // Fallback
      },
    );
  }
}

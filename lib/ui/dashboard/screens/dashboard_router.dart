import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';
import 'dashboard_screen.dart';
import 'super_admin_dashboard.dart';
import 'institution_admin_dashboard.dart';
import 'teacher_dashboard.dart';
import 'student_dashboard.dart';
import 'class_representative_dashboard.dart';
import 'stakeholder_dashboard.dart';

class DashboardRouter extends StatelessWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated || state is InstitutionSelected) {
          final user = state is Authenticated
              ? state.user
              : (state as InstitutionSelected).user;
          final role = user.currentRole;

          switch (role) {
            case 'super_admin':
              return const SuperAdminDashboard();
            case 'institution_admin':
              return const InstitutionAdminDashboard();
            case 'teacher':
              return const TeacherDashboard();
            case 'student':
              return const StudentDashboard();
            case 'class_representative':
              return const ClassRepresentativeDashboard();
            case 'stakeholder':
              return const StakeholderDashboard();
            default:
              return const DashboardScreen(); // Fallback
          }
        }
        return const DashboardScreen(); // Fallback
      },
    );
  }
}



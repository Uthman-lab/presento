import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'core/di/injection_container.dart' as di;
import 'ui/auth/bloc/auth_bloc.dart';
import 'ui/class/bloc/class_management_bloc.dart';
import 'ui/student/bloc/student_management_bloc.dart';
import 'ui/attendance/bloc/attendance_bloc.dart';
import 'ui/attendance/bloc/attendance_report_bloc.dart';

import 'ui/dashboard/bloc/dashboard_bloc.dart';
import 'ui/auth/screens/institution_selection_screen.dart';
import 'ui/auth/screens/login_screen.dart';
import 'ui/dashboard/screens/dashboard_screen.dart';
import 'ui/dashboard/screens/role_based_dashboard_screen.dart';
import 'ui/class/screens/class_management_screen.dart';
import 'ui/student/screens/student_management_screen.dart';
import 'ui/attendance/screens/attendance_taking_screen.dart';
import 'ui/attendance/screens/attendance_report_screen.dart';

import 'modules/auth/domain/entities/institution.dart';
import 'modules/auth/domain/entities/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.initDependencies();
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InstitutionSelectionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          LoginScreen(institution: state.extra as Institution),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => di.getIt<DashboardBloc>(),
          child: const DashboardScreen(),
        );
      },
    ),
    GoRoute(
      path: '/role-dashboard',
      builder: (context, state) {
        final user = state.extra as User;
        return BlocProvider(
          create: (context) => di.getIt<DashboardBloc>(),
          child: RoleBasedDashboardScreen(user: user),
        );
      },
    ),
    GoRoute(
      path: '/class-management',
      builder: (context, state) => BlocProvider(
        create: (context) => di.getIt<ClassManagementBloc>(),
        child: ClassManagementScreen(institutionId: state.extra as String),
      ),
    ),
    GoRoute(
      path: '/student-management',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<StudentManagementBloc>(),
          child: StudentManagementScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),
    GoRoute(
      path: '/attendance-taking',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<AttendanceBloc>(),
          child: AttendanceTakingScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),
    GoRoute(
      path: '/attendance-report',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<AttendanceReportBloc>(),
          child: AttendanceReportScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<AuthBloc>()..add(const AuthEvent.authStatusChanged()),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Task Master Attendance System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}

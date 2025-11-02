part of '../core.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String passwordResetRoute = '/password-reset';
  static const String institutionSelectionRoute = '/institution-selection';
  static const String dashboardRoute = '/dashboard';
  static const String userDetailsRoute = '/user-details';
  static const String usersRoute = '/users';
  static const String userDetailRoute = '/users/:userId';
  static const String createUserRoute = '/users/create';
  static const String institutionsRoute = '/institutions';
  static const String institutionDetailRoute = '/institutions/:institutionId';
  static const String createInstitutionRoute = '/institutions/create';
  static const String editInstitutionRoute =
      '/institutions/:institutionId/edit';
  static const String classesRoute = '/institutions/:institutionId/classes';
  static const String createClassRoute =
      '/institutions/:institutionId/classes/create';
  static const String editClassRoute =
      '/institutions/:institutionId/classes/:classId/edit';
  static const String attendanceMarkRoute =
      '/institutions/:institutionId/classes/:classId/attendance/mark';
  static const String attendanceHistoryRoute =
      '/institutions/:institutionId/classes/:classId/attendance/history';
  static const String attendanceDetailRoute =
      '/institutions/:institutionId/attendance/:attendanceId';
  static const String studentsRoute = '/institutions/:institutionId/students';
  static const String createStudentRoute =
      '/institutions/:institutionId/students/create';
  static const String editStudentRoute =
      '/institutions/:institutionId/students/:studentId/edit';

  static final GoRouter router = GoRouter(
    initialLocation: loginRoute,
    redirect: (context, state) => RouteGuards.getRedirectRoute(context, state),
    routes: [
      GoRoute(
        path: loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: passwordResetRoute,
        name: 'password-reset',
        builder: (context, state) => const PasswordResetScreen(),
      ),

      GoRoute(
        path: institutionSelectionRoute,
        name: 'institution-selection',
        builder: (context, state) => const InstitutionSelectionScreen(),
      ),
      GoRoute(
        path: userDetailsRoute,
        name: 'user-details',
        builder: (context, state) => const UserDetailsScreen(),
      ),
      GoRoute(
        path: dashboardRoute,
        name: 'dashboard',
        builder: (context, state) => const DashboardRouter(),
      ),
      GoRoute(
        path: usersRoute,
        name: 'users',
        builder: (context, state) {
          final institutionId = state.uri.queryParameters['institutionId'];
          return BlocProvider(
            create: (context) => di.sl<UserManagementBloc>(),
            child: UserManagementScreen(institutionId: institutionId),
          );
        },
      ),
      GoRoute(
        path: createUserRoute,
        name: 'create-user',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<UserManagementBloc>(),
          child: const CreateUserScreen(),
        ),
      ),
      GoRoute(
        path: userDetailRoute,
        name: 'user-detail',
        builder: (context, state) {
          final userId = state.pathParameters['userId'] ?? '';
          return BlocProvider(
            create: (context) => di.sl<UserManagementBloc>(),
            child: UserDetailScreen(userId: userId),
          );
        },
      ),
      GoRoute(
        path: institutionsRoute,
        name: 'institutions',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<InstitutionManagementBloc>(),
          child: const InstitutionManagementScreen(),
        ),
      ),
      GoRoute(
        path: createInstitutionRoute,
        name: 'create-institution',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<InstitutionManagementBloc>(),
          child: const InstitutionFormScreen(),
        ),
      ),
      GoRoute(
        path: institutionDetailRoute,
        name: 'institution-detail',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          return InstitutionDetailScreen(institutionId: institutionId);
        },
      ),
      GoRoute(
        path: editInstitutionRoute,
        name: 'edit-institution',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          // Load institution first, then show form
          return BlocProvider(
            create: (context) =>
                di.sl<InstitutionManagementBloc>()
                  ..add(LoadInstitution(institutionId: institutionId)),
            child:
                BlocBuilder<
                  InstitutionManagementBloc,
                  InstitutionManagementState
                >(
                  builder: (context, state) {
                    if (state is InstitutionLoaded) {
                      return InstitutionFormScreen(
                        institution: state.institution,
                      );
                    }
                    if (state is InstitutionManagementError) {
                      return Scaffold(
                        appBar: AppBar(
                          title: const Text('Error'),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        body: Center(child: Text(state.message)),
                      );
                    }
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
          );
        },
      ),
      GoRoute(
        path: classesRoute,
        name: 'classes',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          return BlocProvider(
            create: (context) => di.sl<ClassManagementBloc>(),
            child: ClassManagementScreen(institutionId: institutionId),
          );
        },
      ),
      GoRoute(
        path: createClassRoute,
        name: 'create-class',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          return BlocProvider(
            create: (context) => di.sl<ClassManagementBloc>(),
            child: ClassFormScreen(institutionId: institutionId),
          );
        },
      ),
      GoRoute(
        path: editClassRoute,
        name: 'edit-class',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          final classId = state.pathParameters['classId'] ?? '';
          // Load class first, then show form
          return BlocProvider(
            create: (context) => di.sl<ClassManagementBloc>()
              ..add(LoadClass(institutionId: institutionId, classId: classId)),
            child: BlocBuilder<ClassManagementBloc, ClassManagementState>(
              builder: (context, state) {
                if (state is ClassLoaded) {
                  return ClassFormScreen(
                    institutionId: institutionId,
                    classEntity: state.classEntity,
                  );
                }
                if (state is ClassManagementError) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Error'),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    body: Center(child: Text(state.message)),
                  );
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: studentsRoute,
        name: 'students',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<StudentManagementBloc>()),
              BlocProvider(create: (context) => di.sl<ClassManagementBloc>()),
            ],
            child: StudentManagementScreen(institutionId: institutionId),
          );
        },
      ),
      GoRoute(
        path: createStudentRoute,
        name: 'create-student',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<StudentManagementBloc>()),
              BlocProvider(create: (context) => di.sl<ClassManagementBloc>()),
            ],
            child: StudentFormScreen(institutionId: institutionId),
          );
        },
      ),
      GoRoute(
        path: editStudentRoute,
        name: 'edit-student',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          final studentId = state.pathParameters['studentId'] ?? '';
          // Load student first, then show form
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<StudentManagementBloc>()
                  ..add(
                    LoadStudent(
                      institutionId: institutionId,
                      studentId: studentId,
                    ),
                  ),
              ),
              BlocProvider(create: (context) => di.sl<ClassManagementBloc>()),
            ],
            child: BlocBuilder<StudentManagementBloc, StudentManagementState>(
              builder: (context, state) {
                if (state is StudentLoaded) {
                  return StudentFormScreen(
                    institutionId: institutionId,
                    studentEntity: state.studentEntity,
                  );
                }
                if (state is StudentManagementError) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Error'),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    body: Center(child: Text(state.message)),
                  );
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: attendanceMarkRoute,
        name: 'attendance-mark',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          final classId = state.pathParameters['classId'] ?? '';
          final selectedDate = state.uri.queryParameters['date'] != null
              ? DateTime.parse(state.uri.queryParameters['date']!)
              : DateTime.now();
          return BlocProvider(
            create: (context) => di.sl<AttendanceManagementBloc>(),
            child: AttendanceMarkingScreen(
              institutionId: institutionId,
              classId: classId,
              selectedDate: selectedDate,
            ),
          );
        },
      ),
      GoRoute(
        path: attendanceHistoryRoute,
        name: 'attendance-history',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          final classId = state.pathParameters['classId'] ?? '';
          return BlocProvider(
            create: (context) => di.sl<AttendanceManagementBloc>(),
            child: AttendanceHistoryScreen(
              institutionId: institutionId,
              classId: classId,
            ),
          );
        },
      ),
      GoRoute(
        path: attendanceDetailRoute,
        name: 'attendance-detail',
        builder: (context, state) {
          final institutionId = state.pathParameters['institutionId'] ?? '';
          final attendanceId = state.pathParameters['attendanceId'] ?? '';
          return BlocProvider(
            create: (context) => di.sl<AttendanceManagementBloc>(),
            child: AttendanceSessionDetailScreen(
              institutionId: institutionId,
              attendanceId: attendanceId,
            ),
          );
        },
      ),
    ],
  );
}

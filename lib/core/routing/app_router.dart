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
  static const String editInstitutionRoute = '/institutions/:institutionId/edit';

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
            create: (context) => di.sl<InstitutionManagementBloc>()
              ..add(LoadInstitution(institutionId: institutionId)),
            child: BlocBuilder<InstitutionManagementBloc,
                InstitutionManagementState>(
              builder: (context, state) {
                if (state is InstitutionLoaded) {
                  return InstitutionFormScreen(institution: state.institution);
                }
                if (state is InstitutionManagementError) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Error'),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    body: Center(
                      child: Text(state.message),
                    ),
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
    ],
  );
}

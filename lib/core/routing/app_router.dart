part of '../core.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String passwordResetRoute = '/password-reset';
  static const String institutionSelectionRoute = '/institution-selection';
  static const String dashboardRoute = '/dashboard';
  static const String userDetailsRoute = '/user-details';

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
    ],
  );
}

part of '../core.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String passwordResetRoute = '/password-reset';
  static const String institutionSelectionRoute = '/institution-selection';
  static const String dashboardRoute = '/dashboard';
  static const String userDetailsRoute = '/user-details';

  static final GoRouter router = GoRouter(
    initialLocation: loginRoute,
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final authState = authBloc.state;

      // Check if user is authenticated
      if (authState is Authenticated) {
        // If on login page, redirect to user details
        if (state.uri.path == loginRoute) {
          return userDetailsRoute;
        }
        return null; // Allow navigation
      } else if (authState is Unauthenticated) {
        // If not authenticated and not on login/password reset, redirect to login
        if (state.uri.path != loginRoute &&
            state.uri.path != passwordResetRoute) {
          return loginRoute;
        }
        return null; // Allow navigation to login/password reset
      }

      return null; // No redirect needed
    },
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
        path: userDetailsRoute,
        name: 'user-details',
        builder: (context, state) => const UserDetailsScreen(),
      ),
    ],
  );
}

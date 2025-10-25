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
        final user = authState.user;

        // Check if user has currentInstitutionId set
        if (user.currentInstitutionId != null &&
            user.currentInstitutionId!.isNotEmpty) {
          // User has selected institution, redirect to dashboard
          if (state.uri.path == loginRoute ||
              state.uri.path == institutionSelectionRoute) {
            return dashboardRoute;
          }
          return null; // Allow navigation
        } else {
          // User needs to select institution
          if (user.hasMultipleInstitutions) {
            // User has multiple institutions, show selection screen
            if (state.uri.path == loginRoute) {
              return institutionSelectionRoute;
            }
            return null; // Allow navigation to institution selection
          } else if (user.activeInstitutionIds.isNotEmpty) {
            // User has only one institution, auto-select it and redirect to dashboard
            final institutionId = user.activeInstitutionIds.first;
            authBloc.add(
              InstitutionSelectionRequested(institutionId: institutionId),
            );
            // Don't redirect here, let the BLoC handle it and then redirect
            return null;
          } else {
            // User has no institutions, redirect to user details
            if (state.uri.path == loginRoute) {
              return userDetailsRoute;
            }
            return null; // Allow navigation
          }
        }
      } else if (authState is InstitutionSelected) {
        // After institution selection, redirect to dashboard
        if (state.uri.path == institutionSelectionRoute) {
          return dashboardRoute;
        }
        return null;
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
        redirect: (context, state) {},
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

part of '../core.dart';

class RouteGuards {
  static bool isAuthenticated(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    return authState is Authenticated;
  }

  static bool isSessionValid(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    if (authState is Authenticated) {
      // Check if user has active roles
      return authState.user.hasActiveRoles;
    }

    return false;
  }

  static void checkAuthStatus(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(CheckAuthStatus());
  }

  static void logout(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(LogoutRequested());
  }

  static String? getRedirectRoute(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    // Check if user is authenticated
    if (authState is Authenticated) {
      return _handleAuthenticatedUser(authState.user, state.uri.path, authBloc);
    } else if (authState is InstitutionSelected) {
      return _handleInstitutionSelected(state.uri.path);
    } else if (authState is Unauthenticated) {
      return _handleUnauthenticated(state.uri.path);
    }

    return null; // No redirect needed
  }

  static String? _handleAuthenticatedUser(
    User user,
    String currentPath,
    AuthBloc authBloc,
  ) {
    // Check if user has currentInstitutionId set
    if (user.currentInstitutionId != null &&
        user.currentInstitutionId!.isNotEmpty) {
      // User has selected institution
      if (currentPath == AppRouter.loginRoute) {
        return AppRouter.dashboardRoute;
      }
      // Allow navigation to institution selection for switching
      return null;
    } else {
      // User needs to select institution
      return _handleUserNeedsInstitutionSelection(user, currentPath, authBloc);
    }
  }

  static String? _handleUserNeedsInstitutionSelection(
    User user,
    String currentPath,
    AuthBloc authBloc,
  ) {
    if (user.hasMultipleInstitutions) {
      // User has multiple institutions, show selection screen
      if (currentPath == AppRouter.loginRoute ||
          currentPath == AppRouter.dashboardRoute) {
        return AppRouter.institutionSelectionRoute;
      }
      return null; // Allow navigation to institution selection
    } else if (user.activeInstitutionIds.isNotEmpty) {
      // User has only one institution, auto-select it and redirect to dashboard
      final institutionId = user.activeInstitutionIds.first;
      authBloc.add(InstitutionSelectionRequested(institutionId: institutionId));
      // Don't redirect here, let the BLoC handle it and then redirect
      return null;
    } else {
      // User has no institutions, redirect to user details
      if (currentPath == AppRouter.loginRoute) {
        return AppRouter.userDetailsRoute;
      }
      return null; // Allow navigation
    }
  }

  static String? _handleInstitutionSelected(String currentPath) {
    // After institution selection, redirect to dashboard
    if (currentPath == AppRouter.institutionSelectionRoute) {
      return AppRouter.dashboardRoute;
    }
    return null;
  }

  static String? _handleUnauthenticated(String currentPath) {
    // If not authenticated and not on login/password reset, redirect to login
    if (currentPath != AppRouter.loginRoute &&
        currentPath != AppRouter.passwordResetRoute) {
      return AppRouter.loginRoute;
    }
    return null; // Allow navigation to login/password reset
  }
}

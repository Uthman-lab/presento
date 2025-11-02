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

    // Check if route requires super admin access
    final currentPath = state.uri.path;
    final isInstitutionManagementRoute =
        currentPath == AppRouter.institutionsRoute ||
        currentPath == AppRouter.createInstitutionRoute;

    if (isInstitutionManagementRoute) {
      final user = _getUserFromState(authState);
      if (user == null || !user.isSuperAdmin) {
        return AppRouter
            .dashboardRoute; // Redirect non-super admins to dashboard
      }
    }

    // Check institution subroutes (classes, students, attendance, etc.)
    // These should be accessible if user has access to that institution
    if (currentPath.startsWith('/institutions/') &&
        !isInstitutionManagementRoute) {
      final institutionIdMatch = RegExp(
        r'/institutions/([^/]+)',
      ).firstMatch(currentPath);
      if (institutionIdMatch != null) {
        final institutionId = institutionIdMatch.group(1);
        final user = _getUserFromState(authState);

        // Super admin has access to all institutions
        if (user != null && user.isSuperAdmin) {
          // Allow access
        } else if (user != null && institutionId != null) {
          // Check if user has access to this institution
          final hasAccess =
              user.isSuperAdmin ||
              (user.currentInstitutionId == institutionId) ||
              (user.roles.containsKey(institutionId) &&
                  user.roles[institutionId]?.isActive == true);

          if (!hasAccess) {
            return AppRouter.dashboardRoute;
          }
        } else if (user == null) {
          return AppRouter.loginRoute;
        }
      }
    }

    // Handle all authenticated state variants
    if (authState is Authenticated ||
        authState is AllInstitutionsLoaded ||
        authState is InstitutionsLoaded) {
      // Extract user from any authenticated state variant
      final user = authState is Authenticated
          ? authState.user
          : (authState as dynamic).user as User;
      return _handleAuthenticatedUser(user, state.uri.path, authBloc);
    } else if (authState is InstitutionSelected) {
      return _handleInstitutionSelected(state.uri.path);
    } else if (authState is Unauthenticated) {
      return _handleUnauthenticated(state.uri.path);
    }

    return null; // No redirect needed (e.g., AuthLoading, AuthInitial)
  }

  static User? _getUserFromState(AuthState authState) {
    // All these states extend Authenticated or have user property
    if (authState is Authenticated) {
      return authState.user;
    }
    // InstitutionsLoaded, AllInstitutionsLoaded, and InstitutionSelected extend Authenticated
    // so they can be accessed through the Authenticated interface
    return null;
  }

  static String? _handleAuthenticatedUser(
    User user,
    String currentPath,
    AuthBloc authBloc,
  ) {
    // Super admin bypasses institution selection and goes directly to dashboard
    if (user.isSuperAdmin) {
      if (currentPath == AppRouter.loginRoute ||
          currentPath == AppRouter.institutionSelectionRoute) {
        return AppRouter.dashboardRoute;
      }
      return null; // Allow navigation to dashboard
    }

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
    // Super admin should not reach here, but handle it just in case
    if (user.isSuperAdmin) {
      // If super admin is on dashboard, don't redirect (avoid loop)
      if (currentPath == AppRouter.dashboardRoute) {
        return null;
      }
      // Only redirect from login to dashboard
      if (currentPath == AppRouter.loginRoute) {
        return AppRouter.dashboardRoute;
      }
      return null;
    }

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

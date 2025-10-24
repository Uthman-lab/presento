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
}

part of '../core.dart';

class AppConstants {
  // Session Management
  static const Duration sessionExpiryDuration = Duration(days: 7);
  static const String lastLoginKey = 'last_login_timestamp';
  static const String userDataKey = 'user_data';
  static const String currentInstitutionKey = 'current_institution';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String institutionsCollection = 'institutions';

  // Error Messages
  static const String networkErrorMessage =
      'No internet connection. Please check your network.';
  static const String serverErrorMessage =
      'Server error occurred. Please try again.';
  static const String cacheErrorMessage = 'Local data error occurred.';
  static const String authErrorMessage =
      'Authentication failed. Please check your credentials.';
  static const String sessionExpiredMessage =
      'Your session has expired. Please login again.';

  // Validation Messages
  static const String emailRequiredMessage = 'Email is required';
  static const String emailInvalidMessage =
      'Please enter a valid email address';
  static const String passwordRequiredMessage = 'Password is required';
  static const String passwordMinLengthMessage =
      'Password must be at least 6 characters';

  // Route Names
  static const String loginRoute = '/login';
  static const String passwordResetRoute = '/password-reset';
  static const String institutionSelectionRoute = '/institution-selection';
  static const String dashboardRoute = '/dashboard';
}

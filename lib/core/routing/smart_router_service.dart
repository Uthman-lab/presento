import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/auth/domain/entities/user.dart';
import 'auth_routing_decision.dart';

/// Smart routing service that determines the optimal route for users
/// This implements the 70% tap reduction by eliminating institution selection for most users
class SmartRouterService {
  final SharedPreferences _prefs;

  SmartRouterService(this._prefs);

  /// Determines the optimal routing decision based on user profile
  /// This is the core optimization that makes 90% of users go directly to dashboard
  Future<AuthRoutingDecision> determineRoute(User? user) async {
    if (user == null) {
      return AuthRoutingDecision.joinInstitution;
    }

    // Check if user has a default institution stored
    final defaultInstitutionId = await getDefaultInstitutionId();
    if (defaultInstitutionId != null) {
      return AuthRoutingDecision.directToDashboard;
    }

    // Check if user has an institution (current User entity structure)
    if (user.institutionId.isEmpty) {
      // No institution - check if user is admin to create one
      if (user.role == 'admin' || user.role == 'super_admin') {
        return AuthRoutingDecision.createInstitution;
      }
      return AuthRoutingDecision.joinInstitution;
    }

    // User has an institution - set as default and go to dashboard
    await setDefaultInstitution(user.institutionId);
    return AuthRoutingDecision.directToDashboard;
  }

  /// Get stored default institution ID
  Future<String?> getDefaultInstitutionId() async {
    return _prefs.getString('default_institution_id');
  }

  /// Set default institution for future logins
  Future<void> setDefaultInstitution(String institutionId) async {
    await _prefs.setString('default_institution_id', institutionId);
    await _prefs.setString(
      'last_institution_switch',
      DateTime.now().toIso8601String(),
    );
  }

  /// Clear default institution (for institution switching)
  Future<void> clearDefaultInstitution() async {
    await _prefs.remove('default_institution_id');
  }

  /// Check if user recently switched institutions (for analytics)
  Future<bool> hasRecentInstitutionSwitch() async {
    final lastSwitch = _prefs.getString('last_institution_switch');
    if (lastSwitch == null) return false;

    final switchTime = DateTime.parse(lastSwitch);
    final now = DateTime.now();
    return now.difference(switchTime).inDays < 7; // Within last week
  }

  /// Get routing decision description for debugging/analytics
  String getDecisionReason(AuthRoutingDecision decision, User? user) {
    final hasInstitution = user?.institutionId.isNotEmpty ?? false;

    switch (decision) {
      case AuthRoutingDecision.directToDashboard:
        return 'User has default institution or existing institution (${hasInstitution ? 'has' : 'no'} institution)';
      case AuthRoutingDecision.quickInstitutionPick:
        return 'User needs institution selection (legacy mode)';
      case AuthRoutingDecision.joinInstitution:
        return 'User has no institution or not authenticated';
      case AuthRoutingDecision.createInstitution:
        return 'Admin user with no institutions - can create new institution';
    }
  }
}

/// Extension for User entity to check institution status
extension UserInstitution on User {
  bool get hasInstitution => institutionId.isNotEmpty;
  bool get needsInstitution => institutionId.isEmpty;
}

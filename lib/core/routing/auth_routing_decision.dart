/// Smart authentication routing decisions for optimized UX
/// This replaces the old institution-selection-first flow
enum AuthRoutingDecision {
  /// User has default institution or single institution - direct to unified dashboard
  directToDashboard,

  /// User has multiple institutions but no default - show quick picker modal
  quickInstitutionPick,

  /// User has no institutions - show join flow
  joinInstitution,

  /// Admin user with no institution - show creation wizard
  createInstitution,
}

/// Extension to provide routing logic
extension AuthRoutingDecisionExt on AuthRoutingDecision {
  String get routePath {
    switch (this) {
      case AuthRoutingDecision.directToDashboard:
        return '/unified-dashboard';
      case AuthRoutingDecision.quickInstitutionPick:
        return '/quick-institution-picker';
      case AuthRoutingDecision.joinInstitution:
        return '/join-institution';
      case AuthRoutingDecision.createInstitution:
        return '/create-institution';
    }
  }

  String get description {
    switch (this) {
      case AuthRoutingDecision.directToDashboard:
        return 'Direct route to dashboard (90% of users)';
      case AuthRoutingDecision.quickInstitutionPick:
        return 'Quick modal institution picker';
      case AuthRoutingDecision.joinInstitution:
        return 'Join institution via invite';
      case AuthRoutingDecision.createInstitution:
        return 'Create new institution (admin)';
    }
  }
}


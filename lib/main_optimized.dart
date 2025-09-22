import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routing/auth_routing_decision.dart';
import 'core/routing/smart_router_service.dart';
import 'core/services/smart_cache_manager.dart';

// Blocs
import 'ui/auth/bloc/auth_bloc.dart';
import 'ui/dashboard/bloc/dashboard_bloc.dart';
import 'ui/class/bloc/class_management_bloc.dart';
import 'ui/student/bloc/student_management_bloc.dart';
import 'ui/attendance/bloc/attendance_bloc.dart';
import 'ui/attendance/bloc/attendance_report_bloc.dart';

// Screens - New Optimized Flow
import 'ui/dashboard/screens/unified_dashboard_screen.dart';
// TODO: Create these screens when implementing edge cases
// import 'ui/auth/screens/quick_institution_picker_screen.dart';
// import 'ui/auth/screens/join_institution_screen.dart';
// import 'ui/auth/screens/create_institution_screen.dart';

// Legacy screens (for fallback)
import 'ui/auth/screens/institution_selection_screen.dart';
import 'ui/dashboard/screens/role_based_dashboard_screen.dart';

// Other screens
import 'ui/class/screens/class_management_screen.dart';
import 'ui/student/screens/student_management_screen.dart';
import 'ui/attendance/screens/attendance_taking_screen.dart';
import 'ui/attendance/screens/attendance_report_screen.dart';

import 'modules/auth/domain/entities/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies
  await di.initDependencies();

  // Preload critical data for <800ms launch time
  final cacheManager = di.getIt<SmartCacheManager>();
  await cacheManager.preloadCriticalData();

  runApp(const MyOptimizedApp());
}

/// Optimized app with smart authentication flow
class MyOptimizedApp extends StatelessWidget {
  const MyOptimizedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<AuthBloc>()..add(const AuthEvent.authStatusChanged()),
      child: MaterialApp.router(
        routerConfig: _optimizedRouter,
        title: 'Task Master Attendance System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}

/// Optimized router with smart authentication flow
final _optimizedRouter = GoRouter(
  routes: [
    // Root route - smart authentication decision
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        // This is the core optimization - smart routing based on auth state
        final authBloc = context.read<AuthBloc>();
        final authState = authBloc.state;

        return authState.maybeWhen(
          authenticated: (user) async {
            // User is authenticated - use smart routing
            final smartRouter = di.getIt<SmartRouterService>();
            final decision = await smartRouter.determineRoute(user);
            return decision.routePath;
          },
          unauthenticated: () => '/login',
          orElse: () => '/login',
        );
      },
      builder: (context, state) => const SizedBox.shrink(), // Never shown
    ),

    // Login screen (only when not authenticated)
    GoRoute(
      path: '/login',
      builder: (context, state) {
        // For now, redirect to legacy institution selection since LoginScreen requires institution
        // TODO: Create optimized LoginScreen that doesn't require institution selection
        return const InstitutionSelectionScreen();
      },
    ),

    // OPTIMIZED FLOW ROUTES

    // Unified dashboard (90% of users go here directly)
    GoRoute(
      path: '/unified-dashboard',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => di.getIt<DashboardBloc>(),
          child: const UnifiedDashboardScreen(),
        );
      },
    ),

    // Quick institution picker (multiple institutions, no default)
    GoRoute(
      path: '/quick-institution-picker',
      builder: (context, state) {
        // Placeholder - redirect to legacy institution selection for now
        return const InstitutionSelectionScreen();
      },
    ),

    // Join institution flow (no memberships)
    GoRoute(
      path: '/join-institution',
      builder: (context, state) {
        // Placeholder - show simple screen with message
        return const Scaffold(
          body: Center(child: Text('Join Institution - Coming Soon')),
        );
      },
    ),

    // Create institution (admin with no institutions)
    GoRoute(
      path: '/create-institution',
      builder: (context, state) {
        // Placeholder - show simple screen with message
        return const Scaffold(
          body: Center(child: Text('Create Institution - Coming Soon')),
        );
      },
    ),

    // LEGACY ROUTES (for fallback/comparison)
    GoRoute(
      path: '/legacy/institution-selection',
      builder: (context, state) => const InstitutionSelectionScreen(),
    ),

    GoRoute(
      path: '/legacy/role-dashboard',
      builder: (context, state) {
        final user = state.extra as User;
        return BlocProvider(
          create: (context) => di.getIt<DashboardBloc>(),
          child: RoleBasedDashboardScreen(user: user),
        );
      },
    ),

    // SHARED FEATURE ROUTES (work with both old and new flows)
    GoRoute(
      path: '/class-management',
      builder: (context, state) => BlocProvider(
        create: (context) => di.getIt<ClassManagementBloc>(),
        child: ClassManagementScreen(institutionId: state.extra as String),
      ),
    ),

    GoRoute(
      path: '/student-management',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<StudentManagementBloc>(),
          child: StudentManagementScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),

    GoRoute(
      path: '/attendance-taking',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<AttendanceBloc>(),
          child: AttendanceTakingScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),

    GoRoute(
      path: '/attendance-report',
      builder: (context, state) {
        final params = state.extra as Map<String, String>;
        return BlocProvider(
          create: (context) => di.getIt<AttendanceReportBloc>(),
          child: AttendanceReportScreen(
            institutionId: params['institutionId']!,
            classId: params['classId']!,
          ),
        );
      },
    ),

    // Settings route
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        // TODO: Implement settings screen with institution switching
        return const Scaffold(
          body: Center(child: Text('Settings Screen - Coming Soon')),
        );
      },
    ),
  ],

  // Handle route errors
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const SizedBox(height: 16),
          Text('Route Error: ${state.error}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),

  // Redirect configuration for optimized flow
  redirect: (context, state) async {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    // If trying to access protected routes while unauthenticated
    final protectedRoutes = [
      '/unified-dashboard',
      '/quick-institution-picker',
      '/join-institution',
      '/create-institution',
      '/class-management',
      '/student-management',
      '/attendance-taking',
      '/attendance-report',
      '/settings',
    ];

    if (protectedRoutes.contains(state.uri.path)) {
      return authState.maybeWhen(
        unauthenticated: () => '/login',
        orElse: () => null, // Allow access
      );
    }

    return null; // No redirect needed
  },
);

/// Feature flag for switching between old and new flows
class FeatureFlags {
  static bool get useOptimizedFlow => true; // Set to false to use old flow
  static bool get enableSmartCaching => true;
  static bool get enableBackgroundSync => true;
  static bool get enableGestureInteractions => true;
}

/// Analytics helper for measuring optimization impact
class OptimizationAnalytics {
  static void trackAppLaunchTime(Duration launchTime) {
    print(
      '📊 App launch time: ${launchTime.inMilliseconds}ms (target: <800ms)',
    );
  }

  static void trackDashboardLoadTime(Duration loadTime) {
    print(
      '📊 Dashboard load time: ${loadTime.inMilliseconds}ms (target: <500ms)',
    );
  }

  static void trackUserJourney(String journey, int tapCount) {
    print('📊 User journey: $journey completed in $tapCount taps');
  }

  static void trackRoutingDecision(AuthRoutingDecision decision, User? user) {
    final smartRouter = di.getIt<SmartRouterService>();
    final reason = smartRouter.getDecisionReason(decision, user);
    print('📊 Routing decision: ${decision.name} - $reason');
  }
}

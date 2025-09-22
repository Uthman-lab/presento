import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routing/auth_routing_decision.dart';
import 'core/routing/smart_router_service.dart';
import 'core/services/smart_cache_manager.dart';

// For seeding data
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'modules/auth/domain/entities/user.dart' as app_user;
import 'modules/auth/domain/entities/institution.dart';

// Blocs
import 'ui/auth/bloc/auth_bloc.dart';
import 'ui/auth/screens/login_screen.dart';
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

  // 🌱 SEED DUMMY DATA FOR TESTING - REMOVE AFTER TESTING
  // 📝 TO REMOVE: Delete this line and all seed functions below MyOptimizedApp class
  await seedDummyData();

  runApp(const MyOptimizedApp());
}

/// 🌱 SEED DUMMY DATA FOR TESTING
/// Creates test users and institutions so you can immediately test the optimized workflow
/// 📝 DELETE THIS FUNCTION AFTER TESTING!
Future<void> seedDummyData() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final auth = firebase_auth.FirebaseAuth.instance;

    print('🌱 Checking if dummy data already exists...');

    // Check if data already exists
    const institutionId = 'tech_university_2024';
    final institutionDoc = await firestore
        .collection('institutions')
        .doc(institutionId)
        .get();

    if (institutionDoc.exists) {
      print('ℹ️  Institution already exists, ensuring user documents...');

      // Ensure all test users have Firestore documents
      final testUsers = [
        {
          'email': 'admin@test.com',
          'name': 'John Admin',
          'role': 'admin',
          'id': 'admin_001',
        },
        {
          'email': 'supervisor@test.com',
          'name': 'Sarah Supervisor',
          'role': 'supervisor',
          'id': 'supervisor_001',
        },
        {
          'email': 'classrep@test.com',
          'name': 'Mike ClassRep',
          'role': 'class_rep',
          'id': 'classrep_001',
        },
        {
          'email': 'stakeholder@test.com',
          'name': 'Emma Stakeholder',
          'role': 'stakeholder',
          'id': 'stakeholder_001',
        },
      ];

      for (final userData in testUsers) {
        final userDoc = await firestore
            .collection('users')
            .doc(userData['id'] as String)
            .get();

        if (!userDoc.exists) {
          print('📝 Creating missing user document for ${userData['email']}');
          await firestore
              .collection('users')
              .doc(userData['id'] as String)
              .set({
                'id': userData['id'],
                'email': userData['email'],
                'name': userData['name'],
                'role': userData['role'],
                'institutionId': institutionId,
                'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
              });
        } else {
          print('✅ User document exists for ${userData['email']}');
        }
      }

      print('🔑 Use these test credentials:');
      print('👤 Admin: admin@test.com / password123');
      print('👤 Supervisor: supervisor@test.com / password123');
      print('👤 Class Rep: classrep@test.com / password123');
      print('👤 Stakeholder: stakeholder@test.com / password123');
      return;
    }

    print('🌱 Seeding fresh dummy data...');

    // Create dummy institution
    final institution = Institution(
      id: institutionId,
      name: 'Tech University',
      description: 'Leading technology education institution',
      address: '123 Innovation Drive, Tech City, TC 12345',
      phone: '+1 (555) 123-4567',
      email: 'info@techuniversity.edu',
      website: 'https://techuniversity.edu',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Add institution to Firestore
    await firestore.collection('institutions').doc(institutionId).set({
      'id': institution.id,
      'name': institution.name,
      'description': institution.description,
      'address': institution.address,
      'phone': institution.phone,
      'email': institution.email,
      'website': institution.website,
      'createdAt': Timestamp.fromDate(institution.createdAt),
      'updatedAt': Timestamp.fromDate(institution.updatedAt),
    });

    // Create test users with different roles
    final testUsers = [
      {
        'email': 'admin@test.com',
        'password': 'password123',
        'name': 'John Admin',
        'role': 'admin',
        'id': 'admin_001',
      },
      {
        'email': 'supervisor@test.com',
        'password': 'password123',
        'name': 'Sarah Supervisor',
        'role': 'supervisor',
        'id': 'supervisor_001',
      },
      {
        'email': 'classrep@test.com',
        'password': 'password123',
        'name': 'Mike ClassRep',
        'role': 'class_rep',
        'id': 'classrep_001',
      },
      {
        'email': 'stakeholder@test.com',
        'password': 'password123',
        'name': 'Lisa Stakeholder',
        'role': 'stakeholder',
        'id': 'stakeholder_001',
      },
    ];

    for (final userData in testUsers) {
      try {
        // Create Firebase Auth user
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: userData['email'] as String,
          password: userData['password'] as String,
        );

        if (userCredential.user != null) {
          // Create app user document in Firestore
          final appUser = app_user.User(
            id: userData['id'] as String,
            email: userData['email'] as String,
            name: userData['name'] as String,
            role: userData['role'] as String,
            institutionId: institutionId,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          await firestore.collection('users').doc(appUser.id).set({
            'id': appUser.id,
            'email': appUser.email,
            'name': appUser.name,
            'role': appUser.role,
            'institutionId': appUser.institutionId,
            'profilePictureUrl': appUser.profilePictureUrl,
            'createdAt': Timestamp.fromDate(appUser.createdAt),
            'updatedAt': Timestamp.fromDate(appUser.updatedAt),
          });

          print('✅ Created ${userData['role']}: ${userData['email']}');
        }
      } catch (e) {
        if (e.toString().contains('email-already-in-use')) {
          print('ℹ️  User ${userData['email']} already exists, skipping...');
        } else {
          print('❌ Error creating user ${userData['email']}: $e');
        }
      }
    }

    // Create some dummy classes for testing
    await _createDummyClasses(firestore, institutionId);

    // Create dummy students for testing
    await _createDummyStudents(firestore, institutionId);

    // Create dummy attendance records for realistic dashboard
    await _createDummyAttendance(firestore, institutionId);

    print('🎉 Dummy data seeded successfully!');
    print('');
    print('🔑 Test Login Credentials:');
    print('👤 Admin: admin@test.com / password123');
    print('👤 Supervisor: supervisor@test.com / password123');
    print('👤 Class Rep: classrep@test.com / password123');
    print('👤 Stakeholder: stakeholder@test.com / password123');
    print('');
    print(
      '📊 Dashboard will show realistic data with students and attendance!',
    );
    print('📝 Remember to DELETE the seedDummyData() function after testing!');
  } catch (e) {
    print('❌ Error seeding data: $e');
  }
}

/// Create dummy classes for testing
Future<void> _createDummyClasses(
  FirebaseFirestore firestore,
  String institutionId,
) async {
  final classes = [
    {
      'id': 'cs101_2024',
      'name': 'Computer Science 101',
      'description': 'Introduction to Programming',
      'institutionId': institutionId,
      'semester': 'Fall 2024',
      'studentCount': 30,
    },
    {
      'id': 'math201_2024',
      'name': 'Mathematics 201',
      'description': 'Advanced Calculus',
      'institutionId': institutionId,
      'semester': 'Fall 2024',
      'studentCount': 25,
    },
    {
      'id': 'phys301_2024',
      'name': 'Physics 301',
      'description': 'Quantum Mechanics',
      'institutionId': institutionId,
      'semester': 'Fall 2024',
      'studentCount': 20,
    },
  ];

  for (final classData in classes) {
    await firestore.collection('classes').doc(classData['id'] as String).set({
      'id': classData['id'],
      'name': classData['name'],
      'description': classData['description'],
      'institutionId': classData['institutionId'],
      'semester': classData['semester'],
      'studentCount': classData['studentCount'],
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  print('✅ Created ${classes.length} dummy classes');
}

/// Create dummy students for testing
Future<void> _createDummyStudents(
  FirebaseFirestore firestore,
  String institutionId,
) async {
  final students = [
    // CS 101 Students
    {
      'id': 'std_001',
      'name': 'Alice Johnson',
      'email': 'alice@student.com',
      'classId': 'cs101_2024',
      'studentId': 'CS2024001',
    },
    {
      'id': 'std_002',
      'name': 'Bob Smith',
      'email': 'bob@student.com',
      'classId': 'cs101_2024',
      'studentId': 'CS2024002',
    },
    {
      'id': 'std_003',
      'name': 'Carol Davis',
      'email': 'carol@student.com',
      'classId': 'cs101_2024',
      'studentId': 'CS2024003',
    },
    {
      'id': 'std_004',
      'name': 'David Wilson',
      'email': 'david@student.com',
      'classId': 'cs101_2024',
      'studentId': 'CS2024004',
    },
    {
      'id': 'std_005',
      'name': 'Emma Brown',
      'email': 'emma@student.com',
      'classId': 'cs101_2024',
      'studentId': 'CS2024005',
    },

    // Math 201 Students
    {
      'id': 'std_006',
      'name': 'Frank Miller',
      'email': 'frank@student.com',
      'classId': 'math201_2024',
      'studentId': 'MT2024001',
    },
    {
      'id': 'std_007',
      'name': 'Grace Taylor',
      'email': 'grace@student.com',
      'classId': 'math201_2024',
      'studentId': 'MT2024002',
    },
    {
      'id': 'std_008',
      'name': 'Henry Anderson',
      'email': 'henry@student.com',
      'classId': 'math201_2024',
      'studentId': 'MT2024003',
    },
    {
      'id': 'std_009',
      'name': 'Ivy Thomas',
      'email': 'ivy@student.com',
      'classId': 'math201_2024',
      'studentId': 'MT2024004',
    },

    // Physics 301 Students
    {
      'id': 'std_010',
      'name': 'Jack Garcia',
      'email': 'jack@student.com',
      'classId': 'phys301_2024',
      'studentId': 'PH2024001',
    },
    {
      'id': 'std_011',
      'name': 'Kelly Martinez',
      'email': 'kelly@student.com',
      'classId': 'phys301_2024',
      'studentId': 'PH2024002',
    },
    {
      'id': 'std_012',
      'name': 'Liam Rodriguez',
      'email': 'liam@student.com',
      'classId': 'phys301_2024',
      'studentId': 'PH2024003',
    },
  ];

  for (final studentData in students) {
    await firestore
        .collection('students')
        .doc(studentData['id'] as String)
        .set({
          'id': studentData['id'],
          'name': studentData['name'],
          'email': studentData['email'],
          'studentId': studentData['studentId'],
          'classId': studentData['classId'],
          'institutionId': institutionId,
          'createdAt': Timestamp.fromDate(DateTime.now()),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
  }

  print('✅ Created ${students.length} dummy students');
}

/// Create dummy attendance records for realistic dashboard statistics
Future<void> _createDummyAttendance(
  FirebaseFirestore firestore,
  String institutionId,
) async {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1));

  // Create attendance records for the last 3 days
  final attendanceRecords = [
    // Today's attendance - CS 101 (mostly present)
    {
      'classId': 'cs101_2024',
      'studentId': 'std_001',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 9, minute: 0),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_002',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 9, minute: 5),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_003',
      'date': today,
      'status': 'late',
      'timestamp': today.copyWith(hour: 9, minute: 15),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_004',
      'date': today,
      'status': 'absent',
      'timestamp': null,
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_005',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 8, minute: 58),
    },

    // Today's attendance - Math 201 (good attendance)
    {
      'classId': 'math201_2024',
      'studentId': 'std_006',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 10, minute: 0),
    },
    {
      'classId': 'math201_2024',
      'studentId': 'std_007',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 10, minute: 2),
    },
    {
      'classId': 'math201_2024',
      'studentId': 'std_008',
      'date': today,
      'status': 'present',
      'timestamp': today.copyWith(hour: 9, minute: 58),
    },
    {
      'classId': 'math201_2024',
      'studentId': 'std_009',
      'date': today,
      'status': 'late',
      'timestamp': today.copyWith(hour: 10, minute: 12),
    },

    // Yesterday's attendance - mixed
    {
      'classId': 'cs101_2024',
      'studentId': 'std_001',
      'date': yesterday,
      'status': 'present',
      'timestamp': yesterday.copyWith(hour: 9, minute: 0),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_002',
      'date': yesterday,
      'status': 'absent',
      'timestamp': null,
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_003',
      'date': yesterday,
      'status': 'present',
      'timestamp': yesterday.copyWith(hour: 9, minute: 3),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_004',
      'date': yesterday,
      'status': 'present',
      'timestamp': yesterday.copyWith(hour: 9, minute: 1),
    },
    {
      'classId': 'cs101_2024',
      'studentId': 'std_005',
      'date': yesterday,
      'status': 'late',
      'timestamp': yesterday.copyWith(hour: 9, minute: 20),
    },
  ];

  for (int i = 0; i < attendanceRecords.length; i++) {
    final record = attendanceRecords[i];
    final attendanceId = 'att_${i.toString().padLeft(3, '0')}';

    await firestore.collection('attendance').doc(attendanceId).set({
      'id': attendanceId,
      'classId': record['classId'],
      'studentId': record['studentId'],
      'date': Timestamp.fromDate(record['date'] as DateTime),
      'status': record['status'],
      'timestamp': record['timestamp'] != null
          ? Timestamp.fromDate(record['timestamp'] as DateTime)
          : null,
      'institutionId': institutionId,
      'submittedBy': 'classrep_001', // Class rep submitted
      'submittedAt': Timestamp.fromDate(
        (record['date'] as DateTime).copyWith(hour: 9, minute: 30),
      ),
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  print('✅ Created ${attendanceRecords.length} dummy attendance records');
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
  initialLocation: '/login',
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
        return const LoginScreen();
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

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'firebase_options.dart';
// import 'core/di/injection_container.dart' as di;
// import 'ui/auth/bloc/auth_bloc.dart';
// import 'ui/class/bloc/class_management_bloc.dart';
// import 'ui/student/bloc/student_management_bloc.dart';
// import 'ui/attendance/bloc/attendance_bloc.dart';
// import 'ui/attendance/bloc/attendance_report_bloc.dart';

// import 'ui/dashboard/bloc/dashboard_bloc.dart';
// import 'ui/auth/screens/institution_selection_screen.dart';
// import 'ui/auth/screens/login_screen.dart';
// import 'ui/dashboard/screens/dashboard_screen.dart';
// import 'ui/dashboard/screens/role_based_dashboard_screen.dart';
// import 'ui/class/screens/class_management_screen.dart';
// import 'ui/student/screens/student_management_screen.dart';
// import 'ui/attendance/screens/attendance_taking_screen.dart';
// import 'ui/attendance/screens/attendance_report_screen.dart';

// import 'modules/auth/domain/entities/institution.dart';
// import 'modules/auth/domain/entities/user.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await di.initDependencies();
//   runApp(const MyApp());
// }

// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const InstitutionSelectionScreen(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (context, state) =>
//           LoginScreen(institution: state.extra as Institution),
//     ),
//     GoRoute(
//       path: '/dashboard',
//       builder: (context, state) {
//         return BlocProvider(
//           create: (context) => di.getIt<DashboardBloc>(),
//           child: const DashboardScreen(),
//         );
//       },
//     ),
//     GoRoute(
//       path: '/role-dashboard',
//       builder: (context, state) {
//         final user = state.extra as User;
//         return BlocProvider(
//           create: (context) => di.getIt<DashboardBloc>(),
//           child: RoleBasedDashboardScreen(user: user),
//         );
//       },
//     ),
//     GoRoute(
//       path: '/class-management',
//       builder: (context, state) => BlocProvider(
//         create: (context) => di.getIt<ClassManagementBloc>(),
//         child: ClassManagementScreen(institutionId: state.extra as String),
//       ),
//     ),
//     GoRoute(
//       path: '/student-management',
//       builder: (context, state) {
//         final params = state.extra as Map<String, String>;
//         return BlocProvider(
//           create: (context) => di.getIt<StudentManagementBloc>(),
//           child: StudentManagementScreen(
//             institutionId: params['institutionId']!,
//             classId: params['classId']!,
//           ),
//         );
//       },
//     ),
//     GoRoute(
//       path: '/attendance-taking',
//       builder: (context, state) {
//         final params = state.extra as Map<String, String>;
//         return BlocProvider(
//           create: (context) => di.getIt<AttendanceBloc>(),
//           child: AttendanceTakingScreen(
//             institutionId: params['institutionId']!,
//             classId: params['classId']!,
//           ),
//         );
//       },
//     ),
//     GoRoute(
//       path: '/attendance-report',
//       builder: (context, state) {
//         final params = state.extra as Map<String, String>;
//         return BlocProvider(
//           create: (context) => di.getIt<AttendanceReportBloc>(),
//           child: AttendanceReportScreen(
//             institutionId: params['institutionId']!,
//             classId: params['classId']!,
//           ),
//         );
//       },
//     ),
//   ],
// );

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           di.getIt<AuthBloc>()..add(const AuthEvent.authStatusChanged()),
//       child: MaterialApp.router(
//         routerConfig: _router,
//         title: 'Task Master Attendance System',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//           useMaterial3: true,
//         ),
//       ),
//     );
//   }
// }

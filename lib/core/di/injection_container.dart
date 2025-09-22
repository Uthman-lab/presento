import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/network_info.dart';
import '../../modules/auth/domain/usecases/login.dart';
import '../../modules/auth/domain/usecases/logout.dart';
import '../../modules/auth/domain/usecases/get_current_user.dart';
import '../../modules/auth/domain/usecases/get_institutions.dart';
import '../../modules/auth/data/datasources/auth_remote_data_source.dart';
import '../../modules/auth/data/datasources/auth_local_data_source.dart';
import '../../modules/auth/data/repositories/auth_repository_impl.dart';
import '../../modules/auth/domain/repositories/auth_repository.dart';
import '../../ui/auth/bloc/auth_bloc.dart';
import '../../modules/class/domain/usecases/get_classes.dart';
import '../../modules/class/domain/usecases/create_class.dart';
import '../../modules/class/domain/usecases/update_class.dart';
import '../../modules/class/domain/usecases/delete_class.dart';
import '../../modules/class/data/datasources/class_remote_data_source.dart';
import '../../modules/class/data/repositories/class_repository_impl.dart';
import '../../modules/class/domain/repositories/class_repository.dart';
import '../../ui/class/bloc/class_management_bloc.dart';
import '../../modules/student/domain/usecases/get_students.dart';
import '../../modules/student/domain/usecases/create_student.dart';
import '../../modules/student/domain/usecases/update_student.dart';
import '../../modules/student/domain/usecases/delete_student.dart';
import '../../modules/student/data/datasources/student_remote_data_source.dart';
import '../../modules/student/data/repositories/student_repository_impl.dart';
import '../../modules/student/domain/repositories/student_repository.dart';
import '../../ui/student/bloc/student_management_bloc.dart';
import '../../modules/attendance/domain/usecases/get_attendance.dart';
import '../../modules/attendance/domain/usecases/submit_attendance.dart';
import '../../modules/attendance/domain/usecases/is_attendance_submitted.dart';
import '../../modules/attendance/data/datasources/attendance_remote_data_source.dart';
import '../../modules/attendance/data/repositories/attendance_repository_impl.dart';
import '../../modules/attendance/domain/repositories/attendance_repository.dart';
import '../../ui/attendance/bloc/attendance_bloc.dart';
import '../../ui/attendance/bloc/attendance_report_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/attendance/domain/usecases/get_attendance_by_date_range.dart';
import '../../ui/attendance/bloc/attendance_view_bloc.dart';
import '../../ui/dashboard/bloc/dashboard_bloc.dart';

// Optimized services
import '../services/smart_cache_manager.dart';
import '../routing/smart_router_service.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies for the application
Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseFunctions.instance);

  // Optimized Services for Performance & UX
  getIt.registerLazySingleton<SmartCacheManager>(
    () => SmartCacheManager(getIt()),
  );
  getIt.registerLazySingleton<SmartRouterService>(
    () => SmartRouterService(getIt()),
  );

  // Features - Auth
  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: getIt(), firestore: getIt()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => Login(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));
  getIt.registerLazySingleton(() => GetInstitutions(getIt()));

  // Bloc
  getIt.registerFactory(
    () => AuthBloc(
      login: getIt(),
      logout: getIt(),
      getCurrentUser: getIt(),
      getInstitutions: getIt(),
    ),
  );

  // Features - Class
  // Data sources
  getIt.registerLazySingleton<ClassRemoteDataSource>(
    () => ClassRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ClassRepository>(
    () => ClassRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetClasses(getIt()));
  getIt.registerLazySingleton(() => CreateClass(getIt()));
  getIt.registerLazySingleton(() => UpdateClass(getIt()));
  getIt.registerLazySingleton(() => DeleteClass(getIt()));

  // Bloc
  getIt.registerFactory(
    () => ClassManagementBloc(
      getClasses: getIt(),
      createClass: getIt(),
      updateClass: getIt(),
      deleteClass: getIt(),
    ),
  );

  // Features - Student
  // Data sources
  getIt.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<StudentRepository>(
    () =>
        StudentRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetStudents(getIt()));
  getIt.registerLazySingleton(() => CreateStudent(getIt()));
  getIt.registerLazySingleton(() => UpdateStudent(getIt()));
  getIt.registerLazySingleton(() => DeleteStudent(getIt()));

  // Bloc
  getIt.registerFactory(
    () => StudentManagementBloc(
      getStudents: getIt(),
      createStudent: getIt(),
      updateStudent: getIt(),
      deleteStudent: getIt(),
    ),
  );

  // Features - Attendance
  // Data sources
  getIt.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAttendance(getIt()));
  getIt.registerLazySingleton(() => SubmitAttendance(getIt()));
  getIt.registerLazySingleton(() => IsAttendanceSubmitted(getIt()));
  getIt.registerLazySingleton(() => GetAttendanceByDateRange(getIt()));

  // Bloc
  getIt.registerFactory(
    () => AttendanceBloc(
      getAttendance: getIt(),
      submitAttendance: getIt(),
      isAttendanceSubmitted: getIt(),
    ),
  );

  // Dashboard Bloc
  getIt.registerFactory(
    () => DashboardBloc(getAttendanceByDateRange: getIt(), functions: getIt()),
  );

  // Attendance View Bloc
  getIt.registerFactory(
    () => AttendanceViewBloc(getAttendanceByDateRange: getIt()),
  );

  // Attendance Report Bloc
  getIt.registerFactory(() => AttendanceReportBloc(getAttendance: getIt()));
}

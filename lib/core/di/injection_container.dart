import 'package:presento/imports.dart';
import 'package:presento/modules/auth/auth.dart';
import 'package:presento/modules/user/user.dart';
import 'package:presento/modules/institution/institution.dart';
import 'package:presento/modules/class/class.dart';
import 'package:presento/modules/student/student.dart';
import 'package:presento/modules/attendance/attendance.dart';
import 'package:presento/ui/user_management/user_management.ui.dart';
import 'package:presento/ui/institution_management/institution_management.ui.dart';
import 'package:presento/ui/class_management/class_management.ui.dart';
import 'package:presento/ui/student_management/student_management.ui.dart';
import 'package:presento/ui/attendance_management/attendance_management.ui.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => FirebaseFunctions.instance);

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  // Auth Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      cloudFunctions: sl(),
    ),
  );

  // Institution Data sources
  sl.registerLazySingleton<InstitutionRemoteDataSource>(
    () =>
        InstitutionRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // User Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
      cloudFunctions: sl(),
    ),
  );

  // Class Data sources
  sl.registerLazySingleton<ClassRemoteDataSource>(
    () => ClassRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // Student Data sources
  sl.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // Attendance Data sources
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<InstitutionRepository>(
    () => InstitutionRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<ClassRepository>(
    () => ClassRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Auth Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));

  // Institution Use cases
  sl.registerLazySingleton(() => GetInstitutionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllInstitutionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SelectInstitutionUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateInstitutionUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateInstitutionUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteInstitutionUseCase(repository: sl()));

  // User Use cases
  sl.registerLazySingleton(() => GetAllUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserRolesUseCase(repository: sl()));

  // Class Use cases
  sl.registerLazySingleton(() => GetClassesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetClassByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateClassUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateClassUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteClassUseCase(repository: sl()));

  // Student Use cases
  sl.registerLazySingleton(() => GetStudentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetStudentByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateStudentUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateStudentUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteStudentUseCase(repository: sl()));

  // Attendance Use cases
  sl.registerLazySingleton(() => GetAttendanceByDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAttendanceHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAttendanceRecordsUseCase(repository: sl()));
  sl.registerLazySingleton(() => MarkAttendanceUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => UpdateAttendanceRecordUseCase(repository: sl()),
  );
  sl.registerLazySingleton(() => SubmitAttendanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAttendanceUseCase(repository: sl()));

  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      resetPasswordUseCase: sl(),
      getInstitutionsUseCase: sl(),
      getAllInstitutionsUseCase: sl(),
      selectInstitutionUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => UserManagementBloc(
      getAllUsersUseCase: sl(),
      getUserByIdUseCase: sl(),
      createUserUseCase: sl(),
      updateUserUseCase: sl(),
      deleteUserUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => InstitutionManagementBloc(
      getAllInstitutionsUseCase: sl(),
      getInstitutionsUseCase: sl(),
      createInstitutionUseCase: sl(),
      updateInstitutionUseCase: sl(),
      deleteInstitutionUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ClassManagementBloc(
      getClassesUseCase: sl(),
      getClassByIdUseCase: sl(),
      createClassUseCase: sl(),
      updateClassUseCase: sl(),
      deleteClassUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => StudentManagementBloc(
      getStudentsUseCase: sl(),
      getStudentByIdUseCase: sl(),
      createStudentUseCase: sl(),
      updateStudentUseCase: sl(),
      deleteStudentUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => AttendanceManagementBloc(
      getAttendanceByDateUseCase: sl(),
      getAttendanceHistoryUseCase: sl(),
      getAttendanceRecordsUseCase: sl(),
      markAttendanceUseCase: sl(),
      updateAttendanceRecordUseCase: sl(),
      submitAttendanceUseCase: sl(),
      deleteAttendanceUseCase: sl(),
      getStudentsUseCase: sl(),
    ),
  );
}

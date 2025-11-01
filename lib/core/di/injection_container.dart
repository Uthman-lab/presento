import 'package:presento/imports.dart';
import 'package:presento/core/core.dart';
import 'package:presento/modules/auth/auth.dart';
import 'package:presento/ui/user_management/user_management.ui.dart';

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

  // Data sources
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

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetInstitutionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllInstitutionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SelectInstitutionUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserRolesUseCase(repository: sl()));

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
}

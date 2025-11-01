part of '../data.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<void> resetPassword({required String email});
}

class AuthRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseFunctions cloudFunctions;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.cloudFunctions,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    return executeFirebaseOperation(() async {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'Login failed');
      }

      // Fetch user document from Firestore
      final userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(credential.user!.email!)
          .get();

      if (!userDoc.exists) {
        throw const AuthException(message: 'User profile not found');
      }

      final userData = userDoc.data()!;
      userData['uid'] = credential.user!.uid;

      return UserModel.fromJson(userData);
    });
  }

  @override
  Future<void> logout() async {
    return executeFirebaseOperation(() async {
      await firebaseAuth.signOut();
    });
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    return executeFirebaseOperation(() async {
      // Fetch user document from Firestore
      final userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(firebaseUser.email!)
          .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      userData['uid'] = firebaseUser.uid;

      return UserModel.fromJson(userData);
    });
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return executeFirebaseOperation(() async {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    });
  }
}

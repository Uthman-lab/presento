part of '../data.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<void> resetPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  const AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
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
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      // Fetch user document from Firestore
      final userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      userData['uid'] = firebaseUser.uid;

      return UserModel.fromJson(userData);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  AuthException _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthException(message: 'No user found with this email');
      case 'wrong-password':
        return const AuthException(message: 'Incorrect password');
      case 'invalid-email':
        return const AuthException(message: 'Invalid email address');
      case 'user-disabled':
        return const AuthException(message: 'This account has been disabled');
      case 'too-many-requests':
        return const AuthException(
          message: 'Too many failed attempts. Please try again later',
        );
      case 'network-request-failed':
        return const AuthException(
          message: 'Network error. Please check your connection',
        );
      default:
        return AuthException(message: 'Authentication failed: ${e.message}');
    }
  }
}

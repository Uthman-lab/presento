import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

/// Abstract interface for remote authentication data source
abstract class AuthRemoteDataSource {
  /// Login with email, password, and institution
  Future<UserModel> login(String email, String password);

  /// Logout the current user
  Future<void> logout();

  /// Get the currently authenticated user
  Future<UserModel> getCurrentUser();

  /// Get list of available institutions
  Future<List<InstitutionModel>> getInstitutions();

  /// Register a new user
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String institutionId,
    String role,
  );
}

/// Implementation of AuthRemoteDataSource using Firebase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl({
    required firebase.FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User not found');
      }

      // Fetch profile from top-level 'users' collection by email
      final snap = await _firestore
          .collection('users')
          .where('email', isEqualTo: email.trim())
          .limit(1)
          .get();

      if (snap.docs.isEmpty) {
        throw Exception('User profile not found');
      }
      return UserModel.fromJson(snap.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }
    // This is a simplification. In a real app, you'd get the institutionId from the user's claims or another source.
    final querySnapshot = await _firestore
        .collectionGroup('users')
        .where('id', isEqualTo: user.uid)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception('User data not found');
    }
    return UserModel.fromJson(querySnapshot.docs.first.data());
  }

  @override
  Future<List<InstitutionModel>> getInstitutions() async {
    final snapshot = await _firestore.collection('institutions').get();
    return snapshot.docs
        .map((doc) => InstitutionModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String institutionId,
    String role,
  ) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) {
      throw Exception('Failed to create user');
    }

    final userModel = UserModel(
      id: user.uid,
      email: email,
      name: name,
      role: role,
      institutionId: institutionId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('users')
        .doc(user.uid)
        .set(userModel.toJson());

    return userModel;
  }
}

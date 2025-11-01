part of '../data.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<void> resetPassword({required String email});

  Future<List<InstitutionModel>> getInstitutions(List<String> institutionIds);

  Future<List<InstitutionModel>> getAllInstitutions();

  Future<void> selectInstitution(String userEmail, String? institutionId);

  // User Management Methods
  Future<List<UserModel>> getAllUsers({String? institutionId});

  Future<UserModel> getUserById(String userId);

  Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    bool isSuperAdmin = false,
    Map<String, InstitutionRole> roles = const {},
  });

  Future<UserModel> updateUser({
    required String userId,
    String? name,
    String? email,
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  });

  Future<void> deleteUser(String userId);
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
          .doc(firebaseUser.email!)
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

  @override
  Future<List<InstitutionModel>> getInstitutions(
    List<String> institutionIds,
  ) async {
    try {
      final institutions = <InstitutionModel>[];

      for (final institutionId in institutionIds) {
        final institutionDoc = await firestore
            .collection(AppConstants.institutionsCollection)
            .doc(institutionId)
            .get();

        if (institutionDoc.exists) {
          final institutionData = institutionDoc.data()!;
          institutionData['id'] = institutionId;
          institutions.add(InstitutionModel.fromJson(institutionData));
        }
      }

      return institutions;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<List<InstitutionModel>> getAllInstitutions() async {
    try {
      final querySnapshot = await firestore
          .collection(AppConstants.institutionsCollection)
          .get();

      final institutions = <InstitutionModel>[];

      for (final doc in querySnapshot.docs) {
        final institutionData = doc.data();
        institutionData['id'] = doc.id;
        institutions.add(InstitutionModel.fromJson(institutionData));
      }

      return institutions;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<void> selectInstitution(
    String userEmail,
    String? institutionId,
  ) async {
    try {
      final updateData = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Handle clearing: if null or empty, set to null in Firestore
      if (institutionId == null || institutionId.isEmpty) {
        updateData['currentInstitutionId'] = null;
      } else {
        updateData['currentInstitutionId'] = institutionId;
      }

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(userEmail)
          .update(updateData);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers({String? institutionId}) async {
    try {
      QuerySnapshot querySnapshot;

      if (institutionId != null && institutionId.isNotEmpty) {
        // Filter users by institution - users who have a role in this institution
        // Note: Firestore doesn't support querying map keys directly, so we need to fetch all and filter
        querySnapshot = await firestore
            .collection(AppConstants.usersCollection)
            .get();
      } else {
        // Get all users (super admin)
        querySnapshot = await firestore
            .collection(AppConstants.usersCollection)
            .get();
      }

      final users = <UserModel>[];

      for (final doc in querySnapshot.docs) {
        final userData = doc.data() as Map<String, dynamic>;

        // If filtering by institution, check if user has role in that institution
        if (institutionId != null && institutionId.isNotEmpty) {
          final roles = userData['roles'] as Map<String, dynamic>? ?? {};
          if (!roles.containsKey(institutionId)) {
            continue; // Skip users without role in this institution
          }
        }

        userData['uid'] =
            userData['uid'] ?? doc.id; // Fallback to email if uid missing
        final userModel = UserModel.fromJson(userData);
        users.add(userModel);
      }

      return users;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      // Try to get by email first (document ID is email)
      DocumentSnapshot userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      // If not found by email, try searching by UID
      if (!userDoc.exists) {
        final querySnapshot = await firestore
            .collection(AppConstants.usersCollection)
            .where('uid', isEqualTo: userId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isEmpty) {
          throw const AuthException(message: 'User not found');
        }

        userDoc = querySnapshot.docs.first;
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      userData['uid'] = userData['uid'] ?? userDoc.id;

      return UserModel.fromJson(userData);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Error fetching user: $e');
    }
  }

  @override
  Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    bool isSuperAdmin = false,
    Map<String, InstitutionRole> roles = const {},
  }) async {
    try {
      // Create Firebase Auth user
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'Failed to create user');
      }

      final uid = credential.user!.uid;

      // Convert roles to JSON
      final rolesJson = <String, dynamic>{};
      for (final entry in roles.entries) {
        rolesJson[entry.key] = InstitutionRoleModel.fromEntity(
          entry.value,
        ).toJson();
      }

      // Create Firestore user document (using email as document ID)
      final now = DateTime.now();
      final userData = {
        'uid': uid,
        'email': email,
        'name': name,
        'isSuperAdmin': isSuperAdmin,
        'roles': rolesJson,
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(email)
          .set(userData);

      // Send password reset email so user can set their own password
      await firebaseAuth.sendPasswordResetEmail(email: email);

      // Return created user
      userData['uid'] = uid;
      return UserModel.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    }
  }

  @override
  Future<UserModel> updateUser({
    required String userId,
    String? name,
    String? email,
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  }) async {
    try {
      // Get current user document
      final currentUser = await getUserById(userId);
      final emailKey = currentUser.email; // Document ID is email

      // Build update data
      final updateData = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (name != null) {
        updateData['name'] = name;
      }

      if (isSuperAdmin != null) {
        updateData['isSuperAdmin'] = isSuperAdmin;
      }

      if (roles != null) {
        final rolesJson = <String, dynamic>{};
        for (final entry in roles.entries) {
          rolesJson[entry.key] = InstitutionRoleModel.fromEntity(
            entry.value,
          ).toJson();
        }
        updateData['roles'] = rolesJson;
      }

      // If email changed, create new document and delete old one
      if (email != null && email != currentUser.email) {
        // For email updates, we need to create a new document with the new email
        // and delete the old one, since email is the document ID
        final newUserData = {
          'uid': currentUser.uid,
          'email': email,
          'name': name ?? currentUser.name,
          'isSuperAdmin': isSuperAdmin ?? currentUser.isSuperAdmin,
          'roles': updateData['roles'] ?? _rolesToJson(currentUser.roles),
          'currentInstitutionId': currentUser.currentInstitutionId,
          'createdAt': currentUser.createdAt.toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        };

        // Create new document with new email
        await firestore
            .collection(AppConstants.usersCollection)
            .doc(email)
            .set(newUserData);

        // Delete old document
        await firestore
            .collection(AppConstants.usersCollection)
            .doc(emailKey)
            .delete();
      } else {
        // Update Firestore document if email hasn't changed
        await firestore
            .collection(AppConstants.usersCollection)
            .doc(emailKey)
            .update(updateData);
      }

      // Fetch and return updated user
      final updatedEmail = email ?? emailKey;
      return await getUserById(updatedEmail);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    } on AuthException {
      rethrow;
    }
  }

  Map<String, dynamic> _rolesToJson(Map<String, InstitutionRole> roles) {
    final rolesJson = <String, dynamic>{};
    for (final entry in roles.entries) {
      rolesJson[entry.key] = InstitutionRoleModel.fromEntity(
        entry.value,
      ).toJson();
    }
    return rolesJson;
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      // Get user to find email (document ID)
      final user = await getUserById(userId);
      final email = user.email;

      // Get Firebase Auth user by UID
      final firebaseUser = await firebaseAuth.currentUser;

      // Delete Firebase Auth account
      // Note: In production, you'd want to use Admin SDK to delete any user
      // For now, this only works if the current user is deleting themselves
      // For admin deleting other users, you'd need Cloud Functions
      if (firebaseUser?.uid == user.uid) {
        await firebaseUser!.delete();
      } else {
        // If not current user, we can't delete via client SDK
        // This should be handled via Cloud Function with Admin SDK
        // For now, we'll throw an error
        throw const AuthException(
          message:
              'Cannot delete other users via client SDK. Use Cloud Function.',
        );
      }

      // Delete Firestore document
      await firestore
          .collection(AppConstants.usersCollection)
          .doc(email)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firebase error: ${e.message}');
    } on AuthException {
      rethrow;
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

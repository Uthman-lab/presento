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
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  });

  Future<void> deleteUser(String userId);
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

  @override
  Future<List<InstitutionModel>> getInstitutions(
    List<String> institutionIds,
  ) async {
    return executeFirebaseOperation(() async {
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
    });
  }

  @override
  Future<List<InstitutionModel>> getAllInstitutions() async {
    return executeFirebaseOperation(() async {
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
    });
  }

  @override
  Future<void> selectInstitution(
    String userEmail,
    String? institutionId,
  ) async {
    return executeFirebaseOperation(() async {
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
    });
  }

  @override
  Future<List<UserModel>> getAllUsers({String? institutionId}) async {
    return executeFirebaseOperation(() async {
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

        // Use email as uid for listing (uid not stored in Firestore)
        userData['uid'] = doc.id; // doc.id is the email
        final userModel = UserModel.fromJson(userData);
        users.add(userModel);
      }

      return users;
    });
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    return executeFirebaseOperation(() async {
      // Get by email (document ID is email)
      final userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        throw const AuthException(message: 'User not found');
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      // Use email as uid (uid not stored in Firestore)
      userData['uid'] = userDoc.id;

      return UserModel.fromJson(userData);
    });
  }

  @override
  Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    bool isSuperAdmin = false,
    Map<String, InstitutionRole> roles = const {},
  }) async {
    return executeFirebaseOperation(() async {
      // Convert roles to JSON format for Cloud Function
      final rolesJson = <String, dynamic>{};
      for (final entry in roles.entries) {
        rolesJson[entry.key] = InstitutionRoleModel.fromEntity(
          entry.value,
        ).toJson();
      }

      // Call Cloud Function to create user using Admin SDK
      // This preserves the admin's session (doesn't sign in the new user)
      final callable = cloudFunctions.httpsCallable('createUser');
      final result = await callable.call({
        'email': email,
        'password': password,
        'name': name,
        'isSuperAdmin': isSuperAdmin,
        'roles': rolesJson,
      });

      // Check if the cloud function returned an error
      // Convert from Map<Object?, Object?> to Map<String, dynamic> recursively
      if (result.data == null) {
        throw const AuthException(
          message: 'Failed to create user: No response from server',
        );
      }

      // Recursively convert the response data to handle nested maps
      final responseData =
          convertMapRecursively(result.data) as Map<String, dynamic>;

      if (responseData['success'] == false || responseData['success'] == null) {
        final errorMessage =
            responseData['error'] as String? ?? 'Failed to create user';
        throw AuthException(message: errorMessage);
      }

      // Extract user data from response (already converted recursively)
      final userData = responseData['user'] as Map<String, dynamic>?;
      if (userData == null) {
        throw const AuthException(
          message: 'Failed to create user: No user data returned',
        );
      }

      // Return created user as UserModel
      return UserModel.fromJson(userData);
    });
  }

  @override
  Future<UserModel> updateUser({
    required String userId,
    String? name,
    bool? isSuperAdmin,
    Map<String, InstitutionRole>? roles,
  }) async {
    return executeFirebaseOperation(() async {
      // Convert roles to JSON format for Cloud Function
      Map<String, dynamic>? rolesJson;
      if (roles != null) {
        rolesJson = <String, dynamic>{};
        for (final entry in roles.entries) {
          rolesJson[entry.key] = InstitutionRoleModel.fromEntity(
            entry.value,
          ).toJson();
        }
      }

      // Call Cloud Function to update user using Admin SDK
      final callable = cloudFunctions.httpsCallable('updateUser');
      final result = await callable.call({
        'userId': userId,
        if (name != null) 'name': name,
        if (isSuperAdmin != null) 'isSuperAdmin': isSuperAdmin,
        if (rolesJson != null) 'roles': rolesJson,
      });

      // Check if the cloud function returned an error
      // Convert from Map<Object?, Object?> to Map<String, dynamic> recursively
      if (result.data == null) {
        throw const AuthException(
          message: 'Failed to update user: No response from server',
        );
      }

      // Recursively convert the response data to handle nested maps
      final responseData =
          convertMapRecursively(result.data) as Map<String, dynamic>;

      if (responseData['success'] == false || responseData['success'] == null) {
        final errorMessage =
            responseData['error'] as String? ?? 'Failed to update user';
        throw AuthException(message: errorMessage);
      }

      // Extract user data from response (already converted recursively)
      final userData = responseData['user'] as Map<String, dynamic>?;
      if (userData == null) {
        throw const AuthException(
          message: 'Failed to update user: No user data returned',
        );
      }

      // Return updated user as UserModel
      return UserModel.fromJson(userData);
    });
  }

  @override
  Future<void> deleteUser(String userId) async {
    return executeFirebaseOperation(() async {
      // Call cloud function to delete user using Admin SDK
      final callable = cloudFunctions.httpsCallable('deleteUser');
      final result = await callable.call({'userId': userId});

      // Check if the cloud function returned an error
      final responseData = result.data as Map<String, dynamic>?;
      if (responseData != null && responseData['success'] == false) {
        final errorMessage =
            responseData['error'] as String? ?? 'Failed to delete user';
        throw AuthException(message: errorMessage);
      }
    });
  }
}

part of '../data.dart';

abstract class InstitutionRemoteDataSource {
  Future<List<InstitutionModel>> getInstitutions(List<String> institutionIds);

  Future<List<InstitutionModel>> getAllInstitutions();

  Future<void> selectInstitution(String userEmail, String? institutionId);

  Future<InstitutionModel> createInstitution(String name);

  Future<InstitutionModel> updateInstitution(String institutionId, String name);

  Future<void> deleteInstitution(String institutionId);
}

class InstitutionRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements InstitutionRemoteDataSource {
  final FirebaseFirestore firestore;

  InstitutionRemoteDataSourceImpl({required this.firestore});

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

  /// Sanitizes an institution name to be used as a Firestore document ID.
  ///
  /// Rules:
  /// - Replaces forward slashes with underscores
  /// - Trims whitespace
  /// - Validates length (max 1,500 bytes)
  /// - Ensures not empty
  String _sanitizeInstitutionName(String name) {
    // Replace forward slashes with underscores (not allowed in Firestore doc IDs)
    var sanitized = name.replaceAll('/', '_');

    // Trim whitespace
    sanitized = sanitized.trim();

    // Validate not empty
    if (sanitized.isEmpty) {
      throw const ServerException(
        message: 'Institution name cannot be empty after sanitization',
      );
    }

    // Validate length (1,500 bytes max, but we'll check UTF-8 byte length)
    final bytes = utf8.encode(sanitized);
    if (bytes.length > 1500) {
      throw const ServerException(
        message: 'Institution name is too long (max 1,500 bytes)',
      );
    }

    return sanitized;
  }

  @override
  Future<InstitutionModel> createInstitution(String name) async {
    return executeFirebaseOperation(() async {
      // Sanitize the name to use as document ID
      final sanitizedName = _sanitizeInstitutionName(name);

      // Check if institution with this name already exists
      final existingDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(sanitizedName)
          .get();

      if (existingDoc.exists) {
        throw const ServerException(
          message: 'An institution with this name already exists',
        );
      }

      final now = DateTime.now();
      final institutionData = <String, dynamic>{
        'name': name, // Store original name in the document
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      // Use sanitized name as document ID
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(sanitizedName)
          .set(institutionData);

      // Retrieve the created document to return with ID
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(sanitizedName)
          .get();

      final data = doc.data()!;
      data['id'] = doc.id; // This will be the sanitized name

      return InstitutionModel.fromJson(data);
    });
  }

  @override
  Future<InstitutionModel> updateInstitution(
    String institutionId,
    String name,
  ) async {
    return executeFirebaseOperation(() async {
      final updateData = <String, dynamic>{
        'name': name,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .update(updateData);

      // Retrieve the updated document
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .get();

      if (!doc.exists) {
        throw const ServerException(message: 'Institution not found');
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return InstitutionModel.fromJson(data);
    });
  }

  @override
  Future<void> deleteInstitution(String institutionId) async {
    return executeFirebaseOperation(() async {
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .delete();
    });
  }
}

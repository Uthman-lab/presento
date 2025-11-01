part of '../data.dart';

abstract class InstitutionRemoteDataSource {
  Future<List<InstitutionModel>> getInstitutions(List<String> institutionIds);

  Future<List<InstitutionModel>> getAllInstitutions();

  Future<void> selectInstitution(String userEmail, String? institutionId);
}

class InstitutionRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements InstitutionRemoteDataSource {
  final FirebaseFirestore firestore;

  InstitutionRemoteDataSourceImpl({
    required this.firestore,
  });

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
}


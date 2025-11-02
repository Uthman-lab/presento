part of '../data.dart';

abstract class ClassRemoteDataSource {
  Future<List<ClassModel>> getClasses(String institutionId);

  Future<ClassModel> getClassById(String institutionId, String classId);

  Future<ClassModel> createClass(String institutionId, ClassEntity classEntity);

  Future<ClassModel> updateClass(
    String institutionId,
    String classId,
    ClassEntity classEntity,
  );

  Future<void> deleteClass(String institutionId, String classId);
}

class ClassRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements ClassRemoteDataSource {
  final FirebaseFirestore firestore;

  ClassRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<List<ClassModel>> getClasses(String institutionId) async {
    return executeFirebaseOperation(() async {
      final querySnapshot = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .get();

      final classes = <ClassModel>[];

      for (final doc in querySnapshot.docs) {
        final classData = doc.data();
        classData['id'] = doc.id;
        classes.add(ClassModel.fromJson(classData));
      }

      return classes;
    });
  }

  @override
  Future<ClassModel> getClassById(String institutionId, String classId) async {
    return executeFirebaseOperation(() async {
      final classDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(classId)
          .get();

      if (!classDoc.exists) {
        throw const ServerException(message: 'Class not found');
      }

      final classData = classDoc.data()!;
      classData['id'] = classDoc.id;

      return ClassModel.fromJson(classData);
    });
  }

  /// Sanitizes a class name to be used as a Firestore document ID.
  ///
  /// Rules:
  /// - Replaces forward slashes with underscores
  /// - Replaces spaces with underscores
  /// - Converts to lowercase
  /// - Trims whitespace
  /// - Validates length (max 1,500 bytes)
  /// - Ensures not empty
  String _sanitizeClassName(String name) {
    // Replace forward slashes and spaces with underscores
    var sanitized = name.replaceAll('/', '_').replaceAll(' ', '_');

    // Convert to lowercase for consistency
    sanitized = sanitized.toLowerCase();

    // Trim whitespace
    sanitized = sanitized.trim();

    // Validate not empty
    if (sanitized.isEmpty) {
      throw const ServerException(
        message: 'Class name cannot be empty after sanitization',
      );
    }

    // Validate length (1,500 bytes max)
    final bytes = utf8.encode(sanitized);
    if (bytes.length > 1500) {
      throw const ServerException(
        message: 'Class name is too long (max 1,500 bytes)',
      );
    }

    return sanitized;
  }

  @override
  Future<ClassModel> createClass(
    String institutionId,
    ClassEntity classEntity,
  ) async {
    return executeFirebaseOperation(() async {
      // Sanitize the name to use as document ID
      final sanitizedClassId = _sanitizeClassName(classEntity.name);

      // Check if class with this name already exists in this institution
      final existingDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(sanitizedClassId)
          .get();

      if (existingDoc.exists) {
        throw const ServerException(
          message: 'A class with this name already exists',
        );
      }

      final now = DateTime.now();
      final classData = <String, dynamic>{
        'name': classEntity.name, // Store original name in the document
        if (classEntity.description != null)
          'description': classEntity.description,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      // Use sanitized name as document ID
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(sanitizedClassId)
          .set(classData);

      // Retrieve the created document to return with ID
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(sanitizedClassId)
          .get();

      final data = doc.data()!;
      data['id'] = doc.id; // This will be the sanitized name

      return ClassModel.fromJson(data);
    });
  }

  @override
  Future<ClassModel> updateClass(
    String institutionId,
    String classId,
    ClassEntity classEntity,
  ) async {
    return executeFirebaseOperation(() async {
      final updateData = <String, dynamic>{
        'name': classEntity.name,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (classEntity.description != null) {
        updateData['description'] = classEntity.description;
      } else {
        // If description is explicitly set to null, remove it
        updateData['description'] = FieldValue.delete();
      }

      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(classId)
          .update(updateData);

      // Retrieve the updated document
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(classId)
          .get();

      if (!doc.exists) {
        throw const ServerException(message: 'Class not found');
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return ClassModel.fromJson(data);
    });
  }

  @override
  Future<void> deleteClass(String institutionId, String classId) async {
    return executeFirebaseOperation(() async {
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.classesCollection)
          .doc(classId)
          .delete();
    });
  }
}


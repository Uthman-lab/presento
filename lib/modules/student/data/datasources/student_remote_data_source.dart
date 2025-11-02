part of '../data.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents(
    String institutionId, {
    String? classId,
  });

  Future<StudentModel> getStudentById(String institutionId, String studentId);

  Future<StudentModel> createStudent(
    String institutionId,
    StudentEntity studentEntity,
  );

  Future<StudentModel> updateStudent(
    String institutionId,
    String studentId,
    StudentEntity studentEntity,
  );

  Future<void> deleteStudent(String institutionId, String studentId);
}

class StudentRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements StudentRemoteDataSource {
  final FirebaseFirestore firestore;

  StudentRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<List<StudentModel>> getStudents(
    String institutionId, {
    String? classId,
  }) async {
    return executeFirebaseOperation(() async {
      Query query = firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection);

      // Apply classId filter if provided
      if (classId != null) {
        query = query.where('classId', isEqualTo: classId);
      }

      final querySnapshot = await query.get();

      final students = <StudentModel>[];

      for (final doc in querySnapshot.docs) {
        final studentData = doc.data() as Map<String, dynamic>;
        studentData['id'] = doc.id; // Document ID is the studentId
        students.add(StudentModel.fromJson(studentData));
      }

      return students;
    });
  }

  @override
  Future<StudentModel> getStudentById(
    String institutionId,
    String studentId,
  ) async {
    return executeFirebaseOperation(() async {
      final studentDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(studentId)
          .get();

      if (!studentDoc.exists) {
        throw const ServerException(message: 'Student not found');
      }

      final studentData = studentDoc.data()!;
      studentData['id'] = studentDoc.id; // Document ID is the studentId

      return StudentModel.fromJson(studentData);
    });
  }

  @override
  Future<StudentModel> createStudent(
    String institutionId,
    StudentEntity studentEntity,
  ) async {
    return executeFirebaseOperation(() async {
      final now = DateTime.now();
      
      // Auto-generate student ID if not provided or empty
      String documentId = studentEntity.studentId;
      if (documentId.isEmpty) {
        documentId = _generateStudentId(now);
      }

      // Check if student with this ID already exists
      var existingDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(documentId)
          .get();

      // If ID exists, regenerate until we find a unique one
      while (existingDoc.exists) {
        documentId = _generateStudentId(now);
        existingDoc = await firestore
            .collection(AppConstants.institutionsCollection)
            .doc(institutionId)
            .collection(AppConstants.studentsCollection)
            .doc(documentId)
            .get();
      }

      final studentData = <String, dynamic>{
        'studentId': documentId,
        'name': studentEntity.name,
        'classId': studentEntity.classId,
        if (studentEntity.email != null) 'email': studentEntity.email,
        if (studentEntity.phone != null) 'phone': studentEntity.phone,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      // Use studentId as document ID
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(documentId)
          .set(studentData);

      // Retrieve the created document to return
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(documentId)
          .get();

      final data = doc.data()!;
      data['id'] = doc.id; // Document ID is the studentId

      return StudentModel.fromJson(data);
    });
  }

  /// Generates a formatted student ID with pattern: STU-{YYYYMMDD}-{HHMMSS}-{random}
  /// Example: STU-20241215-143025-A7B2
  String _generateStudentId(DateTime dateTime) {
    // Format date as YYYYMMDD
    final dateStr = _formatDate(dateTime);
    
    // Format time as HHMMSS
    final timeStr = _formatTime(dateTime);
    
    // Generate random 4-character alphanumeric suffix
    final randomSuffix = _generateRandomSuffix();
    
    return 'STU-$dateStr-$timeStr-$randomSuffix';
  }

  String _formatDate(DateTime dateTime) {
    final year = dateTime.year.toString();
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    return '$hour$minute$second';
  }

  String _generateRandomSuffix() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch % 1000000;
    final randomValue = List.generate(4, (index) {
      final charIndex = (random + index * 256) % chars.length;
      return chars[charIndex];
    });
    return randomValue.join();
  }

  @override
  Future<StudentModel> updateStudent(
    String institutionId,
    String studentId,
    StudentEntity studentEntity,
  ) async {
    return executeFirebaseOperation(() async {
      final updateData = <String, dynamic>{
        'name': studentEntity.name,
        'classId': studentEntity.classId,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (studentEntity.email != null) {
        updateData['email'] = studentEntity.email;
      } else {
        updateData['email'] = FieldValue.delete();
      }

      if (studentEntity.phone != null) {
        updateData['phone'] = studentEntity.phone;
      } else {
        updateData['phone'] = FieldValue.delete();
      }

      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(studentId)
          .update(updateData);

      // Retrieve the updated document
      final doc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(studentId)
          .get();

      if (!doc.exists) {
        throw const ServerException(message: 'Student not found');
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return StudentModel.fromJson(data);
    });
  }

  @override
  Future<void> deleteStudent(String institutionId, String studentId) async {
    return executeFirebaseOperation(() async {
      await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.studentsCollection)
          .doc(studentId)
          .delete();
    });
  }
}


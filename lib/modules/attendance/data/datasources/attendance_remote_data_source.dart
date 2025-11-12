part of '../data.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceModel?> getAttendanceByDate(
    String institutionId,
    String classId,
    DateTime date,
  );

  Future<List<AttendanceRecordModel>> getAttendanceRecords(
    String institutionId,
    String attendanceId,
  );

  Future<List<AttendanceModel>> getAttendanceHistory(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<AttendanceModel> markAttendance(
    String institutionId,
    AttendanceEntity attendance,
    List<AttendanceRecordEntity> records,
  );

  Future<AttendanceRecordModel> updateAttendanceRecord(
    String institutionId,
    String attendanceId,
    AttendanceRecordEntity record,
  );

  Future<void> submitAttendance(
    String institutionId,
    String attendanceId,
  );

  Future<void> deleteAttendance(
    String institutionId,
    String attendanceId,
  );
}

class AttendanceRemoteDataSourceImpl extends FirebaseBaseDataSource
    implements AttendanceRemoteDataSource {
  final FirebaseFirestore firestore;

  AttendanceRemoteDataSourceImpl({
    required this.firestore,
  });

  /// Generates a composite attendance ID: {classId}_{YYYY-MM-DD}
  String _generateAttendanceId(String classId, DateTime date) {
    final sanitizedClassId = _sanitizeClassId(classId);
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return '${sanitizedClassId}_$dateStr';
  }

  /// Sanitizes a class ID to be used in composite attendance ID.
  String _sanitizeClassId(String classId) {
    // Replace forward slashes and spaces with underscores
    var sanitized = classId.replaceAll('/', '_').replaceAll(' ', '_');
    // Convert to lowercase for consistency
    sanitized = sanitized.toLowerCase();
    // Trim whitespace
    sanitized = sanitized.trim();
    return sanitized;
  }

  /// Normalizes a DateTime to start of day (00:00:00) for consistent queries
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Future<AttendanceModel?> getAttendanceByDate(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    return executeFirebaseOperation(() async {
      final normalizedDate = _normalizeDate(date);
      final attendanceId = _generateAttendanceId(classId, normalizedDate);

      final attendanceDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId)
          .get();

      if (!attendanceDoc.exists) {
        return null;
      }

      final attendanceData = attendanceDoc.data()!;
      attendanceData['id'] = attendanceDoc.id;

      return AttendanceModel.fromJson(attendanceData);
    });
  }

  @override
  Future<List<AttendanceRecordModel>> getAttendanceRecords(
    String institutionId,
    String attendanceId,
  ) async {
    return executeFirebaseOperation(() async {
      final recordsSnapshot = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId)
          .collection(AppConstants.attendanceRecordsCollection)
          .get();

      final records = <AttendanceRecordModel>[];

      for (final doc in recordsSnapshot.docs) {
        final recordData = doc.data();
        recordData['studentId'] = doc.id;
        records.add(AttendanceRecordModel.fromJson(recordData));
      }

      return records;
    });
  }

  @override
  Future<List<AttendanceModel>> getAttendanceHistory(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return executeFirebaseOperation(() async {
      final normalizedStartDate = _normalizeDate(startDate);
      final normalizedEndDate = _normalizeDate(endDate);

      final querySnapshot = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .where('classId', isEqualTo: classId)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(normalizedStartDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(normalizedEndDate))
          .orderBy('date', descending: true)
          .get();

      final attendanceList = <AttendanceModel>[];

      for (final doc in querySnapshot.docs) {
        final attendanceData = doc.data();
        attendanceData['id'] = doc.id;
        attendanceList.add(AttendanceModel.fromJson(attendanceData));
      }

      return attendanceList;
    });
  }

  @override
  Future<AttendanceModel> markAttendance(
    String institutionId,
    AttendanceEntity attendance,
    List<AttendanceRecordEntity> records,
  ) async {
    return executeFirebaseOperation(() async {
      final batch = firestore.batch();

      // Normalize date for consistency
      final normalizedDate = _normalizeDate(attendance.date);
      final attendanceModel = AttendanceModel.fromEntity(attendance);

      // Create or update attendance parent document
      final attendanceRef = firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendance.id);

      final attendanceData = attendanceModel.toJson();
      attendanceData.remove('id'); // Remove id from data, it's the document ID
      attendanceData['date'] = Timestamp.fromDate(normalizedDate);

      batch.set(attendanceRef, attendanceData, SetOptions(merge: true));

      // Write all records in batch
      for (final record in records) {
        final recordModel = AttendanceRecordModel.fromEntity(record);
        final recordRef = attendanceRef
            .collection(AppConstants.attendanceRecordsCollection)
            .doc(record.studentId);

        final recordData = recordModel.toJson();
        batch.set(recordRef, recordData);
      }

      // Commit batch write
      await batch.commit();

      // Retrieve and return the created/updated attendance
      final doc = await attendanceRef.get();
      final data = doc.data()!;
      data['id'] = doc.id;
      return AttendanceModel.fromJson(data);
    });
  }

  @override
  Future<AttendanceRecordModel> updateAttendanceRecord(
    String institutionId,
    String attendanceId,
    AttendanceRecordEntity record,
  ) async {
    return executeFirebaseOperation(() async {
      final recordModel = AttendanceRecordModel.fromEntity(record);
      final recordRef = firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId)
          .collection(AppConstants.attendanceRecordsCollection)
          .doc(record.studentId);

      await recordRef.set(recordModel.toJson());

      // Return the updated record
      final doc = await recordRef.get();
      final data = doc.data()!;
      data['studentId'] = doc.id;
      return AttendanceRecordModel.fromJson(data);
    });
  }

  @override
  Future<void> submitAttendance(
    String institutionId,
    String attendanceId,
  ) async {
    return executeFirebaseOperation(() async {
      final attendanceRef = firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId);

      await attendanceRef.update({
        'isSubmitted': true,
        'updatedAt': Timestamp.now(),
      });
    });
  }

  @override
  Future<void> deleteAttendance(
    String institutionId,
    String attendanceId,
  ) async {
    return executeFirebaseOperation(() async {
      // First, delete all records in the subcollection
      final recordsSnapshot = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId)
          .collection(AppConstants.attendanceRecordsCollection)
          .get();

      final batch = firestore.batch();
      for (final doc in recordsSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Delete the parent attendance document
      final attendanceRef = firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institutionId)
          .collection(AppConstants.attendanceCollection)
          .doc(attendanceId);
      batch.delete(attendanceRef);

      await batch.commit();
    });
  }
}



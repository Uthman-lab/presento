import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../models/attendance_model.dart';
import '../../domain/entities/attendance.dart';

/// Abstract interface for remote attendance data source
abstract class AttendanceRemoteDataSource {
  /// Get attendance records for a class on a specific date
  Future<List<AttendanceModel>> getAttendance(
    String institutionId,
    String classId,
    DateTime date,
  );

  /// Submit attendance records for a class
  Future<Unit> submitAttendance(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  );

  /// Check if attendance has been submitted for a class on a date
  Future<bool> isAttendanceSubmitted(
    String institutionId,
    String classId,
    DateTime date,
  );

  /// Get attendance records for a student
  Future<List<AttendanceModel>> getStudentAttendance(
    String institutionId,
    String studentId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get attendance statistics for a class
  Future<Map<String, dynamic>> getAttendanceStats(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get attendance records for a class within a date range
  Future<List<AttendanceModel>> getAttendanceByDateRange(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  );
}

/// Implementation of AttendanceRemoteDataSource using Firebase Firestore
class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final FirebaseFirestore _firestore;

  AttendanceRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<List<AttendanceModel>> getAttendance(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    final dateString = _formatDate(date);
    final snapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .doc(dateString)
        .get();

    if (!snapshot.exists) {
      return [];
    }

    final data = snapshot.data()!;
    final List<AttendanceModel> attendanceRecords = [];

    // Parse the attendance data structure
    // Expected format: { studentId: { status, notes, markedBy, timestamp } }
    data.forEach((studentId, attendanceData) {
      if (attendanceData is Map<String, dynamic>) {
        attendanceRecords.add(
          AttendanceModel(
            id: '${dateString}_$studentId',
            studentId: studentId,
            classId: classId,
            institutionId: institutionId,
            date: date,
            status: _parseStatus(attendanceData['status'] as String),
            notes: attendanceData['notes'] as String?,
            markedBy: attendanceData['markedBy'] as String,
            createdAt: DateTime.parse(attendanceData['timestamp'] as String),
            updatedAt: DateTime.parse(attendanceData['timestamp'] as String),
          ),
        );
      }
    });

    return attendanceRecords;
  }

  @override
  Future<Unit> submitAttendance(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  ) async {
    final dateString = _formatDate(date);
    final Map<String, dynamic> attendanceData = {};

    for (final record in attendanceRecords) {
      attendanceData[record.studentId] = {
        'status': record.status.toString().split('.').last,
        'notes': record.notes,
        'markedBy': record.markedBy,
        'timestamp': DateTime.now().toIso8601String(),
      };
    }

    await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .doc(dateString)
        .set(attendanceData);

    return unit;
  }

  @override
  Future<bool> isAttendanceSubmitted(
    String institutionId,
    String classId,
    DateTime date,
  ) async {
    final dateString = _formatDate(date);
    final doc = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .doc(dateString)
        .get();

    return doc.exists;
  }

  @override
  Future<List<AttendanceModel>> getStudentAttendance(
    String institutionId,
    String studentId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final List<AttendanceModel> attendanceRecords = [];

    // Query attendance records for the student across all classes
    final querySnapshot = await _firestore
        .collectionGroup('attendance')
        .where('studentId', isEqualTo: studentId)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      attendanceRecords.add(AttendanceModel.fromJson(data));
    }

    return attendanceRecords;
  }

  @override
  Future<Map<String, dynamic>> getAttendanceStats(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final List<AttendanceModel> allAttendance = [];

    // Get all attendance records for the class in the date range
    final querySnapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .get();

    for (final doc in querySnapshot.docs) {
      final date = DateTime.parse(doc.id);
      if (date.isAfter(startDate.subtract(const Duration(days: 1))) &&
          date.isBefore(endDate.add(const Duration(days: 1)))) {
        final attendanceRecords = await getAttendance(
          institutionId,
          classId,
          date,
        );
        allAttendance.addAll(attendanceRecords);
      }
    }

    // Calculate statistics
    final totalRecords = allAttendance.length;
    final presentCount = allAttendance.where((a) => a.isPresent).length;
    final absentCount = allAttendance.where((a) => a.isAbsent).length;
    final lateCount = allAttendance.where((a) => a.isLate).length;
    final excusedCount = allAttendance.where((a) => a.isExcused).length;

    return {
      'totalRecords': totalRecords,
      'presentCount': presentCount,
      'absentCount': absentCount,
      'lateCount': lateCount,
      'excusedCount': excusedCount,
      'presentPercentage': totalRecords > 0
          ? (presentCount / totalRecords) * 100
          : 0,
      'absentPercentage': totalRecords > 0
          ? (absentCount / totalRecords) * 100
          : 0,
      'latePercentage': totalRecords > 0 ? (lateCount / totalRecords) * 100 : 0,
      'excusedPercentage': totalRecords > 0
          ? (excusedCount / totalRecords) * 100
          : 0,
    };
  }

  @override
  Future<List<AttendanceModel>> getAttendanceByDateRange(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final List<AttendanceModel> attendanceRecords = [];

    // Query attendance records for the class within the date range
    final querySnapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      attendanceRecords.add(AttendanceModel.fromJson(data));
    }

    return attendanceRecords;
  }

  /// Format date to string for Firestore document ID
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Parse attendance status from string
  AttendanceStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return AttendanceStatus.present;
      case 'absent':
        return AttendanceStatus.absent;
      case 'late':
        return AttendanceStatus.late;
      case 'excused':
        return AttendanceStatus.excused;
      default:
        return AttendanceStatus.absent;
    }
  }
}

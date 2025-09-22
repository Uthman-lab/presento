import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import '../../domain/entities/attendance.dart';

/// Attendance data model for JSON serialization
class AttendanceModel extends Attendance {
  const AttendanceModel({
    required super.id,
    required super.studentId,
    required super.classId,
    required super.institutionId,
    required super.date,
    required super.status,
    super.notes,
    required super.markedBy,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create AttendanceModel from JSON
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    final dateVal = json['date'];
    final created = json['createdAt'];
    final updated = json['updatedAt'];
    return AttendanceModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      classId: json['classId'] as String,
      institutionId: json['institutionId'] as String,
      date: dateVal is String
          ? DateTime.parse(dateVal)
          : (dateVal as Timestamp).toDate(),
      status: AttendanceStatus.values.firstWhere(
        (e) => e.toString() == 'AttendanceStatus.${json['status']}',
      ),
      notes: json['notes'] as String?,
      markedBy: json['markedBy'] as String,
      createdAt: created is String
          ? DateTime.parse(created)
          : (created as Timestamp).toDate(),
      updatedAt: updated is String
          ? DateTime.parse(updated)
          : (updated as Timestamp).toDate(),
    );
  }

  /// Convert AttendanceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'classId': classId,
      'institutionId': institutionId,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'notes': notes,
      'markedBy': markedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert to domain entity
  Attendance toDomain() {
    return Attendance(
      id: id,
      studentId: studentId,
      classId: classId,
      institutionId: institutionId,
      date: date,
      status: status,
      notes: notes,
      markedBy: markedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory AttendanceModel.fromDomain(Attendance attendance) {
    return AttendanceModel(
      id: attendance.id,
      studentId: attendance.studentId,
      classId: attendance.classId,
      institutionId: attendance.institutionId,
      date: attendance.date,
      status: attendance.status,
      notes: attendance.notes,
      markedBy: attendance.markedBy,
      createdAt: attendance.createdAt,
      updatedAt: attendance.updatedAt,
    );
  }
}

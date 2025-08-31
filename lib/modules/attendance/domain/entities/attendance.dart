import 'package:equatable/equatable.dart';

/// Attendance status enum
enum AttendanceStatus { present, absent, late, excused }

/// Attendance entity representing a student's attendance record
class Attendance extends Equatable {
  final String id;
  final String studentId;
  final String classId;
  final String institutionId;
  final DateTime date;
  final AttendanceStatus status;
  final String? notes;
  final String markedBy; // User ID who marked the attendance
  final DateTime createdAt;
  final DateTime updatedAt;

  const Attendance({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.institutionId,
    required this.date,
    required this.status,
    this.notes,
    required this.markedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    studentId,
    classId,
    institutionId,
    date,
    status,
    notes,
    markedBy,
    createdAt,
    updatedAt,
  ];

  /// Create a copy of the attendance with updated fields
  Attendance copyWith({
    String? id,
    String? studentId,
    String? classId,
    String? institutionId,
    DateTime? date,
    AttendanceStatus? status,
    String? notes,
    String? markedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attendance(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      institutionId: institutionId ?? this.institutionId,
      date: date ?? this.date,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      markedBy: markedBy ?? this.markedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if attendance is present
  bool get isPresent => status == AttendanceStatus.present;

  /// Check if attendance is absent
  bool get isAbsent => status == AttendanceStatus.absent;

  /// Check if attendance is late
  bool get isLate => status == AttendanceStatus.late;

  /// Check if attendance is excused
  bool get isExcused => status == AttendanceStatus.excused;

  /// Get status as string
  String get statusString {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.excused:
        return 'Excused';
    }
  }
}

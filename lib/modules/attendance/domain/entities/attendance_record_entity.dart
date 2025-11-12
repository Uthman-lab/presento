part of '../domain.dart';

enum AttendanceStatus {
  present,
  absent,
  late,
  excused;

  String get value {
    switch (this) {
      case AttendanceStatus.present:
        return 'present';
      case AttendanceStatus.absent:
        return 'absent';
      case AttendanceStatus.late:
        return 'late';
      case AttendanceStatus.excused:
        return 'excused';
    }
  }

  static AttendanceStatus fromString(String value) {
    switch (value.toLowerCase()) {
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

class AttendanceRecordEntity extends Equatable {
  final String studentId;
  final AttendanceStatus status;
  final DateTime timestamp;
  final String? notes;
  final String markedBy;
  final DateTime markedAt;

  const AttendanceRecordEntity({
    required this.studentId,
    required this.status,
    required this.timestamp,
    this.notes,
    required this.markedBy,
    required this.markedAt,
  });

  @override
  List<Object?> get props => [
        studentId,
        status,
        timestamp,
        notes,
        markedBy,
        markedAt,
      ];
}



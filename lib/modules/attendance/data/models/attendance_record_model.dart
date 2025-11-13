part of '../data.dart';

class AttendanceRecordModel extends AttendanceRecordEntity {
  const AttendanceRecordModel({
    required super.studentId,
    required super.status,
    required super.timestamp,
    super.notes,
    required super.markedBy,
    required super.markedAt,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      studentId: json['studentId'] as String? ?? '',
      status: AttendanceStatus.fromString(json['status'] as String),
      timestamp: parseDateTime(json['timestamp']),
      notes: json['notes'] as String?,
      markedBy: json['markedBy'] as String,
      markedAt: parseDateTime(json['markedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.value,
      'timestamp': Timestamp.fromDate(timestamp),
      if (notes != null) 'notes': notes,
      'markedBy': markedBy,
      'markedAt': Timestamp.fromDate(markedAt),
    };
  }

  factory AttendanceRecordModel.fromEntity(AttendanceRecordEntity entity) {
    return AttendanceRecordModel(
      studentId: entity.studentId,
      status: entity.status,
      timestamp: entity.timestamp,
      notes: entity.notes,
      markedBy: entity.markedBy,
      markedAt: entity.markedAt,
    );
  }
}




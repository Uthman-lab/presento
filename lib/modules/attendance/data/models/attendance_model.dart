part of '../data.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.id,
    required super.classId,
    required super.date,
    required super.markedBy,
    required super.isSubmitted,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String,
      classId: json['classId'] as String,
      date: parseDateTime(json['date']),
      markedBy: json['markedBy'] as String,
      isSubmitted: json['isSubmitted'] as bool? ?? false,
      createdAt: parseDateTime(json['createdAt']),
      updatedAt: parseDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'date': Timestamp.fromDate(date),
      'markedBy': markedBy,
      'isSubmitted': isSubmitted,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      classId: entity.classId,
      date: entity.date,
      markedBy: entity.markedBy,
      isSubmitted: entity.isSubmitted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}




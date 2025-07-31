import '../../domain/entities/class.dart';

/// Class data model for JSON serialization
class ClassModel extends Class {
  const ClassModel({
    required super.id,
    required super.name,
    required super.institutionId,
    super.description,
    super.roomNumber,
    super.schedule,
    super.teacherName,
    required super.maxStudents,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create ClassModel from JSON
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      name: json['name'] as String,
      institutionId: json['institutionId'] as String,
      description: json['description'] as String?,
      roomNumber: json['roomNumber'] as String?,
      schedule: json['schedule'] as String?,
      teacherName: json['teacherName'] as String?,
      maxStudents: json['maxStudents'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Convert ClassModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'institutionId': institutionId,
      'description': description,
      'roomNumber': roomNumber,
      'schedule': schedule,
      'teacherName': teacherName,
      'maxStudents': maxStudents,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert to domain entity
  Class toDomain() {
    return Class(
      id: id,
      name: name,
      institutionId: institutionId,
      description: description,
      roomNumber: roomNumber,
      schedule: schedule,
      teacherName: teacherName,
      maxStudents: maxStudents,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory ClassModel.fromDomain(Class classEntity) {
    return ClassModel(
      id: classEntity.id,
      name: classEntity.name,
      institutionId: classEntity.institutionId,
      description: classEntity.description,
      roomNumber: classEntity.roomNumber,
      schedule: classEntity.schedule,
      teacherName: classEntity.teacherName,
      maxStudents: classEntity.maxStudents,
      createdAt: classEntity.createdAt,
      updatedAt: classEntity.updatedAt,
    );
  }
}

part of '../data.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required super.id,
    required super.studentId,
    required super.name,
    required super.classId,
    super.email,
    super.phone,
    required super.createdAt,
    required super.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      name: json['name'] as String,
      classId: json['classId'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      createdAt: parseDateTime(json['createdAt']),
      updatedAt: parseDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'name': name,
      'classId': classId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      studentId: entity.studentId,
      name: entity.name,
      classId: entity.classId,
      email: entity.email,
      phone: entity.phone,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}


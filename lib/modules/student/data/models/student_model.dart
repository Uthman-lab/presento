import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import '../../domain/entities/student.dart';

/// Student data model for JSON serialization
class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.studentId,
    required super.name,
    required super.institutionId,
    required super.classId,
    super.email,
    super.phone,
    super.address,
    super.profilePictureUrl,
    super.dateOfBirth,
    super.emergencyContact,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create StudentModel from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final dob = json['dateOfBirth'];
    final created = json['createdAt'];
    final updated = json['updatedAt'];
    return StudentModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      name: json['name'] as String,
      institutionId: json['institutionId'] as String,
      classId: json['classId'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      dateOfBirth: dob == null
          ? null
          : (dob is String ? DateTime.parse(dob) : (dob as Timestamp).toDate()),
      emergencyContact: json['emergencyContact'] as String?,
      createdAt: created is String
          ? DateTime.parse(created)
          : (created as Timestamp).toDate(),
      updatedAt: updated is String
          ? DateTime.parse(updated)
          : (updated as Timestamp).toDate(),
    );
  }

  /// Convert StudentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'name': name,
      'institutionId': institutionId,
      'classId': classId,
      'email': email,
      'phone': phone,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'emergencyContact': emergencyContact,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert to domain entity
  Student toDomain() {
    return Student(
      id: id,
      studentId: studentId,
      name: name,
      institutionId: institutionId,
      classId: classId,
      email: email,
      phone: phone,
      address: address,
      profilePictureUrl: profilePictureUrl,
      dateOfBirth: dateOfBirth,
      emergencyContact: emergencyContact,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory StudentModel.fromDomain(Student student) {
    return StudentModel(
      id: student.id,
      studentId: student.studentId,
      name: student.name,
      institutionId: student.institutionId,
      classId: student.classId,
      email: student.email,
      phone: student.phone,
      address: student.address,
      profilePictureUrl: student.profilePictureUrl,
      dateOfBirth: student.dateOfBirth,
      emergencyContact: student.emergencyContact,
      createdAt: student.createdAt,
      updatedAt: student.updatedAt,
    );
  }
}

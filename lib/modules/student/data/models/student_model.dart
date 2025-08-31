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
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      emergencyContact: json['emergencyContact'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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

import 'package:equatable/equatable.dart';

/// Student entity representing a student in an institution
class Student extends Equatable {
  final String id;
  final String studentId; // Student ID number
  final String name;
  final String institutionId;
  final String classId;
  final String? email;
  final String? phone;
  final String? address;
  final String? profilePictureUrl;
  final DateTime? dateOfBirth;
  final String? emergencyContact;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Student({
    required this.id,
    required this.studentId,
    required this.name,
    required this.institutionId,
    required this.classId,
    this.email,
    this.phone,
    this.address,
    this.profilePictureUrl,
    this.dateOfBirth,
    this.emergencyContact,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    studentId,
    name,
    institutionId,
    classId,
    email,
    phone,
    address,
    profilePictureUrl,
    dateOfBirth,
    emergencyContact,
    createdAt,
    updatedAt,
  ];

  /// Create a copy of the student with updated fields
  Student copyWith({
    String? id,
    String? studentId,
    String? name,
    String? institutionId,
    String? classId,
    String? email,
    String? phone,
    String? address,
    String? profilePictureUrl,
    DateTime? dateOfBirth,
    String? emergencyContact,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      institutionId: institutionId ?? this.institutionId,
      classId: classId ?? this.classId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get student's age
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
}

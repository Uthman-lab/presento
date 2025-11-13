part of '../domain.dart';

class StudentEntity extends Equatable {
  final String id;
  final String studentId;
  final String name;
  final String classId;
  final String? email;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudentEntity({
    required this.id,
    required this.studentId,
    required this.name,
    required this.classId,
    this.email,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        studentId,
        name,
        classId,
        email,
        phone,
        createdAt,
        updatedAt,
      ];
}




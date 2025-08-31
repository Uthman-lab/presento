import 'package:equatable/equatable.dart';

/// Class entity representing a class in an institution
class Class extends Equatable {
  final String id;
  final String name;
  final String institutionId;
  final String? description;
  final String? roomNumber;
  final String? schedule; // e.g., "Monday, Wednesday, Friday 9:00 AM"
  final String? teacherName;
  final int maxStudents;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Class({
    required this.id,
    required this.name,
    required this.institutionId,
    this.description,
    this.roomNumber,
    this.schedule,
    this.teacherName,
    required this.maxStudents,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    institutionId,
    description,
    roomNumber,
    schedule,
    teacherName,
    maxStudents,
    createdAt,
    updatedAt,
  ];

  /// Create a copy of the class with updated fields
  Class copyWith({
    String? id,
    String? name,
    String? institutionId,
    String? description,
    String? roomNumber,
    String? schedule,
    String? teacherName,
    int? maxStudents,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Class(
      id: id ?? this.id,
      name: name ?? this.name,
      institutionId: institutionId ?? this.institutionId,
      description: description ?? this.description,
      roomNumber: roomNumber ?? this.roomNumber,
      schedule: schedule ?? this.schedule,
      teacherName: teacherName ?? this.teacherName,
      maxStudents: maxStudents ?? this.maxStudents,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

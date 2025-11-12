part of '../domain.dart';

class AttendanceEntity extends Equatable {
  final String id;
  final String classId;
  final DateTime date;
  final String markedBy;
  final bool isSubmitted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AttendanceEntity({
    required this.id,
    required this.classId,
    required this.date,
    required this.markedBy,
    required this.isSubmitted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        classId,
        date,
        markedBy,
        isSubmitted,
        createdAt,
        updatedAt,
      ];
}



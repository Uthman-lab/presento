part of '../student_management.ui.dart';

abstract class StudentManagementEvent extends Equatable {
  const StudentManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudents extends StudentManagementEvent {
  final String institutionId;
  final String? classId;
  final String? searchQuery;
  final StudentSortOption? sortOption;

  const LoadStudents({
    required this.institutionId,
    this.classId,
    this.searchQuery,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, classId, searchQuery, sortOption];
}

class LoadStudent extends StudentManagementEvent {
  final String institutionId;
  final String studentId;

  const LoadStudent({
    required this.institutionId,
    required this.studentId,
  });

  @override
  List<Object> get props => [institutionId, studentId];
}

class CreateStudent extends StudentManagementEvent {
  final String institutionId;
  final String? studentId;
  final String name;
  final String classId;
  final String? email;
  final String? phone;

  const CreateStudent({
    required this.institutionId,
    this.studentId,
    required this.name,
    required this.classId,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [
        institutionId,
        studentId,
        name,
        classId,
        email,
        phone,
      ];
}

class UpdateStudent extends StudentManagementEvent {
  final String institutionId;
  final String studentId;
  final String name;
  final String classId;
  final String? email;
  final String? phone;

  const UpdateStudent({
    required this.institutionId,
    required this.studentId,
    required this.name,
    required this.classId,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [
        institutionId,
        studentId,
        name,
        classId,
        email,
        phone,
      ];
}

class DeleteStudent extends StudentManagementEvent {
  final String institutionId;
  final String studentId;

  const DeleteStudent({
    required this.institutionId,
    required this.studentId,
  });

  @override
  List<Object> get props => [institutionId, studentId];
}

class SearchStudents extends StudentManagementEvent {
  final String institutionId;
  final String? classId;
  final String query;
  final StudentSortOption? sortOption;

  const SearchStudents({
    required this.institutionId,
    this.classId,
    required this.query,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, classId, query, sortOption];
}

class RefreshStudents extends StudentManagementEvent {
  final String institutionId;
  final String? classId;
  final StudentSortOption? sortOption;

  const RefreshStudents({
    required this.institutionId,
    this.classId,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, classId, sortOption];
}

class SortStudents extends StudentManagementEvent {
  final String institutionId;
  final String? classId;
  final StudentSortOption sortOption;
  final String? searchQuery;

  const SortStudents({
    required this.institutionId,
    this.classId,
    required this.sortOption,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [institutionId, classId, sortOption, searchQuery];
}

class FilterStudentsByClass extends StudentManagementEvent {
  final String institutionId;
  final String? classId;
  final String? searchQuery;
  final StudentSortOption? sortOption;

  const FilterStudentsByClass({
    required this.institutionId,
    this.classId,
    this.searchQuery,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, classId, searchQuery, sortOption];
}


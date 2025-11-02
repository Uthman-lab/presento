part of '../student_management.ui.dart';

abstract class StudentManagementState extends Equatable {
  const StudentManagementState();

  @override
  List<Object?> get props => [];
}

class StudentManagementInitial extends StudentManagementState {
  const StudentManagementInitial();
}

class StudentManagementLoading extends StudentManagementState {
  const StudentManagementLoading();
}

enum StudentSortOption {
  none,
  nameAsc,
  nameDesc,
  studentIdAsc,
  studentIdDesc,
  classIdAsc,
  classIdDesc,
  createdAtAsc,
  createdAtDesc,
  updatedAtAsc,
  updatedAtDesc;

  String get displayName {
    switch (this) {
      case StudentSortOption.none:
        return 'No Sorting';
      case StudentSortOption.nameAsc:
        return 'Name (A-Z)';
      case StudentSortOption.nameDesc:
        return 'Name (Z-A)';
      case StudentSortOption.studentIdAsc:
        return 'Student ID (A-Z)';
      case StudentSortOption.studentIdDesc:
        return 'Student ID (Z-A)';
      case StudentSortOption.classIdAsc:
        return 'Class (A-Z)';
      case StudentSortOption.classIdDesc:
        return 'Class (Z-A)';
      case StudentSortOption.createdAtAsc:
        return 'Created Date (Oldest)';
      case StudentSortOption.createdAtDesc:
        return 'Created Date (Newest)';
      case StudentSortOption.updatedAtAsc:
        return 'Updated Date (Oldest)';
      case StudentSortOption.updatedAtDesc:
        return 'Updated Date (Newest)';
    }
  }
}

class StudentsLoaded extends StudentManagementState {
  final List<StudentEntity> students;
  final String? classId;
  final String? searchQuery;
  final StudentSortOption sortOption;

  const StudentsLoaded({
    required this.students,
    this.classId,
    this.searchQuery,
    this.sortOption = StudentSortOption.createdAtDesc,
  });

  @override
  List<Object?> get props => [students, classId, searchQuery, sortOption];
}

class StudentLoaded extends StudentManagementState {
  final StudentEntity studentEntity;

  const StudentLoaded({required this.studentEntity});

  @override
  List<Object> get props => [studentEntity];
}

class StudentOperationSuccess extends StudentManagementState {
  final String message;
  final StudentEntity? studentEntity;

  const StudentOperationSuccess({
    required this.message,
    this.studentEntity,
  });

  @override
  List<Object?> get props => [message, studentEntity];
}

class StudentManagementError extends StudentManagementState {
  final String message;

  const StudentManagementError({required this.message});

  @override
  List<Object> get props => [message];
}


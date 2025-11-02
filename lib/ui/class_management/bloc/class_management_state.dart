part of '../class_management.ui.dart';

abstract class ClassManagementState extends Equatable {
  const ClassManagementState();

  @override
  List<Object?> get props => [];
}

class ClassManagementInitial extends ClassManagementState {
  const ClassManagementInitial();
}

class ClassManagementLoading extends ClassManagementState {
  const ClassManagementLoading();
}

enum ClassSortOption {
  none,
  nameAsc,
  nameDesc,
  createdAtAsc,
  createdAtDesc,
  updatedAtAsc,
  updatedAtDesc;

  String get displayName {
    switch (this) {
      case ClassSortOption.none:
        return 'No Sorting';
      case ClassSortOption.nameAsc:
        return 'Name (A-Z)';
      case ClassSortOption.nameDesc:
        return 'Name (Z-A)';
      case ClassSortOption.createdAtAsc:
        return 'Created Date (Oldest)';
      case ClassSortOption.createdAtDesc:
        return 'Created Date (Newest)';
      case ClassSortOption.updatedAtAsc:
        return 'Updated Date (Oldest)';
      case ClassSortOption.updatedAtDesc:
        return 'Updated Date (Newest)';
    }
  }
}

class ClassesLoaded extends ClassManagementState {
  final List<ClassEntity> classes;
  final String? searchQuery;
  final ClassSortOption sortOption;

  const ClassesLoaded({
    required this.classes,
    this.searchQuery,
    this.sortOption = ClassSortOption.none,
  });

  @override
  List<Object?> get props => [classes, searchQuery, sortOption];
}

class ClassLoaded extends ClassManagementState {
  final ClassEntity classEntity;

  const ClassLoaded({required this.classEntity});

  @override
  List<Object> get props => [classEntity];
}

class ClassOperationSuccess extends ClassManagementState {
  final String message;
  final ClassEntity? classEntity;

  const ClassOperationSuccess({
    required this.message,
    this.classEntity,
  });

  @override
  List<Object?> get props => [message, classEntity];
}

class ClassManagementError extends ClassManagementState {
  final String message;

  const ClassManagementError({required this.message});

  @override
  List<Object> get props => [message];
}


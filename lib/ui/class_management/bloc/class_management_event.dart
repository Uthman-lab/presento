part of '../class_management.ui.dart';

abstract class ClassManagementEvent extends Equatable {
  const ClassManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadClasses extends ClassManagementEvent {
  final String institutionId;
  final String? searchQuery;
  final ClassSortOption? sortOption;

  const LoadClasses({
    required this.institutionId,
    this.searchQuery,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, searchQuery, sortOption];
}

class LoadClass extends ClassManagementEvent {
  final String institutionId;
  final String classId;

  const LoadClass({
    required this.institutionId,
    required this.classId,
  });

  @override
  List<Object> get props => [institutionId, classId];
}

class CreateClass extends ClassManagementEvent {
  final String institutionId;
  final String name;
  final String? description;

  const CreateClass({
    required this.institutionId,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [institutionId, name, description];
}

class UpdateClass extends ClassManagementEvent {
  final String institutionId;
  final String classId;
  final String name;
  final String? description;

  const UpdateClass({
    required this.institutionId,
    required this.classId,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [institutionId, classId, name, description];
}

class DeleteClass extends ClassManagementEvent {
  final String institutionId;
  final String classId;

  const DeleteClass({
    required this.institutionId,
    required this.classId,
  });

  @override
  List<Object> get props => [institutionId, classId];
}

class SearchClasses extends ClassManagementEvent {
  final String institutionId;
  final String query;
  final ClassSortOption? sortOption;

  const SearchClasses({
    required this.institutionId,
    required this.query,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, query, sortOption];
}

class RefreshClasses extends ClassManagementEvent {
  final String institutionId;
  final ClassSortOption? sortOption;

  const RefreshClasses({
    required this.institutionId,
    this.sortOption,
  });

  @override
  List<Object?> get props => [institutionId, sortOption];
}

class SortClasses extends ClassManagementEvent {
  final String institutionId;
  final ClassSortOption sortOption;
  final String? searchQuery;

  const SortClasses({
    required this.institutionId,
    required this.sortOption,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [institutionId, sortOption, searchQuery];
}


part of '../institution_management.ui.dart';

abstract class InstitutionManagementEvent extends Equatable {
  const InstitutionManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadInstitutions extends InstitutionManagementEvent {
  final String? searchQuery;
  final InstitutionSortOption? sortOption;

  const LoadInstitutions({
    this.searchQuery,
    this.sortOption,
  });

  @override
  List<Object?> get props => [searchQuery, sortOption];
}

class LoadInstitution extends InstitutionManagementEvent {
  final String institutionId;

  const LoadInstitution({required this.institutionId});

  @override
  List<Object> get props => [institutionId];
}

class CreateInstitution extends InstitutionManagementEvent {
  final String name;

  const CreateInstitution({required this.name});

  @override
  List<Object> get props => [name];
}

class UpdateInstitution extends InstitutionManagementEvent {
  final String institutionId;
  final String name;

  const UpdateInstitution({
    required this.institutionId,
    required this.name,
  });

  @override
  List<Object> get props => [institutionId, name];
}

class DeleteInstitution extends InstitutionManagementEvent {
  final String institutionId;

  const DeleteInstitution({required this.institutionId});

  @override
  List<Object> get props => [institutionId];
}

class SearchInstitutions extends InstitutionManagementEvent {
  final String query;
  final InstitutionSortOption? sortOption;

  const SearchInstitutions({
    required this.query,
    this.sortOption,
  });

  @override
  List<Object?> get props => [query, sortOption];
}

class RefreshInstitutions extends InstitutionManagementEvent {
  final InstitutionSortOption? sortOption;

  const RefreshInstitutions({this.sortOption});

  @override
  List<Object?> get props => [sortOption];
}

class SortInstitutions extends InstitutionManagementEvent {
  final InstitutionSortOption sortOption;
  final String? searchQuery;

  const SortInstitutions({
    required this.sortOption,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [sortOption, searchQuery];
}


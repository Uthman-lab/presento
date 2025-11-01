part of '../institution_management.ui.dart';

abstract class InstitutionManagementState extends Equatable {
  const InstitutionManagementState();

  @override
  List<Object?> get props => [];
}

class InstitutionManagementInitial extends InstitutionManagementState {
  const InstitutionManagementInitial();
}

class InstitutionManagementLoading extends InstitutionManagementState {
  const InstitutionManagementLoading();
}

enum InstitutionSortOption {
  none,
  nameAsc,
  nameDesc,
  createdAtAsc,
  createdAtDesc,
  updatedAtAsc,
  updatedAtDesc;

  String get displayName {
    switch (this) {
      case InstitutionSortOption.none:
        return 'No Sorting';
      case InstitutionSortOption.nameAsc:
        return 'Name (A-Z)';
      case InstitutionSortOption.nameDesc:
        return 'Name (Z-A)';
      case InstitutionSortOption.createdAtAsc:
        return 'Created Date (Oldest)';
      case InstitutionSortOption.createdAtDesc:
        return 'Created Date (Newest)';
      case InstitutionSortOption.updatedAtAsc:
        return 'Updated Date (Oldest)';
      case InstitutionSortOption.updatedAtDesc:
        return 'Updated Date (Newest)';
    }
  }
}

class InstitutionsLoaded extends InstitutionManagementState {
  final List<Institution> institutions;
  final String? searchQuery;
  final InstitutionSortOption sortOption;

  const InstitutionsLoaded({
    required this.institutions,
    this.searchQuery,
    this.sortOption = InstitutionSortOption.none,
  });

  @override
  List<Object?> get props => [institutions, searchQuery, sortOption];
}

class InstitutionLoaded extends InstitutionManagementState {
  final Institution institution;

  const InstitutionLoaded({required this.institution});

  @override
  List<Object> get props => [institution];
}

class InstitutionOperationSuccess extends InstitutionManagementState {
  final String message;
  final Institution? institution;

  const InstitutionOperationSuccess({
    required this.message,
    this.institution,
  });

  @override
  List<Object?> get props => [message, institution];
}

class InstitutionManagementError extends InstitutionManagementState {
  final String message;

  const InstitutionManagementError({required this.message});

  @override
  List<Object> get props => [message];
}


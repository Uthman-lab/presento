part of '../institution_management.ui.dart';

class InstitutionManagementBloc
    extends Bloc<InstitutionManagementEvent, InstitutionManagementState> {
  final GetAllInstitutionsUseCase getAllInstitutionsUseCase;
  final GetInstitutionsUseCase getInstitutionsUseCase;
  final CreateInstitutionUseCase createInstitutionUseCase;
  final UpdateInstitutionUseCase updateInstitutionUseCase;
  final DeleteInstitutionUseCase deleteInstitutionUseCase;

  InstitutionManagementBloc({
    required this.getAllInstitutionsUseCase,
    required this.getInstitutionsUseCase,
    required this.createInstitutionUseCase,
    required this.updateInstitutionUseCase,
    required this.deleteInstitutionUseCase,
  }) : super(const InstitutionManagementInitial()) {
    on<LoadInstitutions>(_onLoadInstitutions);
    on<LoadInstitution>(_onLoadInstitution);
    on<CreateInstitution>(_onCreateInstitution);
    on<UpdateInstitution>(_onUpdateInstitution);
    on<DeleteInstitution>(_onDeleteInstitution);
    on<SearchInstitutions>(_onSearchInstitutions);
    on<RefreshInstitutions>(_onRefreshInstitutions);
    on<SortInstitutions>(_onSortInstitutions);
  }

  Future<void> _onLoadInstitution(
    LoadInstitution event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    emit(const InstitutionManagementLoading());

    final result = await getInstitutionsUseCase(
      institutionIds: [event.institutionId],
    );

    result.fold(
      (failure) => emit(InstitutionManagementError(message: failure.message)),
      (institutions) {
        if (institutions.isEmpty) {
          emit(const InstitutionManagementError(
            message: 'Institution not found',
          ));
        } else {
          emit(InstitutionLoaded(institution: institutions.first));
        }
      },
    );
  }

  Future<void> _onLoadInstitutions(
    LoadInstitutions event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    emit(const InstitutionManagementLoading());

    final result = await getAllInstitutionsUseCase();

    result.fold(
      (failure) => emit(InstitutionManagementError(message: failure.message)),
      (institutions) {
        // Apply search filter if provided
        List<Institution> processedInstitutions = institutions;
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          final query = event.searchQuery!.toLowerCase();
          processedInstitutions = institutions.where((institution) {
            return institution.name.toLowerCase().contains(query);
          }).toList();
        }

        // Apply sorting if provided
        final sortOption = event.sortOption ?? InstitutionSortOption.none;
        processedInstitutions =
            _applySorting(processedInstitutions, sortOption);

        emit(
          InstitutionsLoaded(
            institutions: processedInstitutions,
            searchQuery: event.searchQuery,
            sortOption: sortOption,
          ),
        );
      },
    );
  }

  Future<void> _onCreateInstitution(
    CreateInstitution event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    emit(const InstitutionManagementLoading());

    final result = await createInstitutionUseCase(event.name);

    result.fold(
      (failure) => emit(InstitutionManagementError(message: failure.message)),
      (institution) => emit(
        InstitutionOperationSuccess(
          message: 'Institution created successfully',
          institution: institution,
        ),
      ),
    );
  }

  Future<void> _onUpdateInstitution(
    UpdateInstitution event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    emit(const InstitutionManagementLoading());

    final result =
        await updateInstitutionUseCase(event.institutionId, event.name);

    result.fold(
      (failure) => emit(InstitutionManagementError(message: failure.message)),
      (institution) => emit(
        InstitutionOperationSuccess(
          message: 'Institution updated successfully',
          institution: institution,
        ),
      ),
    );
  }

  Future<void> _onDeleteInstitution(
    DeleteInstitution event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    emit(const InstitutionManagementLoading());

    final result = await deleteInstitutionUseCase(event.institutionId);

    result.fold(
      (failure) => emit(InstitutionManagementError(message: failure.message)),
      (_) => emit(
        const InstitutionOperationSuccess(
          message: 'Institution deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSearchInstitutions(
    SearchInstitutions event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    // Reload institutions with search query, preserving sorting
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is InstitutionsLoaded
            ? currentState.sortOption
            : InstitutionSortOption.none);

    add(
      LoadInstitutions(
        searchQuery: event.query.isEmpty ? null : event.query,
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onRefreshInstitutions(
    RefreshInstitutions event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    // Preserve sorting when refreshing
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is InstitutionsLoaded
            ? currentState.sortOption
            : InstitutionSortOption.none);

    add(
      LoadInstitutions(
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onSortInstitutions(
    SortInstitutions event,
    Emitter<InstitutionManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is InstitutionsLoaded) {
      // Apply sorting to current institutions
      final sortedInstitutions =
          _applySorting(currentState.institutions, event.sortOption);

      emit(
        InstitutionsLoaded(
          institutions: sortedInstitutions,
          searchQuery: event.searchQuery ?? currentState.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    } else {
      // If not loaded yet, load with sort option
      add(
        LoadInstitutions(
          searchQuery: event.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    }
  }

  List<Institution> _applySorting(
    List<Institution> institutions,
    InstitutionSortOption sortOption,
  ) {
    if (sortOption == InstitutionSortOption.none) {
      return institutions;
    }

    final sortedInstitutions = List<Institution>.from(institutions);

    switch (sortOption) {
      case InstitutionSortOption.nameAsc:
        sortedInstitutions.sort((a, b) => a.name.compareTo(b.name));
        break;
      case InstitutionSortOption.nameDesc:
        sortedInstitutions.sort((a, b) => b.name.compareTo(a.name));
        break;
      case InstitutionSortOption.createdAtAsc:
        sortedInstitutions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case InstitutionSortOption.createdAtDesc:
        sortedInstitutions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case InstitutionSortOption.updatedAtAsc:
        sortedInstitutions.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case InstitutionSortOption.updatedAtDesc:
        sortedInstitutions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case InstitutionSortOption.none:
        // Already handled above
        break;
    }

    return sortedInstitutions;
  }
}


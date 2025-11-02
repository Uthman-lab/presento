part of '../class_management.ui.dart';

class ClassManagementBloc
    extends Bloc<ClassManagementEvent, ClassManagementState> {
  final GetClassesUseCase getClassesUseCase;
  final GetClassByIdUseCase getClassByIdUseCase;
  final CreateClassUseCase createClassUseCase;
  final UpdateClassUseCase updateClassUseCase;
  final DeleteClassUseCase deleteClassUseCase;

  ClassManagementBloc({
    required this.getClassesUseCase,
    required this.getClassByIdUseCase,
    required this.createClassUseCase,
    required this.updateClassUseCase,
    required this.deleteClassUseCase,
  }) : super(const ClassManagementInitial()) {
    on<LoadClasses>(_onLoadClasses);
    on<LoadClass>(_onLoadClass);
    on<CreateClass>(_onCreateClass);
    on<UpdateClass>(_onUpdateClass);
    on<DeleteClass>(_onDeleteClass);
    on<SearchClasses>(_onSearchClasses);
    on<RefreshClasses>(_onRefreshClasses);
    on<SortClasses>(_onSortClasses);
  }

  Future<void> _onLoadClasses(
    LoadClasses event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementLoading());

    final result = await getClassesUseCase(event.institutionId);

    result.fold(
      (failure) => emit(ClassManagementError(message: failure.message)),
      (classes) {
        // Apply search filter if provided
        List<ClassEntity> processedClasses = classes;
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          final query = event.searchQuery!.toLowerCase();
          processedClasses = classes.where((classEntity) {
            return classEntity.name.toLowerCase().contains(query) ||
                (classEntity.description != null &&
                    classEntity.description!
                        .toLowerCase()
                        .contains(query));
          }).toList();
        }

        // Apply sorting if provided
        final sortOption = event.sortOption ?? ClassSortOption.none;
        processedClasses = _applySorting(processedClasses, sortOption);

        emit(
          ClassesLoaded(
            classes: processedClasses,
            searchQuery: event.searchQuery,
            sortOption: sortOption,
          ),
        );
      },
    );
  }

  Future<void> _onLoadClass(
    LoadClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementLoading());

    final result = await getClassByIdUseCase(
      event.institutionId,
      event.classId,
    );

    result.fold(
      (failure) => emit(ClassManagementError(message: failure.message)),
      (classEntity) => emit(ClassLoaded(classEntity: classEntity)),
    );
  }

  Future<void> _onCreateClass(
    CreateClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementLoading());

    final now = DateTime.now();
    final classEntity = ClassEntity(
      id: '', // Will be set by data source
      name: event.name,
      description: event.description,
      createdAt: now,
      updatedAt: now,
    );

    final result = await createClassUseCase(event.institutionId, classEntity);

    result.fold(
      (failure) => emit(ClassManagementError(message: failure.message)),
      (createdClass) => emit(
        ClassOperationSuccess(
          message: 'Class created successfully',
          classEntity: createdClass,
        ),
      ),
    );
  }

  Future<void> _onUpdateClass(
    UpdateClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementLoading());

    // Load existing class to preserve createdAt
    final loadResult = await getClassByIdUseCase(
      event.institutionId,
      event.classId,
    );

    await loadResult.fold(
      (failure) async => emit(ClassManagementError(message: failure.message)),
      (existingClass) async {
        final updatedClass = ClassEntity(
          id: existingClass.id,
          name: event.name,
          description: event.description,
          createdAt: existingClass.createdAt,
          updatedAt: DateTime.now(),
        );

        final result = await updateClassUseCase(
          event.institutionId,
          event.classId,
          updatedClass,
        );

        result.fold(
          (failure) => emit(ClassManagementError(message: failure.message)),
          (classEntity) => emit(
            ClassOperationSuccess(
              message: 'Class updated successfully',
              classEntity: classEntity,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onDeleteClass(
    DeleteClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementLoading());

    final result = await deleteClassUseCase(
      event.institutionId,
      event.classId,
    );

    result.fold(
      (failure) => emit(ClassManagementError(message: failure.message)),
      (_) => emit(
        const ClassOperationSuccess(
          message: 'Class deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSearchClasses(
    SearchClasses event,
    Emitter<ClassManagementState> emit,
  ) async {
    // Reload classes with search query, preserving sorting
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is ClassesLoaded
            ? currentState.sortOption
            : ClassSortOption.none);

    add(
      LoadClasses(
        institutionId: event.institutionId,
        searchQuery: event.query.isEmpty ? null : event.query,
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onRefreshClasses(
    RefreshClasses event,
    Emitter<ClassManagementState> emit,
  ) async {
    // Preserve sorting when refreshing
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is ClassesLoaded
            ? currentState.sortOption
            : ClassSortOption.none);

    add(
      LoadClasses(
        institutionId: event.institutionId,
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onSortClasses(
    SortClasses event,
    Emitter<ClassManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is ClassesLoaded) {
      // Apply sorting to current classes
      final sortedClasses =
          _applySorting(currentState.classes, event.sortOption);

      emit(
        ClassesLoaded(
          classes: sortedClasses,
          searchQuery: event.searchQuery ?? currentState.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    } else {
      // If not loaded yet, load with sort option
      add(
        LoadClasses(
          institutionId: event.institutionId,
          searchQuery: event.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    }
  }

  List<ClassEntity> _applySorting(
    List<ClassEntity> classes,
    ClassSortOption sortOption,
  ) {
    if (sortOption == ClassSortOption.none) {
      return classes;
    }

    final sortedClasses = List<ClassEntity>.from(classes);

    switch (sortOption) {
      case ClassSortOption.nameAsc:
        sortedClasses.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ClassSortOption.nameDesc:
        sortedClasses.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ClassSortOption.createdAtAsc:
        sortedClasses.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case ClassSortOption.createdAtDesc:
        sortedClasses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ClassSortOption.updatedAtAsc:
        sortedClasses.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case ClassSortOption.updatedAtDesc:
        sortedClasses.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case ClassSortOption.none:
        // Already handled above
        break;
    }

    return sortedClasses;
  }
}


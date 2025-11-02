part of '../student_management.ui.dart';

class StudentManagementBloc
    extends Bloc<StudentManagementEvent, StudentManagementState> {
  final GetStudentsUseCase getStudentsUseCase;
  final GetStudentByIdUseCase getStudentByIdUseCase;
  final CreateStudentUseCase createStudentUseCase;
  final UpdateStudentUseCase updateStudentUseCase;
  final DeleteStudentUseCase deleteStudentUseCase;

  StudentManagementBloc({
    required this.getStudentsUseCase,
    required this.getStudentByIdUseCase,
    required this.createStudentUseCase,
    required this.updateStudentUseCase,
    required this.deleteStudentUseCase,
  }) : super(const StudentManagementInitial()) {
    on<LoadStudents>(_onLoadStudents);
    on<LoadStudent>(_onLoadStudent);
    on<CreateStudent>(_onCreateStudent);
    on<UpdateStudent>(_onUpdateStudent);
    on<DeleteStudent>(_onDeleteStudent);
    on<SearchStudents>(_onSearchStudents);
    on<RefreshStudents>(_onRefreshStudents);
    on<SortStudents>(_onSortStudents);
    on<FilterStudentsByClass>(_onFilterStudentsByClass);
  }

  Future<void> _onLoadStudents(
    LoadStudents event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementLoading());

    final result = await getStudentsUseCase(
      event.institutionId,
      classId: event.classId,
    );

    result.fold(
      (failure) => emit(StudentManagementError(message: failure.message)),
      (students) {
        // Apply search filter if provided
        List<StudentEntity> processedStudents = students;
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          final query = event.searchQuery!.toLowerCase();
          processedStudents = students.where((student) {
            return student.name.toLowerCase().contains(query) ||
                student.studentId.toLowerCase().contains(query) ||
                (student.email != null &&
                    student.email!.toLowerCase().contains(query)) ||
                (student.phone != null &&
                    student.phone!.toLowerCase().contains(query));
          }).toList();
        }

        // Apply sorting if provided
        final sortOption = event.sortOption ?? StudentSortOption.createdAtDesc;
        processedStudents = _applySorting(processedStudents, sortOption);

        emit(
          StudentsLoaded(
            students: processedStudents,
            classId: event.classId,
            searchQuery: event.searchQuery,
            sortOption: sortOption,
          ),
        );
      },
    );
  }

  Future<void> _onLoadStudent(
    LoadStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementLoading());

    final result = await getStudentByIdUseCase(
      event.institutionId,
      event.studentId,
    );

    result.fold(
      (failure) => emit(StudentManagementError(message: failure.message)),
      (student) => emit(StudentLoaded(studentEntity: student)),
    );
  }

  Future<void> _onCreateStudent(
    CreateStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementLoading());

    final now = DateTime.now();
    final studentEntity = StudentEntity(
      id: '', // Will be set by data source
      studentId: event.studentId ?? '', // Empty string triggers auto-generation
      name: event.name,
      classId: event.classId,
      email: event.email,
      phone: event.phone,
      createdAt: now,
      updatedAt: now,
    );

    final result = await createStudentUseCase(event.institutionId, studentEntity);

    result.fold(
      (failure) => emit(StudentManagementError(message: failure.message)),
      (createdStudent) => emit(
        StudentOperationSuccess(
          message: 'Student created successfully',
          studentEntity: createdStudent,
        ),
      ),
    );
  }

  Future<void> _onUpdateStudent(
    UpdateStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementLoading());

    // Load existing student to preserve createdAt
    final loadResult = await getStudentByIdUseCase(
      event.institutionId,
      event.studentId,
    );

    await loadResult.fold(
      (failure) async => emit(StudentManagementError(message: failure.message)),
      (existingStudent) async {
        final updatedStudent = StudentEntity(
          id: existingStudent.id,
          studentId: existingStudent.studentId, // studentId cannot change
          name: event.name,
          classId: event.classId,
          email: event.email,
          phone: event.phone,
          createdAt: existingStudent.createdAt,
          updatedAt: DateTime.now(),
        );

        final result = await updateStudentUseCase(
          event.institutionId,
          event.studentId,
          updatedStudent,
        );

        result.fold(
          (failure) => emit(StudentManagementError(message: failure.message)),
          (student) => emit(
            StudentOperationSuccess(
              message: 'Student updated successfully',
              studentEntity: student,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onDeleteStudent(
    DeleteStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementLoading());

    final result = await deleteStudentUseCase(
      event.institutionId,
      event.studentId,
    );

    result.fold(
      (failure) => emit(StudentManagementError(message: failure.message)),
      (_) => emit(
        const StudentOperationSuccess(
          message: 'Student deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSearchStudents(
    SearchStudents event,
    Emitter<StudentManagementState> emit,
  ) async {
    // Reload students with search query, preserving sorting and class filter
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is StudentsLoaded
            ? currentState.sortOption
            : StudentSortOption.createdAtDesc);
    final classId = event.classId ??
        (currentState is StudentsLoaded ? currentState.classId : null);

    add(
      LoadStudents(
        institutionId: event.institutionId,
        classId: classId,
        searchQuery: event.query.isEmpty ? null : event.query,
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onRefreshStudents(
    RefreshStudents event,
    Emitter<StudentManagementState> emit,
  ) async {
    // Preserve sorting and class filter when refreshing
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is StudentsLoaded
            ? currentState.sortOption
            : StudentSortOption.createdAtDesc);
    final classId = event.classId ??
        (currentState is StudentsLoaded ? currentState.classId : null);

    add(
      LoadStudents(
        institutionId: event.institutionId,
        classId: classId,
        sortOption: sortOption,
      ),
    );
  }

  Future<void> _onSortStudents(
    SortStudents event,
    Emitter<StudentManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is StudentsLoaded) {
      // Apply sorting to current students
      final sortedStudents =
          _applySorting(currentState.students, event.sortOption);

      emit(
        StudentsLoaded(
          students: sortedStudents,
          classId: event.classId ?? currentState.classId,
          searchQuery: event.searchQuery ?? currentState.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    } else {
      // If not loaded yet, load with sort option
      add(
        LoadStudents(
          institutionId: event.institutionId,
          classId: event.classId,
          searchQuery: event.searchQuery,
          sortOption: event.sortOption,
        ),
      );
    }
  }

  Future<void> _onFilterStudentsByClass(
    FilterStudentsByClass event,
    Emitter<StudentManagementState> emit,
  ) async {
    // Reload students with class filter, preserving search and sort
    final currentState = state;
    final sortOption = event.sortOption ??
        (currentState is StudentsLoaded
            ? currentState.sortOption
            : StudentSortOption.createdAtDesc);
    final searchQuery = event.searchQuery ??
        (currentState is StudentsLoaded ? currentState.searchQuery : null);

    add(
      LoadStudents(
        institutionId: event.institutionId,
        classId: event.classId,
        searchQuery: searchQuery,
        sortOption: sortOption,
      ),
    );
  }

  List<StudentEntity> _applySorting(
    List<StudentEntity> students,
    StudentSortOption sortOption,
  ) {
    if (sortOption == StudentSortOption.none) {
      return students;
    }

    final sortedStudents = List<StudentEntity>.from(students);

    switch (sortOption) {
      case StudentSortOption.nameAsc:
        sortedStudents.sort((a, b) => a.name.compareTo(b.name));
        break;
      case StudentSortOption.nameDesc:
        sortedStudents.sort((a, b) => b.name.compareTo(a.name));
        break;
      case StudentSortOption.studentIdAsc:
        sortedStudents.sort((a, b) => a.studentId.compareTo(b.studentId));
        break;
      case StudentSortOption.studentIdDesc:
        sortedStudents.sort((a, b) => b.studentId.compareTo(a.studentId));
        break;
      case StudentSortOption.classIdAsc:
        sortedStudents.sort((a, b) => a.classId.compareTo(b.classId));
        break;
      case StudentSortOption.classIdDesc:
        sortedStudents.sort((a, b) => b.classId.compareTo(a.classId));
        break;
      case StudentSortOption.createdAtAsc:
        sortedStudents.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case StudentSortOption.createdAtDesc:
        sortedStudents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case StudentSortOption.updatedAtAsc:
        sortedStudents.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case StudentSortOption.updatedAtDesc:
        sortedStudents.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case StudentSortOption.none:
        // Already handled above
        break;
    }

    return sortedStudents;
  }
}


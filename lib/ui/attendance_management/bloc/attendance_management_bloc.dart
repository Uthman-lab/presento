part of '../attendance_management.ui.dart';

class AttendanceManagementBloc
    extends Bloc<AttendanceManagementEvent, AttendanceManagementState> {
  final GetAttendanceByDateUseCase getAttendanceByDateUseCase;
  final GetAttendanceHistoryUseCase getAttendanceHistoryUseCase;
  final GetAttendanceRecordsUseCase getAttendanceRecordsUseCase;
  final MarkAttendanceUseCase markAttendanceUseCase;
  final UpdateAttendanceRecordUseCase updateAttendanceRecordUseCase;
  final SubmitAttendanceUseCase submitAttendanceUseCase;
  final DeleteAttendanceUseCase deleteAttendanceUseCase;
  final GetStudentsUseCase getStudentsUseCase;

  AttendanceManagementBloc({
    required this.getAttendanceByDateUseCase,
    required this.getAttendanceHistoryUseCase,
    required this.getAttendanceRecordsUseCase,
    required this.markAttendanceUseCase,
    required this.updateAttendanceRecordUseCase,
    required this.submitAttendanceUseCase,
    required this.deleteAttendanceUseCase,
    required this.getStudentsUseCase,
  }) : super(const AttendanceInitial()) {
    on<LoadAttendanceForDate>(_onLoadAttendanceForDate);
    on<LoadAttendanceHistory>(_onLoadAttendanceHistory);
    on<LoadAttendanceRecords>(_onLoadAttendanceRecords);
    on<MarkStudentAttendance>(_onMarkStudentAttendance);
    on<BulkMarkAttendance>(_onBulkMarkAttendance);
    on<UpdateAttendanceRecord>(_onUpdateAttendanceRecord);
    on<SubmitAttendance>(_onSubmitAttendance);
    on<DeleteAttendance>(_onDeleteAttendance);
  }

  Future<void> _onLoadAttendanceForDate(
    LoadAttendanceForDate event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    emit(const AttendanceLoading());

    // Load attendance and students in parallel
    final attendanceResult = await getAttendanceByDateUseCase(
      event.institutionId,
      event.classId,
      event.date,
    );

    final studentsResult = await getStudentsUseCase(
      event.institutionId,
      classId: event.classId,
    );

    await attendanceResult.fold(
      (failure) async {
        emit(AttendanceManagementError(message: failure.message));
      },
      (attendance) async {
        await studentsResult.fold(
          (failure) async {
            emit(AttendanceManagementError(message: failure.message));
          },
          (students) async {
            List<AttendanceRecordEntity> records = [];
            if (attendance != null) {
              // Load existing records
              final recordsResult = await getAttendanceRecordsUseCase(
                event.institutionId,
                attendance.id,
              );

              recordsResult.fold(
                (failure) {
                  emit(AttendanceManagementError(message: failure.message));
                },
                (loadedRecords) {
                  records = loadedRecords;
                },
              );
            }

            if (attendance != null && records.isNotEmpty) {
              emit(
                AttendanceLoaded(
                  attendance: attendance,
                  records: records,
                  students: students,
                ),
              );
            } else {
              // Create new attendance if it doesn't exist
              final now = DateTime.now();
              final normalizedDate = DateTime(
                event.date.year,
                event.date.month,
                event.date.day,
              );
              final attendanceId = _generateAttendanceId(
                event.classId,
                normalizedDate,
              );

              final newAttendance = AttendanceEntity(
                id: attendanceId,
                classId: event.classId,
                date: normalizedDate,
                markedBy: '', // Will be set when marking
                isSubmitted: false,
                createdAt: now,
                updatedAt: now,
              );

              emit(
                AttendanceLoaded(
                  attendance: newAttendance,
                  records: [],
                  students: students,
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _onLoadAttendanceHistory(
    LoadAttendanceHistory event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    emit(const AttendanceLoading());

    final result = await getAttendanceHistoryUseCase(
      event.institutionId,
      event.classId,
      event.startDate,
      event.endDate,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (attendanceList) =>
          emit(AttendanceHistoryLoaded(attendanceList: attendanceList)),
    );
  }

  Future<void> _onLoadAttendanceRecords(
    LoadAttendanceRecords event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    emit(const AttendanceLoading());

    final result = await getAttendanceRecordsUseCase(
      event.institutionId,
      event.attendanceId,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (records) {
        // We need attendance and students to emit AttendanceLoaded
        // This should be called after loading attendance
        // For now, just emit error or maintain current state
        emit(AttendanceManagementError(
          message: 'Load attendance first before loading records',
        ));
      },
    );
  }

  Future<void> _onMarkStudentAttendance(
    MarkStudentAttendance event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AttendanceLoaded) {
      emit(const AttendanceManagementError(
        message: 'Please load attendance first',
      ));
      return;
    }

    // Check if already submitted
    if (currentState.attendance.isSubmitted) {
      emit(const AttendanceManagementError(
        message: 'Cannot modify submitted attendance',
      ));
      return;
    }

    final now = DateTime.now();
    final record = AttendanceRecordEntity(
      studentId: event.studentId,
      status: event.status,
      timestamp: now,
      notes: event.notes,
      markedBy: event.markedBy,
      markedAt: now,
    );

    // Update existing records list
    final updatedRecords = List<AttendanceRecordEntity>.from(
      currentState.records,
    );
    final existingIndex = updatedRecords.indexWhere(
      (r) => r.studentId == event.studentId,
    );

    if (existingIndex >= 0) {
      updatedRecords[existingIndex] = record;
    } else {
      updatedRecords.add(record);
    }

    // Update attendance entity
    final updatedAttendance = AttendanceEntity(
      id: currentState.attendance.id,
      classId: currentState.attendance.classId,
      date: currentState.attendance.date,
      markedBy: event.markedBy,
      isSubmitted: currentState.attendance.isSubmitted,
      createdAt: currentState.attendance.createdAt,
      updatedAt: now,
    );

    // Save to Firestore
    final result = await markAttendanceUseCase(
      event.institutionId,
      updatedAttendance,
      updatedRecords,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (savedAttendance) {
        emit(
          AttendanceLoaded(
            attendance: savedAttendance,
            records: updatedRecords,
            students: currentState.students,
          ),
        );
      },
    );
  }

  Future<void> _onBulkMarkAttendance(
    BulkMarkAttendance event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AttendanceLoaded) {
      emit(const AttendanceManagementError(
        message: 'Please load attendance first',
      ));
      return;
    }

    // Check if already submitted
    if (currentState.attendance.isSubmitted) {
      emit(const AttendanceManagementError(
        message: 'Cannot modify submitted attendance',
      ));
      return;
    }

    final now = DateTime.now();
    final updatedRecords = List<AttendanceRecordEntity>.from(
      currentState.records,
    );

    // Update or add records for all student IDs
    for (final studentId in event.studentIds) {
      final record = AttendanceRecordEntity(
        studentId: studentId,
        status: event.status,
        timestamp: now,
        notes: null,
        markedBy: event.markedBy,
        markedAt: now,
      );

      final existingIndex = updatedRecords.indexWhere(
        (r) => r.studentId == studentId,
      );

      if (existingIndex >= 0) {
        updatedRecords[existingIndex] = record;
      } else {
        updatedRecords.add(record);
      }
    }

    // Update attendance entity
    final updatedAttendance = AttendanceEntity(
      id: currentState.attendance.id,
      classId: currentState.attendance.classId,
      date: currentState.attendance.date,
      markedBy: event.markedBy,
      isSubmitted: currentState.attendance.isSubmitted,
      createdAt: currentState.attendance.createdAt,
      updatedAt: now,
    );

    // Save to Firestore
    final result = await markAttendanceUseCase(
      event.institutionId,
      updatedAttendance,
      updatedRecords,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (savedAttendance) {
        emit(
          AttendanceLoaded(
            attendance: savedAttendance,
            records: updatedRecords,
            students: currentState.students,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateAttendanceRecord(
    UpdateAttendanceRecord event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AttendanceLoaded) {
      emit(const AttendanceManagementError(
        message: 'Please load attendance first',
      ));
      return;
    }

    // Check if already submitted
    if (currentState.attendance.isSubmitted) {
      emit(const AttendanceManagementError(
        message: 'Cannot modify submitted attendance',
      ));
      return;
    }

    final now = DateTime.now();
    final record = AttendanceRecordEntity(
      studentId: event.studentId,
      status: event.status,
      timestamp: now,
      notes: event.notes,
      markedBy: event.markedBy,
      markedAt: now,
    );

    final result = await updateAttendanceRecordUseCase(
      event.institutionId,
      event.attendanceId,
      record,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (updatedRecord) {
        // Update local state
        final updatedRecords = List<AttendanceRecordEntity>.from(
          currentState.records,
        );
        final existingIndex = updatedRecords.indexWhere(
          (r) => r.studentId == event.studentId,
        );

        if (existingIndex >= 0) {
          updatedRecords[existingIndex] = updatedRecord;
        } else {
          updatedRecords.add(updatedRecord);
        }

        final updatedAttendance = AttendanceEntity(
          id: currentState.attendance.id,
          classId: currentState.attendance.classId,
          date: currentState.attendance.date,
          markedBy: currentState.attendance.markedBy,
          isSubmitted: currentState.attendance.isSubmitted,
          createdAt: currentState.attendance.createdAt,
          updatedAt: now,
        );

        emit(
          AttendanceLoaded(
            attendance: updatedAttendance,
            records: updatedRecords,
            students: currentState.students,
          ),
        );
      },
    );
  }

  Future<void> _onSubmitAttendance(
    SubmitAttendance event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    emit(const AttendanceLoading());

    final result = await submitAttendanceUseCase(
      event.institutionId,
      event.attendanceId,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (_) {
        // Reload attendance to get updated isSubmitted status
        // For now, update current state if available
        final currentState = state;
        if (currentState is AttendanceLoaded) {
          final updatedAttendance = AttendanceEntity(
            id: currentState.attendance.id,
            classId: currentState.attendance.classId,
            date: currentState.attendance.date,
            markedBy: currentState.attendance.markedBy,
            isSubmitted: true,
            createdAt: currentState.attendance.createdAt,
            updatedAt: DateTime.now(),
          );

          emit(
            AttendanceLoaded(
              attendance: updatedAttendance,
              records: currentState.records,
              students: currentState.students,
            ),
          );
        } else {
          emit(AttendanceSubmitted(
            attendance: AttendanceEntity(
              id: event.attendanceId,
              classId: '',
              date: DateTime.now(),
              markedBy: '',
              isSubmitted: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ));
        }
      },
    );
  }

  Future<void> _onDeleteAttendance(
    DeleteAttendance event,
    Emitter<AttendanceManagementState> emit,
  ) async {
    emit(const AttendanceLoading());

    final result = await deleteAttendanceUseCase(
      event.institutionId,
      event.attendanceId,
    );

    result.fold(
      (failure) => emit(AttendanceManagementError(message: failure.message)),
      (_) => emit(const AttendanceDeleted()),
    );
  }

  String _generateAttendanceId(String classId, DateTime date) {
    // Sanitize class ID
    var sanitizedClassId = classId.replaceAll('/', '_').replaceAll(' ', '_');
    sanitizedClassId = sanitizedClassId.toLowerCase().trim();

    // Format date as YYYY-MM-DD
    final dateStr = DateFormat('yyyy-MM-dd').format(date);

    return '${sanitizedClassId}_$dateStr';
  }
}


import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../modules/attendance/domain/entities/attendance.dart';
import '../../../modules/student/domain/entities/student.dart';
import '../../../modules/attendance/domain/usecases/get_attendance.dart';
import '../../../modules/attendance/domain/usecases/submit_attendance.dart';
import '../../../modules/attendance/domain/usecases/is_attendance_submitted.dart';

part 'attendance_bloc.freezed.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendance _getAttendance;
  final SubmitAttendance _submitAttendance;
  final IsAttendanceSubmitted _isAttendanceSubmitted;

  AttendanceBloc({
    required GetAttendance getAttendance,
    required SubmitAttendance submitAttendance,
    required IsAttendanceSubmitted isAttendanceSubmitted,
  }) : _getAttendance = getAttendance,
       _submitAttendance = submitAttendance,
       _isAttendanceSubmitted = isAttendanceSubmitted,
       super(const AttendanceState.initial()) {
    on<AttendanceLoadRoster>(_onLoadRoster);
    on<AttendanceSubmitAttendance>(_onSubmitAttendance);
    on<AttendanceCheckSubmissionStatus>(_onCheckSubmissionStatus);
    on<AttendanceMarkStudentAttendance>(_onMarkStudentAttendance);
    on<AttendanceClearAttendance>(_onClearAttendance);
  }

  Future<void> _onLoadRoster(
    AttendanceLoadRoster event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceState.loading());

    // For now, we'll use placeholder data since we need to integrate with student management
    // In a real implementation, this would fetch students from the student repository
    final students = [
      Student(
        id: 'student1',
        studentId: 'STU001',
        name: 'John Doe',
        institutionId: 'institution_placeholder',
        classId: 'class_placeholder',
        email: 'john.doe@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Student(
        id: 'student2',
        studentId: 'STU002',
        name: 'Jane Smith',
        institutionId: 'institution_placeholder',
        classId: 'class_placeholder',
        email: 'jane.smith@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Student(
        id: 'student3',
        studentId: 'STU003',
        name: 'Mike Johnson',
        institutionId: 'institution_placeholder',
        classId: 'class_placeholder',
        email: 'mike.johnson@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    // Check if attendance has already been submitted for this date
    final submissionStatus = await _isAttendanceSubmitted(
      event.institutionId,
      event.classId,
      event.date,
    );

    submissionStatus.fold((failure) => emit(AttendanceState.error(failure)), (
      isSubmitted,
    ) async {
      if (isSubmitted) {
        // If already submitted, fetch existing attendance records
        final attendanceResult = await _getAttendance(
          event.institutionId,
          event.classId,
          event.date,
        );

        attendanceResult.fold(
          (failure) => emit(AttendanceState.error(failure)),
          (existingRecords) {
            // Merge existing records with student roster
            final attendanceRecords = students.map((student) {
              final existingRecord = existingRecords.firstWhere(
                (record) => record.studentId == student.id,
                orElse: () => Attendance(
                  id: '${event.date.toIso8601String()}_${student.id}',
                  studentId: student.id,
                  classId: event.classId,
                  institutionId: event.institutionId,
                  date: event.date,
                  status: AttendanceStatus.present,
                  markedBy: 'current_user_id',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
              return existingRecord;
            }).toList();

            emit(
              AttendanceState.rosterLoaded(
                students: students,
                attendanceRecords: attendanceRecords,
                date: event.date,
                isSubmitted: true,
              ),
            );
          },
        );
      } else {
        // If not submitted, create new attendance records
        final attendanceRecords = students.map((student) {
          return Attendance(
            id: '${event.date.toIso8601String()}_${student.id}',
            studentId: student.id,
            classId: event.classId,
            institutionId: event.institutionId,
            date: event.date,
            status: AttendanceStatus.present, // Default to present
            markedBy: 'current_user_id', // This would come from auth
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
        }).toList();

        emit(
          AttendanceState.rosterLoaded(
            students: students,
            attendanceRecords: attendanceRecords,
            date: event.date,
            isSubmitted: false,
          ),
        );
      }
    });
  }

  Future<void> _onSubmitAttendance(
    AttendanceSubmitAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceState.submitting());

    final result = await _submitAttendance(
      event.institutionId,
      event.classId,
      event.date,
      event.attendanceRecords,
    );

    result.fold(
      (failure) => emit(AttendanceState.error(failure)),
      (_) => emit(const AttendanceState.submitted()),
    );
  }

  Future<void> _onCheckSubmissionStatus(
    AttendanceCheckSubmissionStatus event,
    Emitter<AttendanceState> emit,
  ) async {
    final result = await _isAttendanceSubmitted(
      event.institutionId,
      event.classId,
      event.date,
    );

    result.fold(
      (failure) => emit(AttendanceState.error(failure)),
      (isSubmitted) =>
          emit(AttendanceState.submissionStatusChecked(isSubmitted)),
    );
  }

  void _onMarkStudentAttendance(
    AttendanceMarkStudentAttendance event,
    Emitter<AttendanceState> emit,
  ) {
    state.maybeWhen(
      rosterLoaded: (students, attendanceRecords, date, isSubmitted) {
        final updatedRecords = attendanceRecords.map((record) {
          if (record.studentId == event.studentId) {
            return record.copyWith(
              status: event.status,
              notes: event.notes,
              updatedAt: DateTime.now(),
            );
          }
          return record;
        }).toList();

        emit(
          AttendanceState.rosterLoaded(
            students: students,
            attendanceRecords: updatedRecords,
            date: date,
            isSubmitted: isSubmitted,
          ),
        );
      },
      orElse: () {},
    );
  }

  void _onClearAttendance(
    AttendanceClearAttendance event,
    Emitter<AttendanceState> emit,
  ) {
    emit(const AttendanceState.initial());
  }
}

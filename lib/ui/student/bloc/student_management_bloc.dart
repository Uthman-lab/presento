import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../modules/student/domain/entities/student.dart';
import '../../../modules/student/domain/usecases/get_students.dart';
import '../../../modules/student/domain/usecases/create_student.dart';
import '../../../modules/student/domain/usecases/update_student.dart';
import '../../../modules/student/domain/usecases/delete_student.dart';

part 'student_management_event.dart';
part 'student_management_state.dart';
part 'student_management_bloc.freezed.dart';

class StudentManagementBloc
    extends Bloc<StudentManagementEvent, StudentManagementState> {
  final GetStudents _getStudents;
  final CreateStudent _createStudent;
  final UpdateStudent _updateStudent;
  final DeleteStudent _deleteStudent;

  StudentManagementBloc({
    required GetStudents getStudents,
    required CreateStudent createStudent,
    required UpdateStudent updateStudent,
    required DeleteStudent deleteStudent,
  }) : _getStudents = getStudents,
       _createStudent = createStudent,
       _updateStudent = updateStudent,
       _deleteStudent = deleteStudent,
       super(const StudentManagementState.initial()) {
    on<StudentManagementLoadStudents>(_onLoadStudents);
    on<StudentManagementCreateStudent>(_onCreateStudent);
    on<StudentManagementUpdateStudent>(_onUpdateStudent);
    on<StudentManagementDeleteStudent>(_onDeleteStudent);
  }

  Future<void> _onLoadStudents(
    StudentManagementLoadStudents event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementState.loading());
    final result = await _getStudents(event.institutionId, event.classId);
    result.fold(
      (failure) => emit(StudentManagementState.error(failure)),
      (students) => emit(StudentManagementState.loaded(students)),
    );
  }

  Future<void> _onCreateStudent(
    StudentManagementCreateStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementState.loading());
    final result = await _createStudent(event.institutionId, event.newStudent);
    result.fold((failure) => emit(StudentManagementState.error(failure)), (_) {
      // Reload students after creating
      add(
        StudentManagementLoadStudents(
          event.institutionId,
          event.newStudent.classId,
        ),
      );
    });
  }

  Future<void> _onUpdateStudent(
    StudentManagementUpdateStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementState.loading());
    final result = await _updateStudent(
      event.institutionId,
      event.updatedStudent,
    );
    result.fold((failure) => emit(StudentManagementState.error(failure)), (_) {
      // Reload students after updating
      add(
        StudentManagementLoadStudents(
          event.institutionId,
          event.updatedStudent.classId,
        ),
      );
    });
  }

  Future<void> _onDeleteStudent(
    StudentManagementDeleteStudent event,
    Emitter<StudentManagementState> emit,
  ) async {
    emit(const StudentManagementState.loading());
    final result = await _deleteStudent(event.institutionId, event.studentId);
    result.fold((failure) => emit(StudentManagementState.error(failure)), (_) {
      // Reload students after deleting
      add(StudentManagementLoadStudents(event.institutionId, event.classId));
    });
  }
}

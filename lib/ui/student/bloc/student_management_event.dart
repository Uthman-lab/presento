part of 'student_management_bloc.dart';

@freezed
class StudentManagementEvent with _$StudentManagementEvent {
  const factory StudentManagementEvent.loadStudents(
    String institutionId,
    String classId,
  ) = StudentManagementLoadStudents;
  const factory StudentManagementEvent.createStudent(
    String institutionId,
    Student newStudent,
  ) = StudentManagementCreateStudent;
  const factory StudentManagementEvent.updateStudent(
    String institutionId,
    Student updatedStudent,
  ) = StudentManagementUpdateStudent;
  const factory StudentManagementEvent.deleteStudent(
    String institutionId,
    String studentId,
    String classId,
  ) = StudentManagementDeleteStudent;
}

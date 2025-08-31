part of 'attendance_bloc.dart';

@freezed
class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent.loadRoster(
    String institutionId,
    String classId,
    DateTime date,
  ) = AttendanceLoadRoster;

  const factory AttendanceEvent.submitAttendance(
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  ) = AttendanceSubmitAttendance;

  const factory AttendanceEvent.checkSubmissionStatus(
    String institutionId,
    String classId,
    DateTime date,
  ) = AttendanceCheckSubmissionStatus;

  const factory AttendanceEvent.markStudentAttendance(
    String studentId,
    AttendanceStatus status,
    String? notes,
  ) = AttendanceMarkStudentAttendance;

  const factory AttendanceEvent.clearAttendance() = AttendanceClearAttendance;
}

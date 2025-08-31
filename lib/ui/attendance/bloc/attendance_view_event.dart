part of 'attendance_view_bloc.dart';

@freezed
class AttendanceViewEvent with _$AttendanceViewEvent {
  const factory AttendanceViewEvent.loadAttendance(
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  ) = AttendanceViewLoadAttendance;

  const factory AttendanceViewEvent.filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) = AttendanceViewFilterByDateRange;

  const factory AttendanceViewEvent.filterByStudent(String studentId) =
      AttendanceViewFilterByStudent;

  const factory AttendanceViewEvent.clearFilters() = AttendanceViewClearFilters;
}

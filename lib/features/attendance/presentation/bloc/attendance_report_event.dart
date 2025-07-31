part of 'attendance_report_bloc.dart';

@freezed
class AttendanceReportEvent with _$AttendanceReportEvent {
  const factory AttendanceReportEvent.loadReport(
    String institutionId,
    String classId,
    DateTime date,
  ) = AttendanceReportLoadReport;

  const factory AttendanceReportEvent.filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) = AttendanceReportFilterByDateRange;

  const factory AttendanceReportEvent.filterByStudent(String studentId) =
      AttendanceReportFilterByStudent;

  const factory AttendanceReportEvent.clearFilters() =
      AttendanceReportClearFilters;
}

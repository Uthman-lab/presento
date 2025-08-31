part of 'attendance_report_bloc.dart';

@freezed
class AttendanceReportState with _$AttendanceReportState {
  const factory AttendanceReportState.initial() = _Initial;
  const factory AttendanceReportState.loading() = _Loading;
  const factory AttendanceReportState.reportLoaded({
    required List<AttendanceReportItem> reportData,
    required AttendanceStatistics statistics,
    required DateTime date,
  }) = _ReportLoaded;
  const factory AttendanceReportState.error(Failure failure) = _Error;
}

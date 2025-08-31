part of 'attendance_view_bloc.dart';

@freezed
class AttendanceViewState with _$AttendanceViewState {
  const factory AttendanceViewState.initial() = _Initial;
  const factory AttendanceViewState.loading() = _Loading;
  const factory AttendanceViewState.attendanceLoaded({
    required List<AttendanceViewItem> viewData,
    required AttendanceViewStatistics statistics,
    required DateTime startDate,
    required DateTime endDate,
  }) = _AttendanceLoaded;
  const factory AttendanceViewState.error(Failure failure) = _Error;
}

part of 'attendance_bloc.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.submitting() = _Submitting;
  const factory AttendanceState.rosterLoaded({
    required List<Student> students,
    required List<Attendance> attendanceRecords,
    required DateTime date,
    required bool isSubmitted,
  }) = _RosterLoaded;
  const factory AttendanceState.submitted() = _Submitted;
  const factory AttendanceState.submissionStatusChecked(bool isSubmitted) =
      _SubmissionStatusChecked;
  const factory AttendanceState.error(Failure failure) = _Error;
}

part of 'student_management_bloc.dart';

@freezed
class StudentManagementState with _$StudentManagementState {
  const factory StudentManagementState.initial() = _Initial;
  const factory StudentManagementState.loading() = _Loading;
  const factory StudentManagementState.loaded(List<Student> students) = _Loaded;
  const factory StudentManagementState.error(Failure failure) = _Error;
}

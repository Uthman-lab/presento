part of 'class_management_bloc.dart';

@freezed
class ClassManagementState with _$ClassManagementState {
  const factory ClassManagementState.initial() = _Initial;
  const factory ClassManagementState.loading() = _Loading;
  const factory ClassManagementState.loaded(List<Class> classes) = _Loaded;
  const factory ClassManagementState.error(Failure failure) = _Error;
}

part of 'class_management_bloc.dart';

@freezed
class ClassManagementEvent with _$ClassManagementEvent {
  const factory ClassManagementEvent.loadClasses(String institutionId) =
      ClassManagementLoadClasses;
  const factory ClassManagementEvent.createClass(
    String institutionId,
    Class newClass,
  ) = ClassManagementCreateClass;
  const factory ClassManagementEvent.updateClass(
    String institutionId,
    Class updatedClass,
  ) = ClassManagementUpdateClass;
  const factory ClassManagementEvent.deleteClass(
    String institutionId,
    String classId,
  ) = ClassManagementDeleteClass;
}

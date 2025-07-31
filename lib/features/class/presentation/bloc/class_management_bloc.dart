import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/class.dart';
import '../../domain/usecases/get_classes.dart';
import '../../domain/usecases/create_class.dart';
import '../../domain/usecases/update_class.dart';
import '../../domain/usecases/delete_class.dart';

part 'class_management_event.dart';
part 'class_management_state.dart';
part 'class_management_bloc.freezed.dart';

class ClassManagementBloc
    extends Bloc<ClassManagementEvent, ClassManagementState> {
  final GetClasses _getClasses;
  final CreateClass _createClass;
  final UpdateClass _updateClass;
  final DeleteClass _deleteClass;

  ClassManagementBloc({
    required GetClasses getClasses,
    required CreateClass createClass,
    required UpdateClass updateClass,
    required DeleteClass deleteClass,
  }) : _getClasses = getClasses,
       _createClass = createClass,
       _updateClass = updateClass,
       _deleteClass = deleteClass,
       super(const ClassManagementState.initial()) {
    on<ClassManagementLoadClasses>(_onLoadClasses);
    on<ClassManagementCreateClass>(_onCreateClass);
    on<ClassManagementUpdateClass>(_onUpdateClass);
    on<ClassManagementDeleteClass>(_onDeleteClass);
  }

  Future<void> _onLoadClasses(
    ClassManagementLoadClasses event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementState.loading());
    final result = await _getClasses(event.institutionId);
    result.fold(
      (failure) => emit(ClassManagementState.error(failure)),
      (classes) => emit(ClassManagementState.loaded(classes)),
    );
  }

  Future<void> _onCreateClass(
    ClassManagementCreateClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementState.loading());
    final result = await _createClass(event.institutionId, event.newClass);
    result.fold((failure) => emit(ClassManagementState.error(failure)), (_) {
      // Reload classes after creating
      add(ClassManagementLoadClasses(event.institutionId));
    });
  }

  Future<void> _onUpdateClass(
    ClassManagementUpdateClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementState.loading());
    final result = await _updateClass(event.institutionId, event.updatedClass);
    result.fold((failure) => emit(ClassManagementState.error(failure)), (_) {
      // Reload classes after updating
      add(ClassManagementLoadClasses(event.institutionId));
    });
  }

  Future<void> _onDeleteClass(
    ClassManagementDeleteClass event,
    Emitter<ClassManagementState> emit,
  ) async {
    emit(const ClassManagementState.loading());
    final result = await _deleteClass(event.institutionId, event.classId);
    result.fold((failure) => emit(ClassManagementState.error(failure)), (_) {
      // Reload classes after deleting
      add(ClassManagementLoadClasses(event.institutionId));
    });
  }
}

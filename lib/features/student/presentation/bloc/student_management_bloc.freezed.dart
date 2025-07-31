// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_management_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StudentManagementEvent {
  String get institutionId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId, String classId)
    loadStudents,
    required TResult Function(String institutionId, Student newStudent)
    createStudent,
    required TResult Function(String institutionId, Student updatedStudent)
    updateStudent,
    required TResult Function(
      String institutionId,
      String studentId,
      String classId,
    )
    deleteStudent,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId)? loadStudents,
    TResult? Function(String institutionId, Student newStudent)? createStudent,
    TResult? Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult? Function(String institutionId, String studentId, String classId)?
    deleteStudent,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId)? loadStudents,
    TResult Function(String institutionId, Student newStudent)? createStudent,
    TResult Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult Function(String institutionId, String studentId, String classId)?
    deleteStudent,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudentManagementLoadStudents value) loadStudents,
    required TResult Function(StudentManagementCreateStudent value)
    createStudent,
    required TResult Function(StudentManagementUpdateStudent value)
    updateStudent,
    required TResult Function(StudentManagementDeleteStudent value)
    deleteStudent,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudentManagementLoadStudents value)? loadStudents,
    TResult? Function(StudentManagementCreateStudent value)? createStudent,
    TResult? Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult? Function(StudentManagementDeleteStudent value)? deleteStudent,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudentManagementLoadStudents value)? loadStudents,
    TResult Function(StudentManagementCreateStudent value)? createStudent,
    TResult Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult Function(StudentManagementDeleteStudent value)? deleteStudent,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentManagementEventCopyWith<StudentManagementEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentManagementEventCopyWith<$Res> {
  factory $StudentManagementEventCopyWith(
    StudentManagementEvent value,
    $Res Function(StudentManagementEvent) then,
  ) = _$StudentManagementEventCopyWithImpl<$Res, StudentManagementEvent>;
  @useResult
  $Res call({String institutionId});
}

/// @nodoc
class _$StudentManagementEventCopyWithImpl<
  $Res,
  $Val extends StudentManagementEvent
>
    implements $StudentManagementEventCopyWith<$Res> {
  _$StudentManagementEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null}) {
    return _then(
      _value.copyWith(
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentManagementLoadStudentsImplCopyWith<$Res>
    implements $StudentManagementEventCopyWith<$Res> {
  factory _$$StudentManagementLoadStudentsImplCopyWith(
    _$StudentManagementLoadStudentsImpl value,
    $Res Function(_$StudentManagementLoadStudentsImpl) then,
  ) = __$$StudentManagementLoadStudentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, String classId});
}

/// @nodoc
class __$$StudentManagementLoadStudentsImplCopyWithImpl<$Res>
    extends
        _$StudentManagementEventCopyWithImpl<
          $Res,
          _$StudentManagementLoadStudentsImpl
        >
    implements _$$StudentManagementLoadStudentsImplCopyWith<$Res> {
  __$$StudentManagementLoadStudentsImplCopyWithImpl(
    _$StudentManagementLoadStudentsImpl _value,
    $Res Function(_$StudentManagementLoadStudentsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? classId = null}) {
    return _then(
      _$StudentManagementLoadStudentsImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StudentManagementLoadStudentsImpl
    implements StudentManagementLoadStudents {
  const _$StudentManagementLoadStudentsImpl(this.institutionId, this.classId);

  @override
  final String institutionId;
  @override
  final String classId;

  @override
  String toString() {
    return 'StudentManagementEvent.loadStudents(institutionId: $institutionId, classId: $classId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentManagementLoadStudentsImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, classId);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentManagementLoadStudentsImplCopyWith<
    _$StudentManagementLoadStudentsImpl
  >
  get copyWith =>
      __$$StudentManagementLoadStudentsImplCopyWithImpl<
        _$StudentManagementLoadStudentsImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId, String classId)
    loadStudents,
    required TResult Function(String institutionId, Student newStudent)
    createStudent,
    required TResult Function(String institutionId, Student updatedStudent)
    updateStudent,
    required TResult Function(
      String institutionId,
      String studentId,
      String classId,
    )
    deleteStudent,
  }) {
    return loadStudents(institutionId, classId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId)? loadStudents,
    TResult? Function(String institutionId, Student newStudent)? createStudent,
    TResult? Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult? Function(String institutionId, String studentId, String classId)?
    deleteStudent,
  }) {
    return loadStudents?.call(institutionId, classId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId)? loadStudents,
    TResult Function(String institutionId, Student newStudent)? createStudent,
    TResult Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult Function(String institutionId, String studentId, String classId)?
    deleteStudent,
    required TResult orElse(),
  }) {
    if (loadStudents != null) {
      return loadStudents(institutionId, classId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudentManagementLoadStudents value) loadStudents,
    required TResult Function(StudentManagementCreateStudent value)
    createStudent,
    required TResult Function(StudentManagementUpdateStudent value)
    updateStudent,
    required TResult Function(StudentManagementDeleteStudent value)
    deleteStudent,
  }) {
    return loadStudents(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudentManagementLoadStudents value)? loadStudents,
    TResult? Function(StudentManagementCreateStudent value)? createStudent,
    TResult? Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult? Function(StudentManagementDeleteStudent value)? deleteStudent,
  }) {
    return loadStudents?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudentManagementLoadStudents value)? loadStudents,
    TResult Function(StudentManagementCreateStudent value)? createStudent,
    TResult Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult Function(StudentManagementDeleteStudent value)? deleteStudent,
    required TResult orElse(),
  }) {
    if (loadStudents != null) {
      return loadStudents(this);
    }
    return orElse();
  }
}

abstract class StudentManagementLoadStudents implements StudentManagementEvent {
  const factory StudentManagementLoadStudents(
    final String institutionId,
    final String classId,
  ) = _$StudentManagementLoadStudentsImpl;

  @override
  String get institutionId;
  String get classId;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentManagementLoadStudentsImplCopyWith<
    _$StudentManagementLoadStudentsImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentManagementCreateStudentImplCopyWith<$Res>
    implements $StudentManagementEventCopyWith<$Res> {
  factory _$$StudentManagementCreateStudentImplCopyWith(
    _$StudentManagementCreateStudentImpl value,
    $Res Function(_$StudentManagementCreateStudentImpl) then,
  ) = __$$StudentManagementCreateStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, Student newStudent});
}

/// @nodoc
class __$$StudentManagementCreateStudentImplCopyWithImpl<$Res>
    extends
        _$StudentManagementEventCopyWithImpl<
          $Res,
          _$StudentManagementCreateStudentImpl
        >
    implements _$$StudentManagementCreateStudentImplCopyWith<$Res> {
  __$$StudentManagementCreateStudentImplCopyWithImpl(
    _$StudentManagementCreateStudentImpl _value,
    $Res Function(_$StudentManagementCreateStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? newStudent = null}) {
    return _then(
      _$StudentManagementCreateStudentImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == newStudent
            ? _value.newStudent
            : newStudent // ignore: cast_nullable_to_non_nullable
                  as Student,
      ),
    );
  }
}

/// @nodoc

class _$StudentManagementCreateStudentImpl
    implements StudentManagementCreateStudent {
  const _$StudentManagementCreateStudentImpl(
    this.institutionId,
    this.newStudent,
  );

  @override
  final String institutionId;
  @override
  final Student newStudent;

  @override
  String toString() {
    return 'StudentManagementEvent.createStudent(institutionId: $institutionId, newStudent: $newStudent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentManagementCreateStudentImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.newStudent, newStudent) ||
                other.newStudent == newStudent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, newStudent);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentManagementCreateStudentImplCopyWith<
    _$StudentManagementCreateStudentImpl
  >
  get copyWith =>
      __$$StudentManagementCreateStudentImplCopyWithImpl<
        _$StudentManagementCreateStudentImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId, String classId)
    loadStudents,
    required TResult Function(String institutionId, Student newStudent)
    createStudent,
    required TResult Function(String institutionId, Student updatedStudent)
    updateStudent,
    required TResult Function(
      String institutionId,
      String studentId,
      String classId,
    )
    deleteStudent,
  }) {
    return createStudent(institutionId, newStudent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId)? loadStudents,
    TResult? Function(String institutionId, Student newStudent)? createStudent,
    TResult? Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult? Function(String institutionId, String studentId, String classId)?
    deleteStudent,
  }) {
    return createStudent?.call(institutionId, newStudent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId)? loadStudents,
    TResult Function(String institutionId, Student newStudent)? createStudent,
    TResult Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult Function(String institutionId, String studentId, String classId)?
    deleteStudent,
    required TResult orElse(),
  }) {
    if (createStudent != null) {
      return createStudent(institutionId, newStudent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudentManagementLoadStudents value) loadStudents,
    required TResult Function(StudentManagementCreateStudent value)
    createStudent,
    required TResult Function(StudentManagementUpdateStudent value)
    updateStudent,
    required TResult Function(StudentManagementDeleteStudent value)
    deleteStudent,
  }) {
    return createStudent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudentManagementLoadStudents value)? loadStudents,
    TResult? Function(StudentManagementCreateStudent value)? createStudent,
    TResult? Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult? Function(StudentManagementDeleteStudent value)? deleteStudent,
  }) {
    return createStudent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudentManagementLoadStudents value)? loadStudents,
    TResult Function(StudentManagementCreateStudent value)? createStudent,
    TResult Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult Function(StudentManagementDeleteStudent value)? deleteStudent,
    required TResult orElse(),
  }) {
    if (createStudent != null) {
      return createStudent(this);
    }
    return orElse();
  }
}

abstract class StudentManagementCreateStudent
    implements StudentManagementEvent {
  const factory StudentManagementCreateStudent(
    final String institutionId,
    final Student newStudent,
  ) = _$StudentManagementCreateStudentImpl;

  @override
  String get institutionId;
  Student get newStudent;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentManagementCreateStudentImplCopyWith<
    _$StudentManagementCreateStudentImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentManagementUpdateStudentImplCopyWith<$Res>
    implements $StudentManagementEventCopyWith<$Res> {
  factory _$$StudentManagementUpdateStudentImplCopyWith(
    _$StudentManagementUpdateStudentImpl value,
    $Res Function(_$StudentManagementUpdateStudentImpl) then,
  ) = __$$StudentManagementUpdateStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, Student updatedStudent});
}

/// @nodoc
class __$$StudentManagementUpdateStudentImplCopyWithImpl<$Res>
    extends
        _$StudentManagementEventCopyWithImpl<
          $Res,
          _$StudentManagementUpdateStudentImpl
        >
    implements _$$StudentManagementUpdateStudentImplCopyWith<$Res> {
  __$$StudentManagementUpdateStudentImplCopyWithImpl(
    _$StudentManagementUpdateStudentImpl _value,
    $Res Function(_$StudentManagementUpdateStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? updatedStudent = null}) {
    return _then(
      _$StudentManagementUpdateStudentImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == updatedStudent
            ? _value.updatedStudent
            : updatedStudent // ignore: cast_nullable_to_non_nullable
                  as Student,
      ),
    );
  }
}

/// @nodoc

class _$StudentManagementUpdateStudentImpl
    implements StudentManagementUpdateStudent {
  const _$StudentManagementUpdateStudentImpl(
    this.institutionId,
    this.updatedStudent,
  );

  @override
  final String institutionId;
  @override
  final Student updatedStudent;

  @override
  String toString() {
    return 'StudentManagementEvent.updateStudent(institutionId: $institutionId, updatedStudent: $updatedStudent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentManagementUpdateStudentImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.updatedStudent, updatedStudent) ||
                other.updatedStudent == updatedStudent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, updatedStudent);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentManagementUpdateStudentImplCopyWith<
    _$StudentManagementUpdateStudentImpl
  >
  get copyWith =>
      __$$StudentManagementUpdateStudentImplCopyWithImpl<
        _$StudentManagementUpdateStudentImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId, String classId)
    loadStudents,
    required TResult Function(String institutionId, Student newStudent)
    createStudent,
    required TResult Function(String institutionId, Student updatedStudent)
    updateStudent,
    required TResult Function(
      String institutionId,
      String studentId,
      String classId,
    )
    deleteStudent,
  }) {
    return updateStudent(institutionId, updatedStudent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId)? loadStudents,
    TResult? Function(String institutionId, Student newStudent)? createStudent,
    TResult? Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult? Function(String institutionId, String studentId, String classId)?
    deleteStudent,
  }) {
    return updateStudent?.call(institutionId, updatedStudent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId)? loadStudents,
    TResult Function(String institutionId, Student newStudent)? createStudent,
    TResult Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult Function(String institutionId, String studentId, String classId)?
    deleteStudent,
    required TResult orElse(),
  }) {
    if (updateStudent != null) {
      return updateStudent(institutionId, updatedStudent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudentManagementLoadStudents value) loadStudents,
    required TResult Function(StudentManagementCreateStudent value)
    createStudent,
    required TResult Function(StudentManagementUpdateStudent value)
    updateStudent,
    required TResult Function(StudentManagementDeleteStudent value)
    deleteStudent,
  }) {
    return updateStudent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudentManagementLoadStudents value)? loadStudents,
    TResult? Function(StudentManagementCreateStudent value)? createStudent,
    TResult? Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult? Function(StudentManagementDeleteStudent value)? deleteStudent,
  }) {
    return updateStudent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudentManagementLoadStudents value)? loadStudents,
    TResult Function(StudentManagementCreateStudent value)? createStudent,
    TResult Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult Function(StudentManagementDeleteStudent value)? deleteStudent,
    required TResult orElse(),
  }) {
    if (updateStudent != null) {
      return updateStudent(this);
    }
    return orElse();
  }
}

abstract class StudentManagementUpdateStudent
    implements StudentManagementEvent {
  const factory StudentManagementUpdateStudent(
    final String institutionId,
    final Student updatedStudent,
  ) = _$StudentManagementUpdateStudentImpl;

  @override
  String get institutionId;
  Student get updatedStudent;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentManagementUpdateStudentImplCopyWith<
    _$StudentManagementUpdateStudentImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentManagementDeleteStudentImplCopyWith<$Res>
    implements $StudentManagementEventCopyWith<$Res> {
  factory _$$StudentManagementDeleteStudentImplCopyWith(
    _$StudentManagementDeleteStudentImpl value,
    $Res Function(_$StudentManagementDeleteStudentImpl) then,
  ) = __$$StudentManagementDeleteStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, String studentId, String classId});
}

/// @nodoc
class __$$StudentManagementDeleteStudentImplCopyWithImpl<$Res>
    extends
        _$StudentManagementEventCopyWithImpl<
          $Res,
          _$StudentManagementDeleteStudentImpl
        >
    implements _$$StudentManagementDeleteStudentImplCopyWith<$Res> {
  __$$StudentManagementDeleteStudentImplCopyWithImpl(
    _$StudentManagementDeleteStudentImpl _value,
    $Res Function(_$StudentManagementDeleteStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? studentId = null,
    Object? classId = null,
  }) {
    return _then(
      _$StudentManagementDeleteStudentImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StudentManagementDeleteStudentImpl
    implements StudentManagementDeleteStudent {
  const _$StudentManagementDeleteStudentImpl(
    this.institutionId,
    this.studentId,
    this.classId,
  );

  @override
  final String institutionId;
  @override
  final String studentId;
  @override
  final String classId;

  @override
  String toString() {
    return 'StudentManagementEvent.deleteStudent(institutionId: $institutionId, studentId: $studentId, classId: $classId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentManagementDeleteStudentImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.classId, classId) || other.classId == classId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, institutionId, studentId, classId);

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentManagementDeleteStudentImplCopyWith<
    _$StudentManagementDeleteStudentImpl
  >
  get copyWith =>
      __$$StudentManagementDeleteStudentImplCopyWithImpl<
        _$StudentManagementDeleteStudentImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId, String classId)
    loadStudents,
    required TResult Function(String institutionId, Student newStudent)
    createStudent,
    required TResult Function(String institutionId, Student updatedStudent)
    updateStudent,
    required TResult Function(
      String institutionId,
      String studentId,
      String classId,
    )
    deleteStudent,
  }) {
    return deleteStudent(institutionId, studentId, classId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId)? loadStudents,
    TResult? Function(String institutionId, Student newStudent)? createStudent,
    TResult? Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult? Function(String institutionId, String studentId, String classId)?
    deleteStudent,
  }) {
    return deleteStudent?.call(institutionId, studentId, classId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId)? loadStudents,
    TResult Function(String institutionId, Student newStudent)? createStudent,
    TResult Function(String institutionId, Student updatedStudent)?
    updateStudent,
    TResult Function(String institutionId, String studentId, String classId)?
    deleteStudent,
    required TResult orElse(),
  }) {
    if (deleteStudent != null) {
      return deleteStudent(institutionId, studentId, classId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudentManagementLoadStudents value) loadStudents,
    required TResult Function(StudentManagementCreateStudent value)
    createStudent,
    required TResult Function(StudentManagementUpdateStudent value)
    updateStudent,
    required TResult Function(StudentManagementDeleteStudent value)
    deleteStudent,
  }) {
    return deleteStudent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudentManagementLoadStudents value)? loadStudents,
    TResult? Function(StudentManagementCreateStudent value)? createStudent,
    TResult? Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult? Function(StudentManagementDeleteStudent value)? deleteStudent,
  }) {
    return deleteStudent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudentManagementLoadStudents value)? loadStudents,
    TResult Function(StudentManagementCreateStudent value)? createStudent,
    TResult Function(StudentManagementUpdateStudent value)? updateStudent,
    TResult Function(StudentManagementDeleteStudent value)? deleteStudent,
    required TResult orElse(),
  }) {
    if (deleteStudent != null) {
      return deleteStudent(this);
    }
    return orElse();
  }
}

abstract class StudentManagementDeleteStudent
    implements StudentManagementEvent {
  const factory StudentManagementDeleteStudent(
    final String institutionId,
    final String studentId,
    final String classId,
  ) = _$StudentManagementDeleteStudentImpl;

  @override
  String get institutionId;
  String get studentId;
  String get classId;

  /// Create a copy of StudentManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentManagementDeleteStudentImplCopyWith<
    _$StudentManagementDeleteStudentImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StudentManagementState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Student> students) loaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Student> students)? loaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Student> students)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentManagementStateCopyWith<$Res> {
  factory $StudentManagementStateCopyWith(
    StudentManagementState value,
    $Res Function(StudentManagementState) then,
  ) = _$StudentManagementStateCopyWithImpl<$Res, StudentManagementState>;
}

/// @nodoc
class _$StudentManagementStateCopyWithImpl<
  $Res,
  $Val extends StudentManagementState
>
    implements $StudentManagementStateCopyWith<$Res> {
  _$StudentManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$StudentManagementStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'StudentManagementState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Student> students) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Student> students)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Student> students)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements StudentManagementState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StudentManagementStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StudentManagementState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Student> students) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Student> students)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Student> students)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements StudentManagementState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Student> students});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StudentManagementStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? students = null}) {
    return _then(
      _$LoadedImpl(
        null == students
            ? _value._students
            : students // ignore: cast_nullable_to_non_nullable
                  as List<Student>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Student> students) : _students = students;

  final List<Student> _students;
  @override
  List<Student> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  String toString() {
    return 'StudentManagementState.loaded(students: $students)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._students, _students));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_students));

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Student> students) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(students);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Student> students)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(students);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Student> students)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(students);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements StudentManagementState {
  const factory _Loaded(final List<Student> students) = _$LoadedImpl;

  List<Student> get students;

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StudentManagementStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$ErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'StudentManagementState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Student> students) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Student> students)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Student> students)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements StudentManagementState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of StudentManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

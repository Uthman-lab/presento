// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AttendanceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceEventCopyWith<$Res> {
  factory $AttendanceEventCopyWith(
    AttendanceEvent value,
    $Res Function(AttendanceEvent) then,
  ) = _$AttendanceEventCopyWithImpl<$Res, AttendanceEvent>;
}

/// @nodoc
class _$AttendanceEventCopyWithImpl<$Res, $Val extends AttendanceEvent>
    implements $AttendanceEventCopyWith<$Res> {
  _$AttendanceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AttendanceLoadRosterImplCopyWith<$Res> {
  factory _$$AttendanceLoadRosterImplCopyWith(
    _$AttendanceLoadRosterImpl value,
    $Res Function(_$AttendanceLoadRosterImpl) then,
  ) = __$$AttendanceLoadRosterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String institutionId, String classId, DateTime date});
}

/// @nodoc
class __$$AttendanceLoadRosterImplCopyWithImpl<$Res>
    extends _$AttendanceEventCopyWithImpl<$Res, _$AttendanceLoadRosterImpl>
    implements _$$AttendanceLoadRosterImplCopyWith<$Res> {
  __$$AttendanceLoadRosterImplCopyWithImpl(
    _$AttendanceLoadRosterImpl _value,
    $Res Function(_$AttendanceLoadRosterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? date = null,
  }) {
    return _then(
      _$AttendanceLoadRosterImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceLoadRosterImpl implements AttendanceLoadRoster {
  const _$AttendanceLoadRosterImpl(this.institutionId, this.classId, this.date);

  @override
  final String institutionId;
  @override
  final String classId;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'AttendanceEvent.loadRoster(institutionId: $institutionId, classId: $classId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceLoadRosterImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, classId, date);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceLoadRosterImplCopyWith<_$AttendanceLoadRosterImpl>
  get copyWith =>
      __$$AttendanceLoadRosterImplCopyWithImpl<_$AttendanceLoadRosterImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) {
    return loadRoster(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) {
    return loadRoster?.call(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) {
    if (loadRoster != null) {
      return loadRoster(institutionId, classId, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) {
    return loadRoster(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) {
    return loadRoster?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) {
    if (loadRoster != null) {
      return loadRoster(this);
    }
    return orElse();
  }
}

abstract class AttendanceLoadRoster implements AttendanceEvent {
  const factory AttendanceLoadRoster(
    final String institutionId,
    final String classId,
    final DateTime date,
  ) = _$AttendanceLoadRosterImpl;

  String get institutionId;
  String get classId;
  DateTime get date;

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceLoadRosterImplCopyWith<_$AttendanceLoadRosterImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceSubmitAttendanceImplCopyWith<$Res> {
  factory _$$AttendanceSubmitAttendanceImplCopyWith(
    _$AttendanceSubmitAttendanceImpl value,
    $Res Function(_$AttendanceSubmitAttendanceImpl) then,
  ) = __$$AttendanceSubmitAttendanceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String institutionId,
    String classId,
    DateTime date,
    List<Attendance> attendanceRecords,
  });
}

/// @nodoc
class __$$AttendanceSubmitAttendanceImplCopyWithImpl<$Res>
    extends
        _$AttendanceEventCopyWithImpl<$Res, _$AttendanceSubmitAttendanceImpl>
    implements _$$AttendanceSubmitAttendanceImplCopyWith<$Res> {
  __$$AttendanceSubmitAttendanceImplCopyWithImpl(
    _$AttendanceSubmitAttendanceImpl _value,
    $Res Function(_$AttendanceSubmitAttendanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? date = null,
    Object? attendanceRecords = null,
  }) {
    return _then(
      _$AttendanceSubmitAttendanceImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        null == attendanceRecords
            ? _value._attendanceRecords
            : attendanceRecords // ignore: cast_nullable_to_non_nullable
                  as List<Attendance>,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceSubmitAttendanceImpl implements AttendanceSubmitAttendance {
  const _$AttendanceSubmitAttendanceImpl(
    this.institutionId,
    this.classId,
    this.date,
    final List<Attendance> attendanceRecords,
  ) : _attendanceRecords = attendanceRecords;

  @override
  final String institutionId;
  @override
  final String classId;
  @override
  final DateTime date;
  final List<Attendance> _attendanceRecords;
  @override
  List<Attendance> get attendanceRecords {
    if (_attendanceRecords is EqualUnmodifiableListView)
      return _attendanceRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceRecords);
  }

  @override
  String toString() {
    return 'AttendanceEvent.submitAttendance(institutionId: $institutionId, classId: $classId, date: $date, attendanceRecords: $attendanceRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSubmitAttendanceImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(
              other._attendanceRecords,
              _attendanceRecords,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    institutionId,
    classId,
    date,
    const DeepCollectionEquality().hash(_attendanceRecords),
  );

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSubmitAttendanceImplCopyWith<_$AttendanceSubmitAttendanceImpl>
  get copyWith =>
      __$$AttendanceSubmitAttendanceImplCopyWithImpl<
        _$AttendanceSubmitAttendanceImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) {
    return submitAttendance(institutionId, classId, date, attendanceRecords);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) {
    return submitAttendance?.call(
      institutionId,
      classId,
      date,
      attendanceRecords,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) {
    if (submitAttendance != null) {
      return submitAttendance(institutionId, classId, date, attendanceRecords);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) {
    return submitAttendance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) {
    return submitAttendance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) {
    if (submitAttendance != null) {
      return submitAttendance(this);
    }
    return orElse();
  }
}

abstract class AttendanceSubmitAttendance implements AttendanceEvent {
  const factory AttendanceSubmitAttendance(
    final String institutionId,
    final String classId,
    final DateTime date,
    final List<Attendance> attendanceRecords,
  ) = _$AttendanceSubmitAttendanceImpl;

  String get institutionId;
  String get classId;
  DateTime get date;
  List<Attendance> get attendanceRecords;

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSubmitAttendanceImplCopyWith<_$AttendanceSubmitAttendanceImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceCheckSubmissionStatusImplCopyWith<$Res> {
  factory _$$AttendanceCheckSubmissionStatusImplCopyWith(
    _$AttendanceCheckSubmissionStatusImpl value,
    $Res Function(_$AttendanceCheckSubmissionStatusImpl) then,
  ) = __$$AttendanceCheckSubmissionStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String institutionId, String classId, DateTime date});
}

/// @nodoc
class __$$AttendanceCheckSubmissionStatusImplCopyWithImpl<$Res>
    extends
        _$AttendanceEventCopyWithImpl<
          $Res,
          _$AttendanceCheckSubmissionStatusImpl
        >
    implements _$$AttendanceCheckSubmissionStatusImplCopyWith<$Res> {
  __$$AttendanceCheckSubmissionStatusImplCopyWithImpl(
    _$AttendanceCheckSubmissionStatusImpl _value,
    $Res Function(_$AttendanceCheckSubmissionStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? date = null,
  }) {
    return _then(
      _$AttendanceCheckSubmissionStatusImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceCheckSubmissionStatusImpl
    implements AttendanceCheckSubmissionStatus {
  const _$AttendanceCheckSubmissionStatusImpl(
    this.institutionId,
    this.classId,
    this.date,
  );

  @override
  final String institutionId;
  @override
  final String classId;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'AttendanceEvent.checkSubmissionStatus(institutionId: $institutionId, classId: $classId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceCheckSubmissionStatusImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, classId, date);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceCheckSubmissionStatusImplCopyWith<
    _$AttendanceCheckSubmissionStatusImpl
  >
  get copyWith =>
      __$$AttendanceCheckSubmissionStatusImplCopyWithImpl<
        _$AttendanceCheckSubmissionStatusImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) {
    return checkSubmissionStatus(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) {
    return checkSubmissionStatus?.call(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) {
    if (checkSubmissionStatus != null) {
      return checkSubmissionStatus(institutionId, classId, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) {
    return checkSubmissionStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) {
    return checkSubmissionStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) {
    if (checkSubmissionStatus != null) {
      return checkSubmissionStatus(this);
    }
    return orElse();
  }
}

abstract class AttendanceCheckSubmissionStatus implements AttendanceEvent {
  const factory AttendanceCheckSubmissionStatus(
    final String institutionId,
    final String classId,
    final DateTime date,
  ) = _$AttendanceCheckSubmissionStatusImpl;

  String get institutionId;
  String get classId;
  DateTime get date;

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceCheckSubmissionStatusImplCopyWith<
    _$AttendanceCheckSubmissionStatusImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceMarkStudentAttendanceImplCopyWith<$Res> {
  factory _$$AttendanceMarkStudentAttendanceImplCopyWith(
    _$AttendanceMarkStudentAttendanceImpl value,
    $Res Function(_$AttendanceMarkStudentAttendanceImpl) then,
  ) = __$$AttendanceMarkStudentAttendanceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String studentId, AttendanceStatus status, String? notes});
}

/// @nodoc
class __$$AttendanceMarkStudentAttendanceImplCopyWithImpl<$Res>
    extends
        _$AttendanceEventCopyWithImpl<
          $Res,
          _$AttendanceMarkStudentAttendanceImpl
        >
    implements _$$AttendanceMarkStudentAttendanceImplCopyWith<$Res> {
  __$$AttendanceMarkStudentAttendanceImplCopyWithImpl(
    _$AttendanceMarkStudentAttendanceImpl _value,
    $Res Function(_$AttendanceMarkStudentAttendanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$AttendanceMarkStudentAttendanceImpl(
        null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AttendanceStatus,
        freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceMarkStudentAttendanceImpl
    implements AttendanceMarkStudentAttendance {
  const _$AttendanceMarkStudentAttendanceImpl(
    this.studentId,
    this.status,
    this.notes,
  );

  @override
  final String studentId;
  @override
  final AttendanceStatus status;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AttendanceEvent.markStudentAttendance(studentId: $studentId, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceMarkStudentAttendanceImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, studentId, status, notes);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceMarkStudentAttendanceImplCopyWith<
    _$AttendanceMarkStudentAttendanceImpl
  >
  get copyWith =>
      __$$AttendanceMarkStudentAttendanceImplCopyWithImpl<
        _$AttendanceMarkStudentAttendanceImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) {
    return markStudentAttendance(studentId, status, notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) {
    return markStudentAttendance?.call(studentId, status, notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) {
    if (markStudentAttendance != null) {
      return markStudentAttendance(studentId, status, notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) {
    return markStudentAttendance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) {
    return markStudentAttendance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) {
    if (markStudentAttendance != null) {
      return markStudentAttendance(this);
    }
    return orElse();
  }
}

abstract class AttendanceMarkStudentAttendance implements AttendanceEvent {
  const factory AttendanceMarkStudentAttendance(
    final String studentId,
    final AttendanceStatus status,
    final String? notes,
  ) = _$AttendanceMarkStudentAttendanceImpl;

  String get studentId;
  AttendanceStatus get status;
  String? get notes;

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceMarkStudentAttendanceImplCopyWith<
    _$AttendanceMarkStudentAttendanceImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceClearAttendanceImplCopyWith<$Res> {
  factory _$$AttendanceClearAttendanceImplCopyWith(
    _$AttendanceClearAttendanceImpl value,
    $Res Function(_$AttendanceClearAttendanceImpl) then,
  ) = __$$AttendanceClearAttendanceImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttendanceClearAttendanceImplCopyWithImpl<$Res>
    extends _$AttendanceEventCopyWithImpl<$Res, _$AttendanceClearAttendanceImpl>
    implements _$$AttendanceClearAttendanceImplCopyWith<$Res> {
  __$$AttendanceClearAttendanceImplCopyWithImpl(
    _$AttendanceClearAttendanceImpl _value,
    $Res Function(_$AttendanceClearAttendanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttendanceClearAttendanceImpl implements AttendanceClearAttendance {
  const _$AttendanceClearAttendanceImpl();

  @override
  String toString() {
    return 'AttendanceEvent.clearAttendance()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceClearAttendanceImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadRoster,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )
    submitAttendance,
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    checkSubmissionStatus,
    required TResult Function(
      String studentId,
      AttendanceStatus status,
      String? notes,
    )
    markStudentAttendance,
    required TResult Function() clearAttendance,
  }) {
    return clearAttendance();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult? Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult? Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult? Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult? Function()? clearAttendance,
  }) {
    return clearAttendance?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadRoster,
    TResult Function(
      String institutionId,
      String classId,
      DateTime date,
      List<Attendance> attendanceRecords,
    )?
    submitAttendance,
    TResult Function(String institutionId, String classId, DateTime date)?
    checkSubmissionStatus,
    TResult Function(String studentId, AttendanceStatus status, String? notes)?
    markStudentAttendance,
    TResult Function()? clearAttendance,
    required TResult orElse(),
  }) {
    if (clearAttendance != null) {
      return clearAttendance();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceLoadRoster value) loadRoster,
    required TResult Function(AttendanceSubmitAttendance value)
    submitAttendance,
    required TResult Function(AttendanceCheckSubmissionStatus value)
    checkSubmissionStatus,
    required TResult Function(AttendanceMarkStudentAttendance value)
    markStudentAttendance,
    required TResult Function(AttendanceClearAttendance value) clearAttendance,
  }) {
    return clearAttendance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceLoadRoster value)? loadRoster,
    TResult? Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult? Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult? Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult? Function(AttendanceClearAttendance value)? clearAttendance,
  }) {
    return clearAttendance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceLoadRoster value)? loadRoster,
    TResult Function(AttendanceSubmitAttendance value)? submitAttendance,
    TResult Function(AttendanceCheckSubmissionStatus value)?
    checkSubmissionStatus,
    TResult Function(AttendanceMarkStudentAttendance value)?
    markStudentAttendance,
    TResult Function(AttendanceClearAttendance value)? clearAttendance,
    required TResult orElse(),
  }) {
    if (clearAttendance != null) {
      return clearAttendance(this);
    }
    return orElse();
  }
}

abstract class AttendanceClearAttendance implements AttendanceEvent {
  const factory AttendanceClearAttendance() = _$AttendanceClearAttendanceImpl;
}

/// @nodoc
mixin _$AttendanceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceStateCopyWith<$Res> {
  factory $AttendanceStateCopyWith(
    AttendanceState value,
    $Res Function(AttendanceState) then,
  ) = _$AttendanceStateCopyWithImpl<$Res, AttendanceState>;
}

/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res, $Val extends AttendanceState>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceState
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
    extends _$AttendanceStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AttendanceState.initial()';
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
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
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
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AttendanceState {
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
    extends _$AttendanceStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AttendanceState.loading()';
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
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
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
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AttendanceState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SubmittingImplCopyWith<$Res> {
  factory _$$SubmittingImplCopyWith(
    _$SubmittingImpl value,
    $Res Function(_$SubmittingImpl) then,
  ) = __$$SubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittingImplCopyWithImpl<$Res>
    extends _$AttendanceStateCopyWithImpl<$Res, _$SubmittingImpl>
    implements _$$SubmittingImplCopyWith<$Res> {
  __$$SubmittingImplCopyWithImpl(
    _$SubmittingImpl _value,
    $Res Function(_$SubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmittingImpl implements _Submitting {
  const _$SubmittingImpl();

  @override
  String toString() {
    return 'AttendanceState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _Submitting implements AttendanceState {
  const factory _Submitting() = _$SubmittingImpl;
}

/// @nodoc
abstract class _$$RosterLoadedImplCopyWith<$Res> {
  factory _$$RosterLoadedImplCopyWith(
    _$RosterLoadedImpl value,
    $Res Function(_$RosterLoadedImpl) then,
  ) = __$$RosterLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Student> students,
    List<Attendance> attendanceRecords,
    DateTime date,
    bool isSubmitted,
  });
}

/// @nodoc
class __$$RosterLoadedImplCopyWithImpl<$Res>
    extends _$AttendanceStateCopyWithImpl<$Res, _$RosterLoadedImpl>
    implements _$$RosterLoadedImplCopyWith<$Res> {
  __$$RosterLoadedImplCopyWithImpl(
    _$RosterLoadedImpl _value,
    $Res Function(_$RosterLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
    Object? attendanceRecords = null,
    Object? date = null,
    Object? isSubmitted = null,
  }) {
    return _then(
      _$RosterLoadedImpl(
        students: null == students
            ? _value._students
            : students // ignore: cast_nullable_to_non_nullable
                  as List<Student>,
        attendanceRecords: null == attendanceRecords
            ? _value._attendanceRecords
            : attendanceRecords // ignore: cast_nullable_to_non_nullable
                  as List<Attendance>,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isSubmitted: null == isSubmitted
            ? _value.isSubmitted
            : isSubmitted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RosterLoadedImpl implements _RosterLoaded {
  const _$RosterLoadedImpl({
    required final List<Student> students,
    required final List<Attendance> attendanceRecords,
    required this.date,
    required this.isSubmitted,
  }) : _students = students,
       _attendanceRecords = attendanceRecords;

  final List<Student> _students;
  @override
  List<Student> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  final List<Attendance> _attendanceRecords;
  @override
  List<Attendance> get attendanceRecords {
    if (_attendanceRecords is EqualUnmodifiableListView)
      return _attendanceRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceRecords);
  }

  @override
  final DateTime date;
  @override
  final bool isSubmitted;

  @override
  String toString() {
    return 'AttendanceState.rosterLoaded(students: $students, attendanceRecords: $attendanceRecords, date: $date, isSubmitted: $isSubmitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RosterLoadedImpl &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            const DeepCollectionEquality().equals(
              other._attendanceRecords,
              _attendanceRecords,
            ) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isSubmitted, isSubmitted) ||
                other.isSubmitted == isSubmitted));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_students),
    const DeepCollectionEquality().hash(_attendanceRecords),
    date,
    isSubmitted,
  );

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RosterLoadedImplCopyWith<_$RosterLoadedImpl> get copyWith =>
      __$$RosterLoadedImplCopyWithImpl<_$RosterLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return rosterLoaded(students, attendanceRecords, date, isSubmitted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return rosterLoaded?.call(students, attendanceRecords, date, isSubmitted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (rosterLoaded != null) {
      return rosterLoaded(students, attendanceRecords, date, isSubmitted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return rosterLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return rosterLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (rosterLoaded != null) {
      return rosterLoaded(this);
    }
    return orElse();
  }
}

abstract class _RosterLoaded implements AttendanceState {
  const factory _RosterLoaded({
    required final List<Student> students,
    required final List<Attendance> attendanceRecords,
    required final DateTime date,
    required final bool isSubmitted,
  }) = _$RosterLoadedImpl;

  List<Student> get students;
  List<Attendance> get attendanceRecords;
  DateTime get date;
  bool get isSubmitted;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RosterLoadedImplCopyWith<_$RosterLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittedImplCopyWith<$Res> {
  factory _$$SubmittedImplCopyWith(
    _$SubmittedImpl value,
    $Res Function(_$SubmittedImpl) then,
  ) = __$$SubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittedImplCopyWithImpl<$Res>
    extends _$AttendanceStateCopyWithImpl<$Res, _$SubmittedImpl>
    implements _$$SubmittedImplCopyWith<$Res> {
  __$$SubmittedImplCopyWithImpl(
    _$SubmittedImpl _value,
    $Res Function(_$SubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmittedImpl implements _Submitted {
  const _$SubmittedImpl();

  @override
  String toString() {
    return 'AttendanceState.submitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _Submitted implements AttendanceState {
  const factory _Submitted() = _$SubmittedImpl;
}

/// @nodoc
abstract class _$$SubmissionStatusCheckedImplCopyWith<$Res> {
  factory _$$SubmissionStatusCheckedImplCopyWith(
    _$SubmissionStatusCheckedImpl value,
    $Res Function(_$SubmissionStatusCheckedImpl) then,
  ) = __$$SubmissionStatusCheckedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isSubmitted});
}

/// @nodoc
class __$$SubmissionStatusCheckedImplCopyWithImpl<$Res>
    extends _$AttendanceStateCopyWithImpl<$Res, _$SubmissionStatusCheckedImpl>
    implements _$$SubmissionStatusCheckedImplCopyWith<$Res> {
  __$$SubmissionStatusCheckedImplCopyWithImpl(
    _$SubmissionStatusCheckedImpl _value,
    $Res Function(_$SubmissionStatusCheckedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isSubmitted = null}) {
    return _then(
      _$SubmissionStatusCheckedImpl(
        null == isSubmitted
            ? _value.isSubmitted
            : isSubmitted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SubmissionStatusCheckedImpl implements _SubmissionStatusChecked {
  const _$SubmissionStatusCheckedImpl(this.isSubmitted);

  @override
  final bool isSubmitted;

  @override
  String toString() {
    return 'AttendanceState.submissionStatusChecked(isSubmitted: $isSubmitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmissionStatusCheckedImpl &&
            (identical(other.isSubmitted, isSubmitted) ||
                other.isSubmitted == isSubmitted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSubmitted);

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmissionStatusCheckedImplCopyWith<_$SubmissionStatusCheckedImpl>
  get copyWith =>
      __$$SubmissionStatusCheckedImplCopyWithImpl<
        _$SubmissionStatusCheckedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return submissionStatusChecked(isSubmitted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return submissionStatusChecked?.call(isSubmitted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (submissionStatusChecked != null) {
      return submissionStatusChecked(isSubmitted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return submissionStatusChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return submissionStatusChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (submissionStatusChecked != null) {
      return submissionStatusChecked(this);
    }
    return orElse();
  }
}

abstract class _SubmissionStatusChecked implements AttendanceState {
  const factory _SubmissionStatusChecked(final bool isSubmitted) =
      _$SubmissionStatusCheckedImpl;

  bool get isSubmitted;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmissionStatusCheckedImplCopyWith<_$SubmissionStatusCheckedImpl>
  get copyWith => throw _privateConstructorUsedError;
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
    extends _$AttendanceStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceState
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
    return 'AttendanceState.error(failure: $failure)';
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

  /// Create a copy of AttendanceState
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
    required TResult Function() submitting,
    required TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )
    rosterLoaded,
    required TResult Function() submitted,
    required TResult Function(bool isSubmitted) submissionStatusChecked,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? submitting,
    TResult? Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult? Function()? submitted,
    TResult? Function(bool isSubmitted)? submissionStatusChecked,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? submitting,
    TResult Function(
      List<Student> students,
      List<Attendance> attendanceRecords,
      DateTime date,
      bool isSubmitted,
    )?
    rosterLoaded,
    TResult Function()? submitted,
    TResult Function(bool isSubmitted)? submissionStatusChecked,
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
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_RosterLoaded value) rosterLoaded,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmissionStatusChecked value)
    submissionStatusChecked,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_RosterLoaded value)? rosterLoaded,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_RosterLoaded value)? rosterLoaded,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmissionStatusChecked value)? submissionStatusChecked,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AttendanceState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

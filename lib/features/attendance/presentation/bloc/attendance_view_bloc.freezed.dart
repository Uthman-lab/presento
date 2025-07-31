// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_view_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AttendanceViewEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )
    loadAttendance,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceViewLoadAttendance value)
    loadAttendance,
    required TResult Function(AttendanceViewFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceViewFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceViewClearFilters value) clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult? Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult? Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceViewClearFilters value)? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceViewClearFilters value)? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceViewEventCopyWith<$Res> {
  factory $AttendanceViewEventCopyWith(
    AttendanceViewEvent value,
    $Res Function(AttendanceViewEvent) then,
  ) = _$AttendanceViewEventCopyWithImpl<$Res, AttendanceViewEvent>;
}

/// @nodoc
class _$AttendanceViewEventCopyWithImpl<$Res, $Val extends AttendanceViewEvent>
    implements $AttendanceViewEventCopyWith<$Res> {
  _$AttendanceViewEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AttendanceViewLoadAttendanceImplCopyWith<$Res> {
  factory _$$AttendanceViewLoadAttendanceImplCopyWith(
    _$AttendanceViewLoadAttendanceImpl value,
    $Res Function(_$AttendanceViewLoadAttendanceImpl) then,
  ) = __$$AttendanceViewLoadAttendanceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
  });
}

/// @nodoc
class __$$AttendanceViewLoadAttendanceImplCopyWithImpl<$Res>
    extends
        _$AttendanceViewEventCopyWithImpl<
          $Res,
          _$AttendanceViewLoadAttendanceImpl
        >
    implements _$$AttendanceViewLoadAttendanceImplCopyWith<$Res> {
  __$$AttendanceViewLoadAttendanceImplCopyWithImpl(
    _$AttendanceViewLoadAttendanceImpl _value,
    $Res Function(_$AttendanceViewLoadAttendanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(
      _$AttendanceViewLoadAttendanceImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceViewLoadAttendanceImpl
    implements AttendanceViewLoadAttendance {
  const _$AttendanceViewLoadAttendanceImpl(
    this.institutionId,
    this.classId,
    this.startDate,
    this.endDate,
  );

  @override
  final String institutionId;
  @override
  final String classId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'AttendanceViewEvent.loadAttendance(institutionId: $institutionId, classId: $classId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceViewLoadAttendanceImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, institutionId, classId, startDate, endDate);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceViewLoadAttendanceImplCopyWith<
    _$AttendanceViewLoadAttendanceImpl
  >
  get copyWith =>
      __$$AttendanceViewLoadAttendanceImplCopyWithImpl<
        _$AttendanceViewLoadAttendanceImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )
    loadAttendance,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) {
    return loadAttendance(institutionId, classId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return loadAttendance?.call(institutionId, classId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (loadAttendance != null) {
      return loadAttendance(institutionId, classId, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceViewLoadAttendance value)
    loadAttendance,
    required TResult Function(AttendanceViewFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceViewFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceViewClearFilters value) clearFilters,
  }) {
    return loadAttendance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult? Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult? Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceViewClearFilters value)? clearFilters,
  }) {
    return loadAttendance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceViewClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (loadAttendance != null) {
      return loadAttendance(this);
    }
    return orElse();
  }
}

abstract class AttendanceViewLoadAttendance implements AttendanceViewEvent {
  const factory AttendanceViewLoadAttendance(
    final String institutionId,
    final String classId,
    final DateTime startDate,
    final DateTime endDate,
  ) = _$AttendanceViewLoadAttendanceImpl;

  String get institutionId;
  String get classId;
  DateTime get startDate;
  DateTime get endDate;

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceViewLoadAttendanceImplCopyWith<
    _$AttendanceViewLoadAttendanceImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceViewFilterByDateRangeImplCopyWith<$Res> {
  factory _$$AttendanceViewFilterByDateRangeImplCopyWith(
    _$AttendanceViewFilterByDateRangeImpl value,
    $Res Function(_$AttendanceViewFilterByDateRangeImpl) then,
  ) = __$$AttendanceViewFilterByDateRangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$AttendanceViewFilterByDateRangeImplCopyWithImpl<$Res>
    extends
        _$AttendanceViewEventCopyWithImpl<
          $Res,
          _$AttendanceViewFilterByDateRangeImpl
        >
    implements _$$AttendanceViewFilterByDateRangeImplCopyWith<$Res> {
  __$$AttendanceViewFilterByDateRangeImplCopyWithImpl(
    _$AttendanceViewFilterByDateRangeImpl _value,
    $Res Function(_$AttendanceViewFilterByDateRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = null, Object? endDate = null}) {
    return _then(
      _$AttendanceViewFilterByDateRangeImpl(
        null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceViewFilterByDateRangeImpl
    implements AttendanceViewFilterByDateRange {
  const _$AttendanceViewFilterByDateRangeImpl(this.startDate, this.endDate);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'AttendanceViewEvent.filterByDateRange(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceViewFilterByDateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceViewFilterByDateRangeImplCopyWith<
    _$AttendanceViewFilterByDateRangeImpl
  >
  get copyWith =>
      __$$AttendanceViewFilterByDateRangeImplCopyWithImpl<
        _$AttendanceViewFilterByDateRangeImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )
    loadAttendance,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) {
    return filterByDateRange(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return filterByDateRange?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByDateRange != null) {
      return filterByDateRange(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceViewLoadAttendance value)
    loadAttendance,
    required TResult Function(AttendanceViewFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceViewFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceViewClearFilters value) clearFilters,
  }) {
    return filterByDateRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult? Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult? Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceViewClearFilters value)? clearFilters,
  }) {
    return filterByDateRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceViewClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByDateRange != null) {
      return filterByDateRange(this);
    }
    return orElse();
  }
}

abstract class AttendanceViewFilterByDateRange implements AttendanceViewEvent {
  const factory AttendanceViewFilterByDateRange(
    final DateTime startDate,
    final DateTime endDate,
  ) = _$AttendanceViewFilterByDateRangeImpl;

  DateTime get startDate;
  DateTime get endDate;

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceViewFilterByDateRangeImplCopyWith<
    _$AttendanceViewFilterByDateRangeImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceViewFilterByStudentImplCopyWith<$Res> {
  factory _$$AttendanceViewFilterByStudentImplCopyWith(
    _$AttendanceViewFilterByStudentImpl value,
    $Res Function(_$AttendanceViewFilterByStudentImpl) then,
  ) = __$$AttendanceViewFilterByStudentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String studentId});
}

/// @nodoc
class __$$AttendanceViewFilterByStudentImplCopyWithImpl<$Res>
    extends
        _$AttendanceViewEventCopyWithImpl<
          $Res,
          _$AttendanceViewFilterByStudentImpl
        >
    implements _$$AttendanceViewFilterByStudentImplCopyWith<$Res> {
  __$$AttendanceViewFilterByStudentImplCopyWithImpl(
    _$AttendanceViewFilterByStudentImpl _value,
    $Res Function(_$AttendanceViewFilterByStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? studentId = null}) {
    return _then(
      _$AttendanceViewFilterByStudentImpl(
        null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceViewFilterByStudentImpl
    implements AttendanceViewFilterByStudent {
  const _$AttendanceViewFilterByStudentImpl(this.studentId);

  @override
  final String studentId;

  @override
  String toString() {
    return 'AttendanceViewEvent.filterByStudent(studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceViewFilterByStudentImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, studentId);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceViewFilterByStudentImplCopyWith<
    _$AttendanceViewFilterByStudentImpl
  >
  get copyWith =>
      __$$AttendanceViewFilterByStudentImplCopyWithImpl<
        _$AttendanceViewFilterByStudentImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )
    loadAttendance,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) {
    return filterByStudent(studentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return filterByStudent?.call(studentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByStudent != null) {
      return filterByStudent(studentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceViewLoadAttendance value)
    loadAttendance,
    required TResult Function(AttendanceViewFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceViewFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceViewClearFilters value) clearFilters,
  }) {
    return filterByStudent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult? Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult? Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceViewClearFilters value)? clearFilters,
  }) {
    return filterByStudent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceViewClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByStudent != null) {
      return filterByStudent(this);
    }
    return orElse();
  }
}

abstract class AttendanceViewFilterByStudent implements AttendanceViewEvent {
  const factory AttendanceViewFilterByStudent(final String studentId) =
      _$AttendanceViewFilterByStudentImpl;

  String get studentId;

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceViewFilterByStudentImplCopyWith<
    _$AttendanceViewFilterByStudentImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceViewClearFiltersImplCopyWith<$Res> {
  factory _$$AttendanceViewClearFiltersImplCopyWith(
    _$AttendanceViewClearFiltersImpl value,
    $Res Function(_$AttendanceViewClearFiltersImpl) then,
  ) = __$$AttendanceViewClearFiltersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttendanceViewClearFiltersImplCopyWithImpl<$Res>
    extends
        _$AttendanceViewEventCopyWithImpl<
          $Res,
          _$AttendanceViewClearFiltersImpl
        >
    implements _$$AttendanceViewClearFiltersImplCopyWith<$Res> {
  __$$AttendanceViewClearFiltersImplCopyWithImpl(
    _$AttendanceViewClearFiltersImpl _value,
    $Res Function(_$AttendanceViewClearFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttendanceViewClearFiltersImpl implements AttendanceViewClearFilters {
  const _$AttendanceViewClearFiltersImpl();

  @override
  String toString() {
    return 'AttendanceViewEvent.clearFilters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceViewClearFiltersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )
    loadAttendance,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) {
    return clearFilters();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return clearFilters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
    )?
    loadAttendance,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceViewLoadAttendance value)
    loadAttendance,
    required TResult Function(AttendanceViewFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceViewFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceViewClearFilters value) clearFilters,
  }) {
    return clearFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult? Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult? Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceViewClearFilters value)? clearFilters,
  }) {
    return clearFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceViewLoadAttendance value)? loadAttendance,
    TResult Function(AttendanceViewFilterByDateRange value)? filterByDateRange,
    TResult Function(AttendanceViewFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceViewClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters(this);
    }
    return orElse();
  }
}

abstract class AttendanceViewClearFilters implements AttendanceViewEvent {
  const factory AttendanceViewClearFilters() = _$AttendanceViewClearFiltersImpl;
}

/// @nodoc
mixin _$AttendanceViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )
    attendanceLoaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_AttendanceLoaded value) attendanceLoaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceViewStateCopyWith<$Res> {
  factory $AttendanceViewStateCopyWith(
    AttendanceViewState value,
    $Res Function(AttendanceViewState) then,
  ) = _$AttendanceViewStateCopyWithImpl<$Res, AttendanceViewState>;
}

/// @nodoc
class _$AttendanceViewStateCopyWithImpl<$Res, $Val extends AttendanceViewState>
    implements $AttendanceViewStateCopyWith<$Res> {
  _$AttendanceViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceViewState
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
    extends _$AttendanceViewStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AttendanceViewState.initial()';
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
    required TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )
    attendanceLoaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
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
    required TResult Function(_AttendanceLoaded value) attendanceLoaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AttendanceViewState {
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
    extends _$AttendanceViewStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AttendanceViewState.loading()';
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
    required TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )
    attendanceLoaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
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
    required TResult Function(_AttendanceLoaded value) attendanceLoaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AttendanceViewState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$AttendanceLoadedImplCopyWith<$Res> {
  factory _$$AttendanceLoadedImplCopyWith(
    _$AttendanceLoadedImpl value,
    $Res Function(_$AttendanceLoadedImpl) then,
  ) = __$$AttendanceLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<AttendanceViewItem> viewData,
    AttendanceViewStatistics statistics,
    DateTime startDate,
    DateTime endDate,
  });
}

/// @nodoc
class __$$AttendanceLoadedImplCopyWithImpl<$Res>
    extends _$AttendanceViewStateCopyWithImpl<$Res, _$AttendanceLoadedImpl>
    implements _$$AttendanceLoadedImplCopyWith<$Res> {
  __$$AttendanceLoadedImplCopyWithImpl(
    _$AttendanceLoadedImpl _value,
    $Res Function(_$AttendanceLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewData = null,
    Object? statistics = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(
      _$AttendanceLoadedImpl(
        viewData: null == viewData
            ? _value._viewData
            : viewData // ignore: cast_nullable_to_non_nullable
                  as List<AttendanceViewItem>,
        statistics: null == statistics
            ? _value.statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as AttendanceViewStatistics,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceLoadedImpl implements _AttendanceLoaded {
  const _$AttendanceLoadedImpl({
    required final List<AttendanceViewItem> viewData,
    required this.statistics,
    required this.startDate,
    required this.endDate,
  }) : _viewData = viewData;

  final List<AttendanceViewItem> _viewData;
  @override
  List<AttendanceViewItem> get viewData {
    if (_viewData is EqualUnmodifiableListView) return _viewData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_viewData);
  }

  @override
  final AttendanceViewStatistics statistics;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'AttendanceViewState.attendanceLoaded(viewData: $viewData, statistics: $statistics, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceLoadedImpl &&
            const DeepCollectionEquality().equals(other._viewData, _viewData) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_viewData),
    statistics,
    startDate,
    endDate,
  );

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceLoadedImplCopyWith<_$AttendanceLoadedImpl> get copyWith =>
      __$$AttendanceLoadedImplCopyWithImpl<_$AttendanceLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )
    attendanceLoaded,
    required TResult Function(Failure failure) error,
  }) {
    return attendanceLoaded(viewData, statistics, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult? Function(Failure failure)? error,
  }) {
    return attendanceLoaded?.call(viewData, statistics, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (attendanceLoaded != null) {
      return attendanceLoaded(viewData, statistics, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_AttendanceLoaded value) attendanceLoaded,
    required TResult Function(_Error value) error,
  }) {
    return attendanceLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return attendanceLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (attendanceLoaded != null) {
      return attendanceLoaded(this);
    }
    return orElse();
  }
}

abstract class _AttendanceLoaded implements AttendanceViewState {
  const factory _AttendanceLoaded({
    required final List<AttendanceViewItem> viewData,
    required final AttendanceViewStatistics statistics,
    required final DateTime startDate,
    required final DateTime endDate,
  }) = _$AttendanceLoadedImpl;

  List<AttendanceViewItem> get viewData;
  AttendanceViewStatistics get statistics;
  DateTime get startDate;
  DateTime get endDate;

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceLoadedImplCopyWith<_$AttendanceLoadedImpl> get copyWith =>
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
    extends _$AttendanceViewStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceViewState
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
    return 'AttendanceViewState.error(failure: $failure)';
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

  /// Create a copy of AttendanceViewState
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
    required TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )
    attendanceLoaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceViewItem> viewData,
      AttendanceViewStatistics statistics,
      DateTime startDate,
      DateTime endDate,
    )?
    attendanceLoaded,
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
    required TResult Function(_AttendanceLoaded value) attendanceLoaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_AttendanceLoaded value)? attendanceLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AttendanceViewState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of AttendanceViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

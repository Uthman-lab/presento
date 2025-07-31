// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_report_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AttendanceReportEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadReport,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceReportLoadReport value) loadReport,
    required TResult Function(AttendanceReportFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceReportFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceReportClearFilters value) clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceReportLoadReport value)? loadReport,
    TResult? Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult? Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceReportClearFilters value)? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceReportLoadReport value)? loadReport,
    TResult Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceReportClearFilters value)? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceReportEventCopyWith<$Res> {
  factory $AttendanceReportEventCopyWith(
    AttendanceReportEvent value,
    $Res Function(AttendanceReportEvent) then,
  ) = _$AttendanceReportEventCopyWithImpl<$Res, AttendanceReportEvent>;
}

/// @nodoc
class _$AttendanceReportEventCopyWithImpl<
  $Res,
  $Val extends AttendanceReportEvent
>
    implements $AttendanceReportEventCopyWith<$Res> {
  _$AttendanceReportEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AttendanceReportLoadReportImplCopyWith<$Res> {
  factory _$$AttendanceReportLoadReportImplCopyWith(
    _$AttendanceReportLoadReportImpl value,
    $Res Function(_$AttendanceReportLoadReportImpl) then,
  ) = __$$AttendanceReportLoadReportImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String institutionId, String classId, DateTime date});
}

/// @nodoc
class __$$AttendanceReportLoadReportImplCopyWithImpl<$Res>
    extends
        _$AttendanceReportEventCopyWithImpl<
          $Res,
          _$AttendanceReportLoadReportImpl
        >
    implements _$$AttendanceReportLoadReportImplCopyWith<$Res> {
  __$$AttendanceReportLoadReportImplCopyWithImpl(
    _$AttendanceReportLoadReportImpl _value,
    $Res Function(_$AttendanceReportLoadReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? date = null,
  }) {
    return _then(
      _$AttendanceReportLoadReportImpl(
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

class _$AttendanceReportLoadReportImpl implements AttendanceReportLoadReport {
  const _$AttendanceReportLoadReportImpl(
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
    return 'AttendanceReportEvent.loadReport(institutionId: $institutionId, classId: $classId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceReportLoadReportImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, classId, date);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceReportLoadReportImplCopyWith<_$AttendanceReportLoadReportImpl>
  get copyWith =>
      __$$AttendanceReportLoadReportImplCopyWithImpl<
        _$AttendanceReportLoadReportImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadReport,
    required TResult Function(DateTime startDate, DateTime endDate)
    filterByDateRange,
    required TResult Function(String studentId) filterByStudent,
    required TResult Function() clearFilters,
  }) {
    return loadReport(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return loadReport?.call(institutionId, classId, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult Function(String studentId)? filterByStudent,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (loadReport != null) {
      return loadReport(institutionId, classId, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AttendanceReportLoadReport value) loadReport,
    required TResult Function(AttendanceReportFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceReportFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceReportClearFilters value) clearFilters,
  }) {
    return loadReport(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceReportLoadReport value)? loadReport,
    TResult? Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult? Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceReportClearFilters value)? clearFilters,
  }) {
    return loadReport?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceReportLoadReport value)? loadReport,
    TResult Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceReportClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (loadReport != null) {
      return loadReport(this);
    }
    return orElse();
  }
}

abstract class AttendanceReportLoadReport implements AttendanceReportEvent {
  const factory AttendanceReportLoadReport(
    final String institutionId,
    final String classId,
    final DateTime date,
  ) = _$AttendanceReportLoadReportImpl;

  String get institutionId;
  String get classId;
  DateTime get date;

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceReportLoadReportImplCopyWith<_$AttendanceReportLoadReportImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceReportFilterByDateRangeImplCopyWith<$Res> {
  factory _$$AttendanceReportFilterByDateRangeImplCopyWith(
    _$AttendanceReportFilterByDateRangeImpl value,
    $Res Function(_$AttendanceReportFilterByDateRangeImpl) then,
  ) = __$$AttendanceReportFilterByDateRangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$AttendanceReportFilterByDateRangeImplCopyWithImpl<$Res>
    extends
        _$AttendanceReportEventCopyWithImpl<
          $Res,
          _$AttendanceReportFilterByDateRangeImpl
        >
    implements _$$AttendanceReportFilterByDateRangeImplCopyWith<$Res> {
  __$$AttendanceReportFilterByDateRangeImplCopyWithImpl(
    _$AttendanceReportFilterByDateRangeImpl _value,
    $Res Function(_$AttendanceReportFilterByDateRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = null, Object? endDate = null}) {
    return _then(
      _$AttendanceReportFilterByDateRangeImpl(
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

class _$AttendanceReportFilterByDateRangeImpl
    implements AttendanceReportFilterByDateRange {
  const _$AttendanceReportFilterByDateRangeImpl(this.startDate, this.endDate);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'AttendanceReportEvent.filterByDateRange(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceReportFilterByDateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceReportFilterByDateRangeImplCopyWith<
    _$AttendanceReportFilterByDateRangeImpl
  >
  get copyWith =>
      __$$AttendanceReportFilterByDateRangeImplCopyWithImpl<
        _$AttendanceReportFilterByDateRangeImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadReport,
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
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return filterByDateRange?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadReport,
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
    required TResult Function(AttendanceReportLoadReport value) loadReport,
    required TResult Function(AttendanceReportFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceReportFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceReportClearFilters value) clearFilters,
  }) {
    return filterByDateRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceReportLoadReport value)? loadReport,
    TResult? Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult? Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceReportClearFilters value)? clearFilters,
  }) {
    return filterByDateRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceReportLoadReport value)? loadReport,
    TResult Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceReportClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByDateRange != null) {
      return filterByDateRange(this);
    }
    return orElse();
  }
}

abstract class AttendanceReportFilterByDateRange
    implements AttendanceReportEvent {
  const factory AttendanceReportFilterByDateRange(
    final DateTime startDate,
    final DateTime endDate,
  ) = _$AttendanceReportFilterByDateRangeImpl;

  DateTime get startDate;
  DateTime get endDate;

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceReportFilterByDateRangeImplCopyWith<
    _$AttendanceReportFilterByDateRangeImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceReportFilterByStudentImplCopyWith<$Res> {
  factory _$$AttendanceReportFilterByStudentImplCopyWith(
    _$AttendanceReportFilterByStudentImpl value,
    $Res Function(_$AttendanceReportFilterByStudentImpl) then,
  ) = __$$AttendanceReportFilterByStudentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String studentId});
}

/// @nodoc
class __$$AttendanceReportFilterByStudentImplCopyWithImpl<$Res>
    extends
        _$AttendanceReportEventCopyWithImpl<
          $Res,
          _$AttendanceReportFilterByStudentImpl
        >
    implements _$$AttendanceReportFilterByStudentImplCopyWith<$Res> {
  __$$AttendanceReportFilterByStudentImplCopyWithImpl(
    _$AttendanceReportFilterByStudentImpl _value,
    $Res Function(_$AttendanceReportFilterByStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? studentId = null}) {
    return _then(
      _$AttendanceReportFilterByStudentImpl(
        null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AttendanceReportFilterByStudentImpl
    implements AttendanceReportFilterByStudent {
  const _$AttendanceReportFilterByStudentImpl(this.studentId);

  @override
  final String studentId;

  @override
  String toString() {
    return 'AttendanceReportEvent.filterByStudent(studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceReportFilterByStudentImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, studentId);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceReportFilterByStudentImplCopyWith<
    _$AttendanceReportFilterByStudentImpl
  >
  get copyWith =>
      __$$AttendanceReportFilterByStudentImplCopyWithImpl<
        _$AttendanceReportFilterByStudentImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime date,
    )
    loadReport,
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
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return filterByStudent?.call(studentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadReport,
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
    required TResult Function(AttendanceReportLoadReport value) loadReport,
    required TResult Function(AttendanceReportFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceReportFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceReportClearFilters value) clearFilters,
  }) {
    return filterByStudent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceReportLoadReport value)? loadReport,
    TResult? Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult? Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceReportClearFilters value)? clearFilters,
  }) {
    return filterByStudent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceReportLoadReport value)? loadReport,
    TResult Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceReportClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByStudent != null) {
      return filterByStudent(this);
    }
    return orElse();
  }
}

abstract class AttendanceReportFilterByStudent
    implements AttendanceReportEvent {
  const factory AttendanceReportFilterByStudent(final String studentId) =
      _$AttendanceReportFilterByStudentImpl;

  String get studentId;

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceReportFilterByStudentImplCopyWith<
    _$AttendanceReportFilterByStudentImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttendanceReportClearFiltersImplCopyWith<$Res> {
  factory _$$AttendanceReportClearFiltersImplCopyWith(
    _$AttendanceReportClearFiltersImpl value,
    $Res Function(_$AttendanceReportClearFiltersImpl) then,
  ) = __$$AttendanceReportClearFiltersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttendanceReportClearFiltersImplCopyWithImpl<$Res>
    extends
        _$AttendanceReportEventCopyWithImpl<
          $Res,
          _$AttendanceReportClearFiltersImpl
        >
    implements _$$AttendanceReportClearFiltersImplCopyWith<$Res> {
  __$$AttendanceReportClearFiltersImplCopyWithImpl(
    _$AttendanceReportClearFiltersImpl _value,
    $Res Function(_$AttendanceReportClearFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttendanceReportClearFiltersImpl
    implements AttendanceReportClearFilters {
  const _$AttendanceReportClearFiltersImpl();

  @override
  String toString() {
    return 'AttendanceReportEvent.clearFilters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceReportClearFiltersImpl);
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
    loadReport,
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
    TResult? Function(String institutionId, String classId, DateTime date)?
    loadReport,
    TResult? Function(DateTime startDate, DateTime endDate)? filterByDateRange,
    TResult? Function(String studentId)? filterByStudent,
    TResult? Function()? clearFilters,
  }) {
    return clearFilters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId, String classId, DateTime date)?
    loadReport,
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
    required TResult Function(AttendanceReportLoadReport value) loadReport,
    required TResult Function(AttendanceReportFilterByDateRange value)
    filterByDateRange,
    required TResult Function(AttendanceReportFilterByStudent value)
    filterByStudent,
    required TResult Function(AttendanceReportClearFilters value) clearFilters,
  }) {
    return clearFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AttendanceReportLoadReport value)? loadReport,
    TResult? Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult? Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult? Function(AttendanceReportClearFilters value)? clearFilters,
  }) {
    return clearFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AttendanceReportLoadReport value)? loadReport,
    TResult Function(AttendanceReportFilterByDateRange value)?
    filterByDateRange,
    TResult Function(AttendanceReportFilterByStudent value)? filterByStudent,
    TResult Function(AttendanceReportClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters(this);
    }
    return orElse();
  }
}

abstract class AttendanceReportClearFilters implements AttendanceReportEvent {
  const factory AttendanceReportClearFilters() =
      _$AttendanceReportClearFiltersImpl;
}

/// @nodoc
mixin _$AttendanceReportState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )
    reportLoaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReportLoaded value) reportLoaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReportLoaded value)? reportLoaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReportLoaded value)? reportLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceReportStateCopyWith<$Res> {
  factory $AttendanceReportStateCopyWith(
    AttendanceReportState value,
    $Res Function(AttendanceReportState) then,
  ) = _$AttendanceReportStateCopyWithImpl<$Res, AttendanceReportState>;
}

/// @nodoc
class _$AttendanceReportStateCopyWithImpl<
  $Res,
  $Val extends AttendanceReportState
>
    implements $AttendanceReportStateCopyWith<$Res> {
  _$AttendanceReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceReportState
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
    extends _$AttendanceReportStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AttendanceReportState.initial()';
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
    required TResult Function(_ReportLoaded value) reportLoaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReportLoaded value)? reportLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReportLoaded value)? reportLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AttendanceReportState {
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
    extends _$AttendanceReportStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AttendanceReportState.loading()';
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
    required TResult Function(_ReportLoaded value) reportLoaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReportLoaded value)? reportLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReportLoaded value)? reportLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AttendanceReportState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ReportLoadedImplCopyWith<$Res> {
  factory _$$ReportLoadedImplCopyWith(
    _$ReportLoadedImpl value,
    $Res Function(_$ReportLoadedImpl) then,
  ) = __$$ReportLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<AttendanceReportItem> reportData,
    AttendanceStatistics statistics,
    DateTime date,
  });
}

/// @nodoc
class __$$ReportLoadedImplCopyWithImpl<$Res>
    extends _$AttendanceReportStateCopyWithImpl<$Res, _$ReportLoadedImpl>
    implements _$$ReportLoadedImplCopyWith<$Res> {
  __$$ReportLoadedImplCopyWithImpl(
    _$ReportLoadedImpl _value,
    $Res Function(_$ReportLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportData = null,
    Object? statistics = null,
    Object? date = null,
  }) {
    return _then(
      _$ReportLoadedImpl(
        reportData: null == reportData
            ? _value._reportData
            : reportData // ignore: cast_nullable_to_non_nullable
                  as List<AttendanceReportItem>,
        statistics: null == statistics
            ? _value.statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as AttendanceStatistics,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ReportLoadedImpl implements _ReportLoaded {
  const _$ReportLoadedImpl({
    required final List<AttendanceReportItem> reportData,
    required this.statistics,
    required this.date,
  }) : _reportData = reportData;

  final List<AttendanceReportItem> _reportData;
  @override
  List<AttendanceReportItem> get reportData {
    if (_reportData is EqualUnmodifiableListView) return _reportData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reportData);
  }

  @override
  final AttendanceStatistics statistics;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'AttendanceReportState.reportLoaded(reportData: $reportData, statistics: $statistics, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._reportData,
              _reportData,
            ) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_reportData),
    statistics,
    date,
  );

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportLoadedImplCopyWith<_$ReportLoadedImpl> get copyWith =>
      __$$ReportLoadedImplCopyWithImpl<_$ReportLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )
    reportLoaded,
    required TResult Function(Failure failure) error,
  }) {
    return reportLoaded(reportData, statistics, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
    TResult? Function(Failure failure)? error,
  }) {
    return reportLoaded?.call(reportData, statistics, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (reportLoaded != null) {
      return reportLoaded(reportData, statistics, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReportLoaded value) reportLoaded,
    required TResult Function(_Error value) error,
  }) {
    return reportLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReportLoaded value)? reportLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return reportLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReportLoaded value)? reportLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (reportLoaded != null) {
      return reportLoaded(this);
    }
    return orElse();
  }
}

abstract class _ReportLoaded implements AttendanceReportState {
  const factory _ReportLoaded({
    required final List<AttendanceReportItem> reportData,
    required final AttendanceStatistics statistics,
    required final DateTime date,
  }) = _$ReportLoadedImpl;

  List<AttendanceReportItem> get reportData;
  AttendanceStatistics get statistics;
  DateTime get date;

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportLoadedImplCopyWith<_$ReportLoadedImpl> get copyWith =>
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
    extends _$AttendanceReportStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceReportState
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
    return 'AttendanceReportState.error(failure: $failure)';
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

  /// Create a copy of AttendanceReportState
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
      List<AttendanceReportItem> reportData,
      AttendanceStatistics statistics,
      DateTime date,
    )?
    reportLoaded,
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
    required TResult Function(_ReportLoaded value) reportLoaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReportLoaded value)? reportLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReportLoaded value)? reportLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AttendanceReportState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of AttendanceReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

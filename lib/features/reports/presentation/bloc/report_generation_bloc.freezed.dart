// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_generation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReportGenerationEvent {
  String get institutionId => throw _privateConstructorUsedError;
  String get classId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )
    generateReport,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )?
    generateReport,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )?
    generateReport,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReportGenerationGenerateReport value)
    generateReport,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReportGenerationGenerateReport value)? generateReport,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReportGenerationGenerateReport value)? generateReport,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ReportGenerationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportGenerationEventCopyWith<ReportGenerationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportGenerationEventCopyWith<$Res> {
  factory $ReportGenerationEventCopyWith(
    ReportGenerationEvent value,
    $Res Function(ReportGenerationEvent) then,
  ) = _$ReportGenerationEventCopyWithImpl<$Res, ReportGenerationEvent>;
  @useResult
  $Res call({
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
    String format,
  });
}

/// @nodoc
class _$ReportGenerationEventCopyWithImpl<
  $Res,
  $Val extends ReportGenerationEvent
>
    implements $ReportGenerationEventCopyWith<$Res> {
  _$ReportGenerationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportGenerationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? format = null,
  }) {
    return _then(
      _value.copyWith(
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            classId: null == classId
                ? _value.classId
                : classId // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            format: null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportGenerationGenerateReportImplCopyWith<$Res>
    implements $ReportGenerationEventCopyWith<$Res> {
  factory _$$ReportGenerationGenerateReportImplCopyWith(
    _$ReportGenerationGenerateReportImpl value,
    $Res Function(_$ReportGenerationGenerateReportImpl) then,
  ) = __$$ReportGenerationGenerateReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String institutionId,
    String classId,
    DateTime startDate,
    DateTime endDate,
    String format,
  });
}

/// @nodoc
class __$$ReportGenerationGenerateReportImplCopyWithImpl<$Res>
    extends
        _$ReportGenerationEventCopyWithImpl<
          $Res,
          _$ReportGenerationGenerateReportImpl
        >
    implements _$$ReportGenerationGenerateReportImplCopyWith<$Res> {
  __$$ReportGenerationGenerateReportImplCopyWithImpl(
    _$ReportGenerationGenerateReportImpl _value,
    $Res Function(_$ReportGenerationGenerateReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportGenerationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? classId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? format = null,
  }) {
    return _then(
      _$ReportGenerationGenerateReportImpl(
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        classId: null == classId
            ? _value.classId
            : classId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        format: null == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ReportGenerationGenerateReportImpl
    implements ReportGenerationGenerateReport {
  const _$ReportGenerationGenerateReportImpl({
    required this.institutionId,
    required this.classId,
    required this.startDate,
    required this.endDate,
    required this.format,
  });

  @override
  final String institutionId;
  @override
  final String classId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String format;

  @override
  String toString() {
    return 'ReportGenerationEvent.generateReport(institutionId: $institutionId, classId: $classId, startDate: $startDate, endDate: $endDate, format: $format)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportGenerationGenerateReportImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.format, format) || other.format == format));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    institutionId,
    classId,
    startDate,
    endDate,
    format,
  );

  /// Create a copy of ReportGenerationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportGenerationGenerateReportImplCopyWith<
    _$ReportGenerationGenerateReportImpl
  >
  get copyWith =>
      __$$ReportGenerationGenerateReportImplCopyWithImpl<
        _$ReportGenerationGenerateReportImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )
    generateReport,
  }) {
    return generateReport(institutionId, classId, startDate, endDate, format);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )?
    generateReport,
  }) {
    return generateReport?.call(
      institutionId,
      classId,
      startDate,
      endDate,
      format,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String institutionId,
      String classId,
      DateTime startDate,
      DateTime endDate,
      String format,
    )?
    generateReport,
    required TResult orElse(),
  }) {
    if (generateReport != null) {
      return generateReport(institutionId, classId, startDate, endDate, format);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReportGenerationGenerateReport value)
    generateReport,
  }) {
    return generateReport(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReportGenerationGenerateReport value)? generateReport,
  }) {
    return generateReport?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReportGenerationGenerateReport value)? generateReport,
    required TResult orElse(),
  }) {
    if (generateReport != null) {
      return generateReport(this);
    }
    return orElse();
  }
}

abstract class ReportGenerationGenerateReport implements ReportGenerationEvent {
  const factory ReportGenerationGenerateReport({
    required final String institutionId,
    required final String classId,
    required final DateTime startDate,
    required final DateTime endDate,
    required final String format,
  }) = _$ReportGenerationGenerateReportImpl;

  @override
  String get institutionId;
  @override
  String get classId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get format;

  /// Create a copy of ReportGenerationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportGenerationGenerateReportImplCopyWith<
    _$ReportGenerationGenerateReportImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReportGenerationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() generating,
    required TResult Function(String data, String fileName) reportGenerated,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? generating,
    TResult? Function(String data, String fileName)? reportGenerated,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? generating,
    TResult Function(String data, String fileName)? reportGenerated,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Generating value) generating,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Generating value)? generating,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportGenerationStateCopyWith<$Res> {
  factory $ReportGenerationStateCopyWith(
    ReportGenerationState value,
    $Res Function(ReportGenerationState) then,
  ) = _$ReportGenerationStateCopyWithImpl<$Res, ReportGenerationState>;
}

/// @nodoc
class _$ReportGenerationStateCopyWithImpl<
  $Res,
  $Val extends ReportGenerationState
>
    implements $ReportGenerationStateCopyWith<$Res> {
  _$ReportGenerationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportGenerationState
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
    extends _$ReportGenerationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ReportGenerationState.initial()';
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
    required TResult Function() generating,
    required TResult Function(String data, String fileName) reportGenerated,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? generating,
    TResult? Function(String data, String fileName)? reportGenerated,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? generating,
    TResult Function(String data, String fileName)? reportGenerated,
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
    required TResult Function(_Generating value) generating,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Generating value)? generating,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ReportGenerationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GeneratingImplCopyWith<$Res> {
  factory _$$GeneratingImplCopyWith(
    _$GeneratingImpl value,
    $Res Function(_$GeneratingImpl) then,
  ) = __$$GeneratingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GeneratingImplCopyWithImpl<$Res>
    extends _$ReportGenerationStateCopyWithImpl<$Res, _$GeneratingImpl>
    implements _$$GeneratingImplCopyWith<$Res> {
  __$$GeneratingImplCopyWithImpl(
    _$GeneratingImpl _value,
    $Res Function(_$GeneratingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GeneratingImpl implements _Generating {
  const _$GeneratingImpl();

  @override
  String toString() {
    return 'ReportGenerationState.generating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GeneratingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() generating,
    required TResult Function(String data, String fileName) reportGenerated,
    required TResult Function(Failure failure) error,
  }) {
    return generating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? generating,
    TResult? Function(String data, String fileName)? reportGenerated,
    TResult? Function(Failure failure)? error,
  }) {
    return generating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? generating,
    TResult Function(String data, String fileName)? reportGenerated,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Generating value) generating,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return generating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return generating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Generating value)? generating,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(this);
    }
    return orElse();
  }
}

abstract class _Generating implements ReportGenerationState {
  const factory _Generating() = _$GeneratingImpl;
}

/// @nodoc
abstract class _$$ReportGeneratedImplCopyWith<$Res> {
  factory _$$ReportGeneratedImplCopyWith(
    _$ReportGeneratedImpl value,
    $Res Function(_$ReportGeneratedImpl) then,
  ) = __$$ReportGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String data, String fileName});
}

/// @nodoc
class __$$ReportGeneratedImplCopyWithImpl<$Res>
    extends _$ReportGenerationStateCopyWithImpl<$Res, _$ReportGeneratedImpl>
    implements _$$ReportGeneratedImplCopyWith<$Res> {
  __$$ReportGeneratedImplCopyWithImpl(
    _$ReportGeneratedImpl _value,
    $Res Function(_$ReportGeneratedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null, Object? fileName = null}) {
    return _then(
      _$ReportGeneratedImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ReportGeneratedImpl implements _ReportGenerated {
  const _$ReportGeneratedImpl({required this.data, required this.fileName});

  @override
  final String data;
  @override
  final String fileName;

  @override
  String toString() {
    return 'ReportGenerationState.reportGenerated(data: $data, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportGeneratedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, fileName);

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportGeneratedImplCopyWith<_$ReportGeneratedImpl> get copyWith =>
      __$$ReportGeneratedImplCopyWithImpl<_$ReportGeneratedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() generating,
    required TResult Function(String data, String fileName) reportGenerated,
    required TResult Function(Failure failure) error,
  }) {
    return reportGenerated(data, fileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? generating,
    TResult? Function(String data, String fileName)? reportGenerated,
    TResult? Function(Failure failure)? error,
  }) {
    return reportGenerated?.call(data, fileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? generating,
    TResult Function(String data, String fileName)? reportGenerated,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (reportGenerated != null) {
      return reportGenerated(data, fileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Generating value) generating,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return reportGenerated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return reportGenerated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Generating value)? generating,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (reportGenerated != null) {
      return reportGenerated(this);
    }
    return orElse();
  }
}

abstract class _ReportGenerated implements ReportGenerationState {
  const factory _ReportGenerated({
    required final String data,
    required final String fileName,
  }) = _$ReportGeneratedImpl;

  String get data;
  String get fileName;

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportGeneratedImplCopyWith<_$ReportGeneratedImpl> get copyWith =>
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
    extends _$ReportGenerationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportGenerationState
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
    return 'ReportGenerationState.error(failure: $failure)';
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

  /// Create a copy of ReportGenerationState
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
    required TResult Function() generating,
    required TResult Function(String data, String fileName) reportGenerated,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? generating,
    TResult? Function(String data, String fileName)? reportGenerated,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? generating,
    TResult Function(String data, String fileName)? reportGenerated,
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
    required TResult Function(_Generating value) generating,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Generating value)? generating,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ReportGenerationState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of ReportGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

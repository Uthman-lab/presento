// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_management_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClassManagementEvent {
  String get institutionId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId) loadClasses,
    required TResult Function(String institutionId, Class newClass) createClass,
    required TResult Function(String institutionId, Class updatedClass)
    updateClass,
    required TResult Function(String institutionId, String classId) deleteClass,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId)? loadClasses,
    TResult? Function(String institutionId, Class newClass)? createClass,
    TResult? Function(String institutionId, Class updatedClass)? updateClass,
    TResult? Function(String institutionId, String classId)? deleteClass,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId)? loadClasses,
    TResult Function(String institutionId, Class newClass)? createClass,
    TResult Function(String institutionId, Class updatedClass)? updateClass,
    TResult Function(String institutionId, String classId)? deleteClass,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassManagementLoadClasses value) loadClasses,
    required TResult Function(ClassManagementCreateClass value) createClass,
    required TResult Function(ClassManagementUpdateClass value) updateClass,
    required TResult Function(ClassManagementDeleteClass value) deleteClass,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassManagementLoadClasses value)? loadClasses,
    TResult? Function(ClassManagementCreateClass value)? createClass,
    TResult? Function(ClassManagementUpdateClass value)? updateClass,
    TResult? Function(ClassManagementDeleteClass value)? deleteClass,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassManagementLoadClasses value)? loadClasses,
    TResult Function(ClassManagementCreateClass value)? createClass,
    TResult Function(ClassManagementUpdateClass value)? updateClass,
    TResult Function(ClassManagementDeleteClass value)? deleteClass,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassManagementEventCopyWith<ClassManagementEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassManagementEventCopyWith<$Res> {
  factory $ClassManagementEventCopyWith(
    ClassManagementEvent value,
    $Res Function(ClassManagementEvent) then,
  ) = _$ClassManagementEventCopyWithImpl<$Res, ClassManagementEvent>;
  @useResult
  $Res call({String institutionId});
}

/// @nodoc
class _$ClassManagementEventCopyWithImpl<
  $Res,
  $Val extends ClassManagementEvent
>
    implements $ClassManagementEventCopyWith<$Res> {
  _$ClassManagementEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassManagementEvent
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
abstract class _$$ClassManagementLoadClassesImplCopyWith<$Res>
    implements $ClassManagementEventCopyWith<$Res> {
  factory _$$ClassManagementLoadClassesImplCopyWith(
    _$ClassManagementLoadClassesImpl value,
    $Res Function(_$ClassManagementLoadClassesImpl) then,
  ) = __$$ClassManagementLoadClassesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId});
}

/// @nodoc
class __$$ClassManagementLoadClassesImplCopyWithImpl<$Res>
    extends
        _$ClassManagementEventCopyWithImpl<
          $Res,
          _$ClassManagementLoadClassesImpl
        >
    implements _$$ClassManagementLoadClassesImplCopyWith<$Res> {
  __$$ClassManagementLoadClassesImplCopyWithImpl(
    _$ClassManagementLoadClassesImpl _value,
    $Res Function(_$ClassManagementLoadClassesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null}) {
    return _then(
      _$ClassManagementLoadClassesImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClassManagementLoadClassesImpl implements ClassManagementLoadClasses {
  const _$ClassManagementLoadClassesImpl(this.institutionId);

  @override
  final String institutionId;

  @override
  String toString() {
    return 'ClassManagementEvent.loadClasses(institutionId: $institutionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassManagementLoadClassesImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassManagementLoadClassesImplCopyWith<_$ClassManagementLoadClassesImpl>
  get copyWith =>
      __$$ClassManagementLoadClassesImplCopyWithImpl<
        _$ClassManagementLoadClassesImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId) loadClasses,
    required TResult Function(String institutionId, Class newClass) createClass,
    required TResult Function(String institutionId, Class updatedClass)
    updateClass,
    required TResult Function(String institutionId, String classId) deleteClass,
  }) {
    return loadClasses(institutionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId)? loadClasses,
    TResult? Function(String institutionId, Class newClass)? createClass,
    TResult? Function(String institutionId, Class updatedClass)? updateClass,
    TResult? Function(String institutionId, String classId)? deleteClass,
  }) {
    return loadClasses?.call(institutionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId)? loadClasses,
    TResult Function(String institutionId, Class newClass)? createClass,
    TResult Function(String institutionId, Class updatedClass)? updateClass,
    TResult Function(String institutionId, String classId)? deleteClass,
    required TResult orElse(),
  }) {
    if (loadClasses != null) {
      return loadClasses(institutionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassManagementLoadClasses value) loadClasses,
    required TResult Function(ClassManagementCreateClass value) createClass,
    required TResult Function(ClassManagementUpdateClass value) updateClass,
    required TResult Function(ClassManagementDeleteClass value) deleteClass,
  }) {
    return loadClasses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassManagementLoadClasses value)? loadClasses,
    TResult? Function(ClassManagementCreateClass value)? createClass,
    TResult? Function(ClassManagementUpdateClass value)? updateClass,
    TResult? Function(ClassManagementDeleteClass value)? deleteClass,
  }) {
    return loadClasses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassManagementLoadClasses value)? loadClasses,
    TResult Function(ClassManagementCreateClass value)? createClass,
    TResult Function(ClassManagementUpdateClass value)? updateClass,
    TResult Function(ClassManagementDeleteClass value)? deleteClass,
    required TResult orElse(),
  }) {
    if (loadClasses != null) {
      return loadClasses(this);
    }
    return orElse();
  }
}

abstract class ClassManagementLoadClasses implements ClassManagementEvent {
  const factory ClassManagementLoadClasses(final String institutionId) =
      _$ClassManagementLoadClassesImpl;

  @override
  String get institutionId;

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassManagementLoadClassesImplCopyWith<_$ClassManagementLoadClassesImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClassManagementCreateClassImplCopyWith<$Res>
    implements $ClassManagementEventCopyWith<$Res> {
  factory _$$ClassManagementCreateClassImplCopyWith(
    _$ClassManagementCreateClassImpl value,
    $Res Function(_$ClassManagementCreateClassImpl) then,
  ) = __$$ClassManagementCreateClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, Class newClass});
}

/// @nodoc
class __$$ClassManagementCreateClassImplCopyWithImpl<$Res>
    extends
        _$ClassManagementEventCopyWithImpl<
          $Res,
          _$ClassManagementCreateClassImpl
        >
    implements _$$ClassManagementCreateClassImplCopyWith<$Res> {
  __$$ClassManagementCreateClassImplCopyWithImpl(
    _$ClassManagementCreateClassImpl _value,
    $Res Function(_$ClassManagementCreateClassImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? newClass = null}) {
    return _then(
      _$ClassManagementCreateClassImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == newClass
            ? _value.newClass
            : newClass // ignore: cast_nullable_to_non_nullable
                  as Class,
      ),
    );
  }
}

/// @nodoc

class _$ClassManagementCreateClassImpl implements ClassManagementCreateClass {
  const _$ClassManagementCreateClassImpl(this.institutionId, this.newClass);

  @override
  final String institutionId;
  @override
  final Class newClass;

  @override
  String toString() {
    return 'ClassManagementEvent.createClass(institutionId: $institutionId, newClass: $newClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassManagementCreateClassImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.newClass, newClass) ||
                other.newClass == newClass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, newClass);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassManagementCreateClassImplCopyWith<_$ClassManagementCreateClassImpl>
  get copyWith =>
      __$$ClassManagementCreateClassImplCopyWithImpl<
        _$ClassManagementCreateClassImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId) loadClasses,
    required TResult Function(String institutionId, Class newClass) createClass,
    required TResult Function(String institutionId, Class updatedClass)
    updateClass,
    required TResult Function(String institutionId, String classId) deleteClass,
  }) {
    return createClass(institutionId, newClass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId)? loadClasses,
    TResult? Function(String institutionId, Class newClass)? createClass,
    TResult? Function(String institutionId, Class updatedClass)? updateClass,
    TResult? Function(String institutionId, String classId)? deleteClass,
  }) {
    return createClass?.call(institutionId, newClass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId)? loadClasses,
    TResult Function(String institutionId, Class newClass)? createClass,
    TResult Function(String institutionId, Class updatedClass)? updateClass,
    TResult Function(String institutionId, String classId)? deleteClass,
    required TResult orElse(),
  }) {
    if (createClass != null) {
      return createClass(institutionId, newClass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassManagementLoadClasses value) loadClasses,
    required TResult Function(ClassManagementCreateClass value) createClass,
    required TResult Function(ClassManagementUpdateClass value) updateClass,
    required TResult Function(ClassManagementDeleteClass value) deleteClass,
  }) {
    return createClass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassManagementLoadClasses value)? loadClasses,
    TResult? Function(ClassManagementCreateClass value)? createClass,
    TResult? Function(ClassManagementUpdateClass value)? updateClass,
    TResult? Function(ClassManagementDeleteClass value)? deleteClass,
  }) {
    return createClass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassManagementLoadClasses value)? loadClasses,
    TResult Function(ClassManagementCreateClass value)? createClass,
    TResult Function(ClassManagementUpdateClass value)? updateClass,
    TResult Function(ClassManagementDeleteClass value)? deleteClass,
    required TResult orElse(),
  }) {
    if (createClass != null) {
      return createClass(this);
    }
    return orElse();
  }
}

abstract class ClassManagementCreateClass implements ClassManagementEvent {
  const factory ClassManagementCreateClass(
    final String institutionId,
    final Class newClass,
  ) = _$ClassManagementCreateClassImpl;

  @override
  String get institutionId;
  Class get newClass;

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassManagementCreateClassImplCopyWith<_$ClassManagementCreateClassImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClassManagementUpdateClassImplCopyWith<$Res>
    implements $ClassManagementEventCopyWith<$Res> {
  factory _$$ClassManagementUpdateClassImplCopyWith(
    _$ClassManagementUpdateClassImpl value,
    $Res Function(_$ClassManagementUpdateClassImpl) then,
  ) = __$$ClassManagementUpdateClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, Class updatedClass});
}

/// @nodoc
class __$$ClassManagementUpdateClassImplCopyWithImpl<$Res>
    extends
        _$ClassManagementEventCopyWithImpl<
          $Res,
          _$ClassManagementUpdateClassImpl
        >
    implements _$$ClassManagementUpdateClassImplCopyWith<$Res> {
  __$$ClassManagementUpdateClassImplCopyWithImpl(
    _$ClassManagementUpdateClassImpl _value,
    $Res Function(_$ClassManagementUpdateClassImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? updatedClass = null}) {
    return _then(
      _$ClassManagementUpdateClassImpl(
        null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == updatedClass
            ? _value.updatedClass
            : updatedClass // ignore: cast_nullable_to_non_nullable
                  as Class,
      ),
    );
  }
}

/// @nodoc

class _$ClassManagementUpdateClassImpl implements ClassManagementUpdateClass {
  const _$ClassManagementUpdateClassImpl(this.institutionId, this.updatedClass);

  @override
  final String institutionId;
  @override
  final Class updatedClass;

  @override
  String toString() {
    return 'ClassManagementEvent.updateClass(institutionId: $institutionId, updatedClass: $updatedClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassManagementUpdateClassImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.updatedClass, updatedClass) ||
                other.updatedClass == updatedClass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, updatedClass);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassManagementUpdateClassImplCopyWith<_$ClassManagementUpdateClassImpl>
  get copyWith =>
      __$$ClassManagementUpdateClassImplCopyWithImpl<
        _$ClassManagementUpdateClassImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId) loadClasses,
    required TResult Function(String institutionId, Class newClass) createClass,
    required TResult Function(String institutionId, Class updatedClass)
    updateClass,
    required TResult Function(String institutionId, String classId) deleteClass,
  }) {
    return updateClass(institutionId, updatedClass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId)? loadClasses,
    TResult? Function(String institutionId, Class newClass)? createClass,
    TResult? Function(String institutionId, Class updatedClass)? updateClass,
    TResult? Function(String institutionId, String classId)? deleteClass,
  }) {
    return updateClass?.call(institutionId, updatedClass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId)? loadClasses,
    TResult Function(String institutionId, Class newClass)? createClass,
    TResult Function(String institutionId, Class updatedClass)? updateClass,
    TResult Function(String institutionId, String classId)? deleteClass,
    required TResult orElse(),
  }) {
    if (updateClass != null) {
      return updateClass(institutionId, updatedClass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassManagementLoadClasses value) loadClasses,
    required TResult Function(ClassManagementCreateClass value) createClass,
    required TResult Function(ClassManagementUpdateClass value) updateClass,
    required TResult Function(ClassManagementDeleteClass value) deleteClass,
  }) {
    return updateClass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassManagementLoadClasses value)? loadClasses,
    TResult? Function(ClassManagementCreateClass value)? createClass,
    TResult? Function(ClassManagementUpdateClass value)? updateClass,
    TResult? Function(ClassManagementDeleteClass value)? deleteClass,
  }) {
    return updateClass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassManagementLoadClasses value)? loadClasses,
    TResult Function(ClassManagementCreateClass value)? createClass,
    TResult Function(ClassManagementUpdateClass value)? updateClass,
    TResult Function(ClassManagementDeleteClass value)? deleteClass,
    required TResult orElse(),
  }) {
    if (updateClass != null) {
      return updateClass(this);
    }
    return orElse();
  }
}

abstract class ClassManagementUpdateClass implements ClassManagementEvent {
  const factory ClassManagementUpdateClass(
    final String institutionId,
    final Class updatedClass,
  ) = _$ClassManagementUpdateClassImpl;

  @override
  String get institutionId;
  Class get updatedClass;

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassManagementUpdateClassImplCopyWith<_$ClassManagementUpdateClassImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClassManagementDeleteClassImplCopyWith<$Res>
    implements $ClassManagementEventCopyWith<$Res> {
  factory _$$ClassManagementDeleteClassImplCopyWith(
    _$ClassManagementDeleteClassImpl value,
    $Res Function(_$ClassManagementDeleteClassImpl) then,
  ) = __$$ClassManagementDeleteClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String institutionId, String classId});
}

/// @nodoc
class __$$ClassManagementDeleteClassImplCopyWithImpl<$Res>
    extends
        _$ClassManagementEventCopyWithImpl<
          $Res,
          _$ClassManagementDeleteClassImpl
        >
    implements _$$ClassManagementDeleteClassImplCopyWith<$Res> {
  __$$ClassManagementDeleteClassImplCopyWithImpl(
    _$ClassManagementDeleteClassImpl _value,
    $Res Function(_$ClassManagementDeleteClassImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionId = null, Object? classId = null}) {
    return _then(
      _$ClassManagementDeleteClassImpl(
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

class _$ClassManagementDeleteClassImpl implements ClassManagementDeleteClass {
  const _$ClassManagementDeleteClassImpl(this.institutionId, this.classId);

  @override
  final String institutionId;
  @override
  final String classId;

  @override
  String toString() {
    return 'ClassManagementEvent.deleteClass(institutionId: $institutionId, classId: $classId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassManagementDeleteClassImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.classId, classId) || other.classId == classId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionId, classId);

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassManagementDeleteClassImplCopyWith<_$ClassManagementDeleteClassImpl>
  get copyWith =>
      __$$ClassManagementDeleteClassImplCopyWithImpl<
        _$ClassManagementDeleteClassImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String institutionId) loadClasses,
    required TResult Function(String institutionId, Class newClass) createClass,
    required TResult Function(String institutionId, Class updatedClass)
    updateClass,
    required TResult Function(String institutionId, String classId) deleteClass,
  }) {
    return deleteClass(institutionId, classId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String institutionId)? loadClasses,
    TResult? Function(String institutionId, Class newClass)? createClass,
    TResult? Function(String institutionId, Class updatedClass)? updateClass,
    TResult? Function(String institutionId, String classId)? deleteClass,
  }) {
    return deleteClass?.call(institutionId, classId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String institutionId)? loadClasses,
    TResult Function(String institutionId, Class newClass)? createClass,
    TResult Function(String institutionId, Class updatedClass)? updateClass,
    TResult Function(String institutionId, String classId)? deleteClass,
    required TResult orElse(),
  }) {
    if (deleteClass != null) {
      return deleteClass(institutionId, classId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassManagementLoadClasses value) loadClasses,
    required TResult Function(ClassManagementCreateClass value) createClass,
    required TResult Function(ClassManagementUpdateClass value) updateClass,
    required TResult Function(ClassManagementDeleteClass value) deleteClass,
  }) {
    return deleteClass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassManagementLoadClasses value)? loadClasses,
    TResult? Function(ClassManagementCreateClass value)? createClass,
    TResult? Function(ClassManagementUpdateClass value)? updateClass,
    TResult? Function(ClassManagementDeleteClass value)? deleteClass,
  }) {
    return deleteClass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassManagementLoadClasses value)? loadClasses,
    TResult Function(ClassManagementCreateClass value)? createClass,
    TResult Function(ClassManagementUpdateClass value)? updateClass,
    TResult Function(ClassManagementDeleteClass value)? deleteClass,
    required TResult orElse(),
  }) {
    if (deleteClass != null) {
      return deleteClass(this);
    }
    return orElse();
  }
}

abstract class ClassManagementDeleteClass implements ClassManagementEvent {
  const factory ClassManagementDeleteClass(
    final String institutionId,
    final String classId,
  ) = _$ClassManagementDeleteClassImpl;

  @override
  String get institutionId;
  String get classId;

  /// Create a copy of ClassManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassManagementDeleteClassImplCopyWith<_$ClassManagementDeleteClassImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassManagementState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Class> classes) loaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Class> classes)? loaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Class> classes)? loaded,
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
abstract class $ClassManagementStateCopyWith<$Res> {
  factory $ClassManagementStateCopyWith(
    ClassManagementState value,
    $Res Function(ClassManagementState) then,
  ) = _$ClassManagementStateCopyWithImpl<$Res, ClassManagementState>;
}

/// @nodoc
class _$ClassManagementStateCopyWithImpl<
  $Res,
  $Val extends ClassManagementState
>
    implements $ClassManagementStateCopyWith<$Res> {
  _$ClassManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassManagementState
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
    extends _$ClassManagementStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ClassManagementState.initial()';
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
    required TResult Function(List<Class> classes) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Class> classes)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Class> classes)? loaded,
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

abstract class _Initial implements ClassManagementState {
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
    extends _$ClassManagementStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ClassManagementState.loading()';
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
    required TResult Function(List<Class> classes) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Class> classes)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Class> classes)? loaded,
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

abstract class _Loading implements ClassManagementState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Class> classes});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ClassManagementStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? classes = null}) {
    return _then(
      _$LoadedImpl(
        null == classes
            ? _value._classes
            : classes // ignore: cast_nullable_to_non_nullable
                  as List<Class>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Class> classes) : _classes = classes;

  final List<Class> _classes;
  @override
  List<Class> get classes {
    if (_classes is EqualUnmodifiableListView) return _classes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classes);
  }

  @override
  String toString() {
    return 'ClassManagementState.loaded(classes: $classes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._classes, _classes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_classes));

  /// Create a copy of ClassManagementState
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
    required TResult Function(List<Class> classes) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(classes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Class> classes)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(classes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Class> classes)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(classes);
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

abstract class _Loaded implements ClassManagementState {
  const factory _Loaded(final List<Class> classes) = _$LoadedImpl;

  List<Class> get classes;

  /// Create a copy of ClassManagementState
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
    extends _$ClassManagementStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassManagementState
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
    return 'ClassManagementState.error(failure: $failure)';
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

  /// Create a copy of ClassManagementState
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
    required TResult Function(List<Class> classes) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Class> classes)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Class> classes)? loaded,
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

abstract class _Error implements ClassManagementState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of ClassManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'download_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DownloadState {
  bool get completed => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  double get percentCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DownloadStateCopyWith<DownloadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadStateCopyWith<$Res> {
  factory $DownloadStateCopyWith(
          DownloadState value, $Res Function(DownloadState) then) =
      _$DownloadStateCopyWithImpl<$Res, DownloadState>;
  @useResult
  $Res call(
      {bool completed, dynamic isLoading, int total, double percentCompleted});
}

/// @nodoc
class _$DownloadStateCopyWithImpl<$Res, $Val extends DownloadState>
    implements $DownloadStateCopyWith<$Res> {
  _$DownloadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completed = null,
    Object? isLoading = null,
    Object? total = null,
    Object? percentCompleted = null,
  }) {
    return _then(_value.copyWith(
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      percentCompleted: null == percentCompleted
          ? _value.percentCompleted
          : percentCompleted // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DownloadStateCopyWith<$Res>
    implements $DownloadStateCopyWith<$Res> {
  factory _$$_DownloadStateCopyWith(
          _$_DownloadState value, $Res Function(_$_DownloadState) then) =
      __$$_DownloadStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool completed, dynamic isLoading, int total, double percentCompleted});
}

/// @nodoc
class __$$_DownloadStateCopyWithImpl<$Res>
    extends _$DownloadStateCopyWithImpl<$Res, _$_DownloadState>
    implements _$$_DownloadStateCopyWith<$Res> {
  __$$_DownloadStateCopyWithImpl(
      _$_DownloadState _value, $Res Function(_$_DownloadState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completed = null,
    Object? isLoading = null,
    Object? total = null,
    Object? percentCompleted = null,
  }) {
    return _then(_$_DownloadState(
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading ? _value.isLoading : isLoading,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      percentCompleted: null == percentCompleted
          ? _value.percentCompleted
          : percentCompleted // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_DownloadState extends _DownloadState {
  const _$_DownloadState(
      {this.completed = false,
      this.isLoading = false,
      this.total = 0,
      this.percentCompleted = 0.0})
      : super._();

  @override
  @JsonKey()
  final bool completed;
  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final double percentCompleted;

  @override
  String toString() {
    return 'DownloadState(completed: $completed, isLoading: $isLoading, total: $total, percentCompleted: $percentCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DownloadState &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.percentCompleted, percentCompleted) ||
                other.percentCompleted == percentCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completed,
      const DeepCollectionEquality().hash(isLoading), total, percentCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DownloadStateCopyWith<_$_DownloadState> get copyWith =>
      __$$_DownloadStateCopyWithImpl<_$_DownloadState>(this, _$identity);
}

abstract class _DownloadState extends DownloadState {
  const factory _DownloadState(
      {final bool completed,
      final dynamic isLoading,
      final int total,
      final double percentCompleted}) = _$_DownloadState;
  const _DownloadState._() : super._();

  @override
  bool get completed;
  @override
  dynamic get isLoading;
  @override
  int get total;
  @override
  double get percentCompleted;
  @override
  @JsonKey(ignore: true)
  _$$_DownloadStateCopyWith<_$_DownloadState> get copyWith =>
      throw _privateConstructorUsedError;
}

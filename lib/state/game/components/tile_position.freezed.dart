// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TilePosition _$TilePositionFromJson(Map<String, dynamic> json) {
  return _TilePosition.fromJson(json);
}

/// @nodoc
mixin _$TilePosition {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TilePositionCopyWith<TilePosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TilePositionCopyWith<$Res> {
  factory $TilePositionCopyWith(
          TilePosition value, $Res Function(TilePosition) then) =
      _$TilePositionCopyWithImpl<$Res, TilePosition>;
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class _$TilePositionCopyWithImpl<$Res, $Val extends TilePosition>
    implements $TilePositionCopyWith<$Res> {
  _$TilePositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TilePositionImplCopyWith<$Res>
    implements $TilePositionCopyWith<$Res> {
  factory _$$TilePositionImplCopyWith(
          _$TilePositionImpl value, $Res Function(_$TilePositionImpl) then) =
      __$$TilePositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$TilePositionImplCopyWithImpl<$Res>
    extends _$TilePositionCopyWithImpl<$Res, _$TilePositionImpl>
    implements _$$TilePositionImplCopyWith<$Res> {
  __$$TilePositionImplCopyWithImpl(
      _$TilePositionImpl _value, $Res Function(_$TilePositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$TilePositionImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TilePositionImpl implements _TilePosition {
  const _$TilePositionImpl({required this.x, required this.y});

  factory _$TilePositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TilePositionImplFromJson(json);

  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'TilePosition(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TilePositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TilePositionImplCopyWith<_$TilePositionImpl> get copyWith =>
      __$$TilePositionImplCopyWithImpl<_$TilePositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TilePositionImplToJson(
      this,
    );
  }
}

abstract class _TilePosition implements TilePosition {
  const factory _TilePosition({required final int x, required final int y}) =
      _$TilePositionImpl;

  factory _TilePosition.fromJson(Map<String, dynamic> json) =
      _$TilePositionImpl.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  @JsonKey(ignore: true)
  _$$TilePositionImplCopyWith<_$TilePositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

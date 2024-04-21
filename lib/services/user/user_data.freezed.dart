// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get countryCode => throw _privateConstructorUsedError;
  int get finishedLevel => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  bool get introShown => throw _privateConstructorUsedError;
  Set<OnboardingTooltip> get onboardingTooltipsShown =>
      throw _privateConstructorUsedError;
  String get flag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String countryCode,
      int finishedLevel,
      List<String> achievements,
      bool introShown,
      Set<OnboardingTooltip> onboardingTooltipsShown,
      String flag});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = null,
    Object? finishedLevel = null,
    Object? achievements = null,
    Object? introShown = null,
    Object? onboardingTooltipsShown = null,
    Object? flag = null,
  }) {
    return _then(_value.copyWith(
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      finishedLevel: null == finishedLevel
          ? _value.finishedLevel
          : finishedLevel // ignore: cast_nullable_to_non_nullable
              as int,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      introShown: null == introShown
          ? _value.introShown
          : introShown // ignore: cast_nullable_to_non_nullable
              as bool,
      onboardingTooltipsShown: null == onboardingTooltipsShown
          ? _value.onboardingTooltipsShown
          : onboardingTooltipsShown // ignore: cast_nullable_to_non_nullable
              as Set<OnboardingTooltip>,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String countryCode,
      int finishedLevel,
      List<String> achievements,
      bool introShown,
      Set<OnboardingTooltip> onboardingTooltipsShown,
      String flag});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = null,
    Object? finishedLevel = null,
    Object? achievements = null,
    Object? introShown = null,
    Object? onboardingTooltipsShown = null,
    Object? flag = null,
  }) {
    return _then(_$UserDataImpl(
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      finishedLevel: null == finishedLevel
          ? _value.finishedLevel
          : finishedLevel // ignore: cast_nullable_to_non_nullable
              as int,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      introShown: null == introShown
          ? _value.introShown
          : introShown // ignore: cast_nullable_to_non_nullable
              as bool,
      onboardingTooltipsShown: null == onboardingTooltipsShown
          ? _value._onboardingTooltipsShown
          : onboardingTooltipsShown // ignore: cast_nullable_to_non_nullable
              as Set<OnboardingTooltip>,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  const _$UserDataImpl(
      {this.countryCode = 'UN',
      this.finishedLevel = 0,
      final List<String> achievements = const [],
      this.introShown = false,
      final Set<OnboardingTooltip> onboardingTooltipsShown = const {},
      this.flag = 'UN'})
      : _achievements = achievements,
        _onboardingTooltipsShown = onboardingTooltipsShown;

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  @JsonKey()
  final String countryCode;
  @override
  @JsonKey()
  final int finishedLevel;
  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  @JsonKey()
  final bool introShown;
  final Set<OnboardingTooltip> _onboardingTooltipsShown;
  @override
  @JsonKey()
  Set<OnboardingTooltip> get onboardingTooltipsShown {
    if (_onboardingTooltipsShown is EqualUnmodifiableSetView)
      return _onboardingTooltipsShown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_onboardingTooltipsShown);
  }

  @override
  @JsonKey()
  final String flag;

  @override
  String toString() {
    return 'UserData(countryCode: $countryCode, finishedLevel: $finishedLevel, achievements: $achievements, introShown: $introShown, onboardingTooltipsShown: $onboardingTooltipsShown, flag: $flag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.finishedLevel, finishedLevel) ||
                other.finishedLevel == finishedLevel) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            (identical(other.introShown, introShown) ||
                other.introShown == introShown) &&
            const DeepCollectionEquality().equals(
                other._onboardingTooltipsShown, _onboardingTooltipsShown) &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      countryCode,
      finishedLevel,
      const DeepCollectionEquality().hash(_achievements),
      introShown,
      const DeepCollectionEquality().hash(_onboardingTooltipsShown),
      flag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  const factory _UserData(
      {final String countryCode,
      final int finishedLevel,
      final List<String> achievements,
      final bool introShown,
      final Set<OnboardingTooltip> onboardingTooltipsShown,
      final String flag}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  String get countryCode;
  @override
  int get finishedLevel;
  @override
  List<String> get achievements;
  @override
  bool get introShown;
  @override
  Set<OnboardingTooltip> get onboardingTooltipsShown;
  @override
  String get flag;
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

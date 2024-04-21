// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameStateData {
  bool get initialised => throw _privateConstructorUsedError;
  List<GameObject> get objects => throw _privateConstructorUsedError;
  Map<ResourceType, Resource> get resources =>
      throw _privateConstructorUsedError;
  Map<ResourceType, Resource> get availableResources =>
      throw _privateConstructorUsedError;
  Set<TechnologyType> get technologies => throw _privateConstructorUsedError;
  BuildingNode? get buildingToBuild => throw _privateConstructorUsedError;
  Set<TilePosition> get tilesToClean => throw _privateConstructorUsedError;
  int get transportsState => throw _privateConstructorUsedError;
  Message? get message => throw _privateConstructorUsedError;
  AchievementNode? get achievement => throw _privateConstructorUsedError;
  GameScore get score => throw _privateConstructorUsedError;
  double get gameSpeed => throw _privateConstructorUsedError;
  bool get useAutomaticCleanup => throw _privateConstructorUsedError;
  BuildingTile? get selectedBuilding => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateDataCopyWith<GameStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateDataCopyWith<$Res> {
  factory $GameStateDataCopyWith(
          GameStateData value, $Res Function(GameStateData) then) =
      _$GameStateDataCopyWithImpl<$Res, GameStateData>;
  @useResult
  $Res call(
      {bool initialised,
      List<GameObject> objects,
      Map<ResourceType, Resource> resources,
      Map<ResourceType, Resource> availableResources,
      Set<TechnologyType> technologies,
      BuildingNode? buildingToBuild,
      Set<TilePosition> tilesToClean,
      int transportsState,
      Message? message,
      AchievementNode? achievement,
      GameScore score,
      double gameSpeed,
      bool useAutomaticCleanup,
      BuildingTile? selectedBuilding});
}

/// @nodoc
class _$GameStateDataCopyWithImpl<$Res, $Val extends GameStateData>
    implements $GameStateDataCopyWith<$Res> {
  _$GameStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialised = null,
    Object? objects = null,
    Object? resources = null,
    Object? availableResources = null,
    Object? technologies = null,
    Object? buildingToBuild = freezed,
    Object? tilesToClean = null,
    Object? transportsState = null,
    Object? message = freezed,
    Object? achievement = freezed,
    Object? score = null,
    Object? gameSpeed = null,
    Object? useAutomaticCleanup = null,
    Object? selectedBuilding = freezed,
  }) {
    return _then(_value.copyWith(
      initialised: null == initialised
          ? _value.initialised
          : initialised // ignore: cast_nullable_to_non_nullable
              as bool,
      objects: null == objects
          ? _value.objects
          : objects // ignore: cast_nullable_to_non_nullable
              as List<GameObject>,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Map<ResourceType, Resource>,
      availableResources: null == availableResources
          ? _value.availableResources
          : availableResources // ignore: cast_nullable_to_non_nullable
              as Map<ResourceType, Resource>,
      technologies: null == technologies
          ? _value.technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as Set<TechnologyType>,
      buildingToBuild: freezed == buildingToBuild
          ? _value.buildingToBuild
          : buildingToBuild // ignore: cast_nullable_to_non_nullable
              as BuildingNode?,
      tilesToClean: null == tilesToClean
          ? _value.tilesToClean
          : tilesToClean // ignore: cast_nullable_to_non_nullable
              as Set<TilePosition>,
      transportsState: null == transportsState
          ? _value.transportsState
          : transportsState // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      achievement: freezed == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as AchievementNode?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as GameScore,
      gameSpeed: null == gameSpeed
          ? _value.gameSpeed
          : gameSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      useAutomaticCleanup: null == useAutomaticCleanup
          ? _value.useAutomaticCleanup
          : useAutomaticCleanup // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingTile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateDataImplCopyWith<$Res>
    implements $GameStateDataCopyWith<$Res> {
  factory _$$GameStateDataImplCopyWith(
          _$GameStateDataImpl value, $Res Function(_$GameStateDataImpl) then) =
      __$$GameStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool initialised,
      List<GameObject> objects,
      Map<ResourceType, Resource> resources,
      Map<ResourceType, Resource> availableResources,
      Set<TechnologyType> technologies,
      BuildingNode? buildingToBuild,
      Set<TilePosition> tilesToClean,
      int transportsState,
      Message? message,
      AchievementNode? achievement,
      GameScore score,
      double gameSpeed,
      bool useAutomaticCleanup,
      BuildingTile? selectedBuilding});
}

/// @nodoc
class __$$GameStateDataImplCopyWithImpl<$Res>
    extends _$GameStateDataCopyWithImpl<$Res, _$GameStateDataImpl>
    implements _$$GameStateDataImplCopyWith<$Res> {
  __$$GameStateDataImplCopyWithImpl(
      _$GameStateDataImpl _value, $Res Function(_$GameStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialised = null,
    Object? objects = null,
    Object? resources = null,
    Object? availableResources = null,
    Object? technologies = null,
    Object? buildingToBuild = freezed,
    Object? tilesToClean = null,
    Object? transportsState = null,
    Object? message = freezed,
    Object? achievement = freezed,
    Object? score = null,
    Object? gameSpeed = null,
    Object? useAutomaticCleanup = null,
    Object? selectedBuilding = freezed,
  }) {
    return _then(_$GameStateDataImpl(
      initialised: null == initialised
          ? _value.initialised
          : initialised // ignore: cast_nullable_to_non_nullable
              as bool,
      objects: null == objects
          ? _value._objects
          : objects // ignore: cast_nullable_to_non_nullable
              as List<GameObject>,
      resources: null == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Map<ResourceType, Resource>,
      availableResources: null == availableResources
          ? _value._availableResources
          : availableResources // ignore: cast_nullable_to_non_nullable
              as Map<ResourceType, Resource>,
      technologies: null == technologies
          ? _value._technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as Set<TechnologyType>,
      buildingToBuild: freezed == buildingToBuild
          ? _value.buildingToBuild
          : buildingToBuild // ignore: cast_nullable_to_non_nullable
              as BuildingNode?,
      tilesToClean: null == tilesToClean
          ? _value._tilesToClean
          : tilesToClean // ignore: cast_nullable_to_non_nullable
              as Set<TilePosition>,
      transportsState: null == transportsState
          ? _value.transportsState
          : transportsState // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      achievement: freezed == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as AchievementNode?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as GameScore,
      gameSpeed: null == gameSpeed
          ? _value.gameSpeed
          : gameSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      useAutomaticCleanup: null == useAutomaticCleanup
          ? _value.useAutomaticCleanup
          : useAutomaticCleanup // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingTile?,
    ));
  }
}

/// @nodoc

class _$GameStateDataImpl implements _GameStateData {
  const _$GameStateDataImpl(
      {required this.initialised,
      required final List<GameObject> objects,
      required final Map<ResourceType, Resource> resources,
      required final Map<ResourceType, Resource> availableResources,
      required final Set<TechnologyType> technologies,
      this.buildingToBuild,
      required final Set<TilePosition> tilesToClean,
      required this.transportsState,
      this.message,
      this.achievement,
      required this.score,
      required this.gameSpeed,
      required this.useAutomaticCleanup,
      this.selectedBuilding})
      : _objects = objects,
        _resources = resources,
        _availableResources = availableResources,
        _technologies = technologies,
        _tilesToClean = tilesToClean;

  @override
  final bool initialised;
  final List<GameObject> _objects;
  @override
  List<GameObject> get objects {
    if (_objects is EqualUnmodifiableListView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objects);
  }

  final Map<ResourceType, Resource> _resources;
  @override
  Map<ResourceType, Resource> get resources {
    if (_resources is EqualUnmodifiableMapView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_resources);
  }

  final Map<ResourceType, Resource> _availableResources;
  @override
  Map<ResourceType, Resource> get availableResources {
    if (_availableResources is EqualUnmodifiableMapView)
      return _availableResources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableResources);
  }

  final Set<TechnologyType> _technologies;
  @override
  Set<TechnologyType> get technologies {
    if (_technologies is EqualUnmodifiableSetView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_technologies);
  }

  @override
  final BuildingNode? buildingToBuild;
  final Set<TilePosition> _tilesToClean;
  @override
  Set<TilePosition> get tilesToClean {
    if (_tilesToClean is EqualUnmodifiableSetView) return _tilesToClean;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_tilesToClean);
  }

  @override
  final int transportsState;
  @override
  final Message? message;
  @override
  final AchievementNode? achievement;
  @override
  final GameScore score;
  @override
  final double gameSpeed;
  @override
  final bool useAutomaticCleanup;
  @override
  final BuildingTile? selectedBuilding;

  @override
  String toString() {
    return 'GameStateData(initialised: $initialised, objects: $objects, resources: $resources, availableResources: $availableResources, technologies: $technologies, buildingToBuild: $buildingToBuild, tilesToClean: $tilesToClean, transportsState: $transportsState, message: $message, achievement: $achievement, score: $score, gameSpeed: $gameSpeed, useAutomaticCleanup: $useAutomaticCleanup, selectedBuilding: $selectedBuilding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateDataImpl &&
            (identical(other.initialised, initialised) ||
                other.initialised == initialised) &&
            const DeepCollectionEquality().equals(other._objects, _objects) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            const DeepCollectionEquality()
                .equals(other._availableResources, _availableResources) &&
            const DeepCollectionEquality()
                .equals(other._technologies, _technologies) &&
            (identical(other.buildingToBuild, buildingToBuild) ||
                other.buildingToBuild == buildingToBuild) &&
            const DeepCollectionEquality()
                .equals(other._tilesToClean, _tilesToClean) &&
            (identical(other.transportsState, transportsState) ||
                other.transportsState == transportsState) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.achievement, achievement) ||
                other.achievement == achievement) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.gameSpeed, gameSpeed) ||
                other.gameSpeed == gameSpeed) &&
            (identical(other.useAutomaticCleanup, useAutomaticCleanup) ||
                other.useAutomaticCleanup == useAutomaticCleanup) &&
            (identical(other.selectedBuilding, selectedBuilding) ||
                other.selectedBuilding == selectedBuilding));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      initialised,
      const DeepCollectionEquality().hash(_objects),
      const DeepCollectionEquality().hash(_resources),
      const DeepCollectionEquality().hash(_availableResources),
      const DeepCollectionEquality().hash(_technologies),
      buildingToBuild,
      const DeepCollectionEquality().hash(_tilesToClean),
      transportsState,
      message,
      achievement,
      score,
      gameSpeed,
      useAutomaticCleanup,
      selectedBuilding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateDataImplCopyWith<_$GameStateDataImpl> get copyWith =>
      __$$GameStateDataImplCopyWithImpl<_$GameStateDataImpl>(this, _$identity);
}

abstract class _GameStateData implements GameStateData {
  const factory _GameStateData(
      {required final bool initialised,
      required final List<GameObject> objects,
      required final Map<ResourceType, Resource> resources,
      required final Map<ResourceType, Resource> availableResources,
      required final Set<TechnologyType> technologies,
      final BuildingNode? buildingToBuild,
      required final Set<TilePosition> tilesToClean,
      required final int transportsState,
      final Message? message,
      final AchievementNode? achievement,
      required final GameScore score,
      required final double gameSpeed,
      required final bool useAutomaticCleanup,
      final BuildingTile? selectedBuilding}) = _$GameStateDataImpl;

  @override
  bool get initialised;
  @override
  List<GameObject> get objects;
  @override
  Map<ResourceType, Resource> get resources;
  @override
  Map<ResourceType, Resource> get availableResources;
  @override
  Set<TechnologyType> get technologies;
  @override
  BuildingNode? get buildingToBuild;
  @override
  Set<TilePosition> get tilesToClean;
  @override
  int get transportsState;
  @override
  Message? get message;
  @override
  AchievementNode? get achievement;
  @override
  GameScore get score;
  @override
  double get gameSpeed;
  @override
  bool get useAutomaticCleanup;
  @override
  BuildingTile? get selectedBuilding;
  @override
  @JsonKey(ignore: true)
  _$$GameStateDataImplCopyWith<_$GameStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

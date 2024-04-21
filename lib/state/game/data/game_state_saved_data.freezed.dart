// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state_saved_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameStateSavedData _$GameStateSavedDataFromJson(Map<String, dynamic> json) {
  return _GameStateSavedData.fromJson(json);
}

/// @nodoc
mixin _$GameStateSavedData {
  int get level => throw _privateConstructorUsedError;
  String get slot => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<SavedBuildingTile> get buildings => throw _privateConstructorUsedError;
  List<SavedCleanupTile> get cleanupTiles => throw _privateConstructorUsedError;
  List<SavedDipomaticMissionTile> get diplomaticMissionTiles =>
      throw _privateConstructorUsedError;
  List<Resource> get resources => throw _privateConstructorUsedError;
  List<Resource> get availableResources => throw _privateConstructorUsedError;
  Set<TechnologyType> get technologies => throw _privateConstructorUsedError;
  Set<TilePosition> get tilesToClean => throw _privateConstructorUsedError;
  GameScore get score => throw _privateConstructorUsedError;
  double get gameSpeed => throw _privateConstructorUsedError;
  bool get useAutomaticCleanup => throw _privateConstructorUsedError;
  List<TilePosition> get pollutedTiles => throw _privateConstructorUsedError;
  List<int?> get templateTiles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateSavedDataCopyWith<GameStateSavedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateSavedDataCopyWith<$Res> {
  factory $GameStateSavedDataCopyWith(
          GameStateSavedData value, $Res Function(GameStateSavedData) then) =
      _$GameStateSavedDataCopyWithImpl<$Res, GameStateSavedData>;
  @useResult
  $Res call(
      {int level,
      String slot,
      String? name,
      @DateTimeConverter() DateTime? createdAt,
      List<SavedBuildingTile> buildings,
      List<SavedCleanupTile> cleanupTiles,
      List<SavedDipomaticMissionTile> diplomaticMissionTiles,
      List<Resource> resources,
      List<Resource> availableResources,
      Set<TechnologyType> technologies,
      Set<TilePosition> tilesToClean,
      GameScore score,
      double gameSpeed,
      bool useAutomaticCleanup,
      List<TilePosition> pollutedTiles,
      List<int?> templateTiles});
}

/// @nodoc
class _$GameStateSavedDataCopyWithImpl<$Res, $Val extends GameStateSavedData>
    implements $GameStateSavedDataCopyWith<$Res> {
  _$GameStateSavedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? slot = null,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? buildings = null,
    Object? cleanupTiles = null,
    Object? diplomaticMissionTiles = null,
    Object? resources = null,
    Object? availableResources = null,
    Object? technologies = null,
    Object? tilesToClean = null,
    Object? score = null,
    Object? gameSpeed = null,
    Object? useAutomaticCleanup = null,
    Object? pollutedTiles = null,
    Object? templateTiles = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      buildings: null == buildings
          ? _value.buildings
          : buildings // ignore: cast_nullable_to_non_nullable
              as List<SavedBuildingTile>,
      cleanupTiles: null == cleanupTiles
          ? _value.cleanupTiles
          : cleanupTiles // ignore: cast_nullable_to_non_nullable
              as List<SavedCleanupTile>,
      diplomaticMissionTiles: null == diplomaticMissionTiles
          ? _value.diplomaticMissionTiles
          : diplomaticMissionTiles // ignore: cast_nullable_to_non_nullable
              as List<SavedDipomaticMissionTile>,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<Resource>,
      availableResources: null == availableResources
          ? _value.availableResources
          : availableResources // ignore: cast_nullable_to_non_nullable
              as List<Resource>,
      technologies: null == technologies
          ? _value.technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as Set<TechnologyType>,
      tilesToClean: null == tilesToClean
          ? _value.tilesToClean
          : tilesToClean // ignore: cast_nullable_to_non_nullable
              as Set<TilePosition>,
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
      pollutedTiles: null == pollutedTiles
          ? _value.pollutedTiles
          : pollutedTiles // ignore: cast_nullable_to_non_nullable
              as List<TilePosition>,
      templateTiles: null == templateTiles
          ? _value.templateTiles
          : templateTiles // ignore: cast_nullable_to_non_nullable
              as List<int?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateSavedDataImplCopyWith<$Res>
    implements $GameStateSavedDataCopyWith<$Res> {
  factory _$$GameStateSavedDataImplCopyWith(_$GameStateSavedDataImpl value,
          $Res Function(_$GameStateSavedDataImpl) then) =
      __$$GameStateSavedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int level,
      String slot,
      String? name,
      @DateTimeConverter() DateTime? createdAt,
      List<SavedBuildingTile> buildings,
      List<SavedCleanupTile> cleanupTiles,
      List<SavedDipomaticMissionTile> diplomaticMissionTiles,
      List<Resource> resources,
      List<Resource> availableResources,
      Set<TechnologyType> technologies,
      Set<TilePosition> tilesToClean,
      GameScore score,
      double gameSpeed,
      bool useAutomaticCleanup,
      List<TilePosition> pollutedTiles,
      List<int?> templateTiles});
}

/// @nodoc
class __$$GameStateSavedDataImplCopyWithImpl<$Res>
    extends _$GameStateSavedDataCopyWithImpl<$Res, _$GameStateSavedDataImpl>
    implements _$$GameStateSavedDataImplCopyWith<$Res> {
  __$$GameStateSavedDataImplCopyWithImpl(_$GameStateSavedDataImpl _value,
      $Res Function(_$GameStateSavedDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? slot = null,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? buildings = null,
    Object? cleanupTiles = null,
    Object? diplomaticMissionTiles = null,
    Object? resources = null,
    Object? availableResources = null,
    Object? technologies = null,
    Object? tilesToClean = null,
    Object? score = null,
    Object? gameSpeed = null,
    Object? useAutomaticCleanup = null,
    Object? pollutedTiles = null,
    Object? templateTiles = null,
  }) {
    return _then(_$GameStateSavedDataImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      buildings: null == buildings
          ? _value._buildings
          : buildings // ignore: cast_nullable_to_non_nullable
              as List<SavedBuildingTile>,
      cleanupTiles: null == cleanupTiles
          ? _value._cleanupTiles
          : cleanupTiles // ignore: cast_nullable_to_non_nullable
              as List<SavedCleanupTile>,
      diplomaticMissionTiles: null == diplomaticMissionTiles
          ? _value._diplomaticMissionTiles
          : diplomaticMissionTiles // ignore: cast_nullable_to_non_nullable
              as List<SavedDipomaticMissionTile>,
      resources: null == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<Resource>,
      availableResources: null == availableResources
          ? _value._availableResources
          : availableResources // ignore: cast_nullable_to_non_nullable
              as List<Resource>,
      technologies: null == technologies
          ? _value._technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as Set<TechnologyType>,
      tilesToClean: null == tilesToClean
          ? _value._tilesToClean
          : tilesToClean // ignore: cast_nullable_to_non_nullable
              as Set<TilePosition>,
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
      pollutedTiles: null == pollutedTiles
          ? _value._pollutedTiles
          : pollutedTiles // ignore: cast_nullable_to_non_nullable
              as List<TilePosition>,
      templateTiles: null == templateTiles
          ? _value._templateTiles
          : templateTiles // ignore: cast_nullable_to_non_nullable
              as List<int?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateSavedDataImpl implements _GameStateSavedData {
  const _$GameStateSavedDataImpl(
      {required this.level,
      required this.slot,
      this.name,
      @DateTimeConverter() this.createdAt,
      required final List<SavedBuildingTile> buildings,
      required final List<SavedCleanupTile> cleanupTiles,
      required final List<SavedDipomaticMissionTile> diplomaticMissionTiles,
      required final List<Resource> resources,
      required final List<Resource> availableResources,
      required final Set<TechnologyType> technologies,
      required final Set<TilePosition> tilesToClean,
      required this.score,
      required this.gameSpeed,
      required this.useAutomaticCleanup,
      required final List<TilePosition> pollutedTiles,
      required final List<int?> templateTiles})
      : _buildings = buildings,
        _cleanupTiles = cleanupTiles,
        _diplomaticMissionTiles = diplomaticMissionTiles,
        _resources = resources,
        _availableResources = availableResources,
        _technologies = technologies,
        _tilesToClean = tilesToClean,
        _pollutedTiles = pollutedTiles,
        _templateTiles = templateTiles;

  factory _$GameStateSavedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateSavedDataImplFromJson(json);

  @override
  final int level;
  @override
  final String slot;
  @override
  final String? name;
  @override
  @DateTimeConverter()
  final DateTime? createdAt;
  final List<SavedBuildingTile> _buildings;
  @override
  List<SavedBuildingTile> get buildings {
    if (_buildings is EqualUnmodifiableListView) return _buildings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buildings);
  }

  final List<SavedCleanupTile> _cleanupTiles;
  @override
  List<SavedCleanupTile> get cleanupTiles {
    if (_cleanupTiles is EqualUnmodifiableListView) return _cleanupTiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cleanupTiles);
  }

  final List<SavedDipomaticMissionTile> _diplomaticMissionTiles;
  @override
  List<SavedDipomaticMissionTile> get diplomaticMissionTiles {
    if (_diplomaticMissionTiles is EqualUnmodifiableListView)
      return _diplomaticMissionTiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_diplomaticMissionTiles);
  }

  final List<Resource> _resources;
  @override
  List<Resource> get resources {
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resources);
  }

  final List<Resource> _availableResources;
  @override
  List<Resource> get availableResources {
    if (_availableResources is EqualUnmodifiableListView)
      return _availableResources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableResources);
  }

  final Set<TechnologyType> _technologies;
  @override
  Set<TechnologyType> get technologies {
    if (_technologies is EqualUnmodifiableSetView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_technologies);
  }

  final Set<TilePosition> _tilesToClean;
  @override
  Set<TilePosition> get tilesToClean {
    if (_tilesToClean is EqualUnmodifiableSetView) return _tilesToClean;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_tilesToClean);
  }

  @override
  final GameScore score;
  @override
  final double gameSpeed;
  @override
  final bool useAutomaticCleanup;
  final List<TilePosition> _pollutedTiles;
  @override
  List<TilePosition> get pollutedTiles {
    if (_pollutedTiles is EqualUnmodifiableListView) return _pollutedTiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pollutedTiles);
  }

  final List<int?> _templateTiles;
  @override
  List<int?> get templateTiles {
    if (_templateTiles is EqualUnmodifiableListView) return _templateTiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templateTiles);
  }

  @override
  String toString() {
    return 'GameStateSavedData(level: $level, slot: $slot, name: $name, createdAt: $createdAt, buildings: $buildings, cleanupTiles: $cleanupTiles, diplomaticMissionTiles: $diplomaticMissionTiles, resources: $resources, availableResources: $availableResources, technologies: $technologies, tilesToClean: $tilesToClean, score: $score, gameSpeed: $gameSpeed, useAutomaticCleanup: $useAutomaticCleanup, pollutedTiles: $pollutedTiles, templateTiles: $templateTiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateSavedDataImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._buildings, _buildings) &&
            const DeepCollectionEquality()
                .equals(other._cleanupTiles, _cleanupTiles) &&
            const DeepCollectionEquality().equals(
                other._diplomaticMissionTiles, _diplomaticMissionTiles) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            const DeepCollectionEquality()
                .equals(other._availableResources, _availableResources) &&
            const DeepCollectionEquality()
                .equals(other._technologies, _technologies) &&
            const DeepCollectionEquality()
                .equals(other._tilesToClean, _tilesToClean) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.gameSpeed, gameSpeed) ||
                other.gameSpeed == gameSpeed) &&
            (identical(other.useAutomaticCleanup, useAutomaticCleanup) ||
                other.useAutomaticCleanup == useAutomaticCleanup) &&
            const DeepCollectionEquality()
                .equals(other._pollutedTiles, _pollutedTiles) &&
            const DeepCollectionEquality()
                .equals(other._templateTiles, _templateTiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      level,
      slot,
      name,
      createdAt,
      const DeepCollectionEquality().hash(_buildings),
      const DeepCollectionEquality().hash(_cleanupTiles),
      const DeepCollectionEquality().hash(_diplomaticMissionTiles),
      const DeepCollectionEquality().hash(_resources),
      const DeepCollectionEquality().hash(_availableResources),
      const DeepCollectionEquality().hash(_technologies),
      const DeepCollectionEquality().hash(_tilesToClean),
      score,
      gameSpeed,
      useAutomaticCleanup,
      const DeepCollectionEquality().hash(_pollutedTiles),
      const DeepCollectionEquality().hash(_templateTiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateSavedDataImplCopyWith<_$GameStateSavedDataImpl> get copyWith =>
      __$$GameStateSavedDataImplCopyWithImpl<_$GameStateSavedDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateSavedDataImplToJson(
      this,
    );
  }
}

abstract class _GameStateSavedData implements GameStateSavedData {
  const factory _GameStateSavedData(
      {required final int level,
      required final String slot,
      final String? name,
      @DateTimeConverter() final DateTime? createdAt,
      required final List<SavedBuildingTile> buildings,
      required final List<SavedCleanupTile> cleanupTiles,
      required final List<SavedDipomaticMissionTile> diplomaticMissionTiles,
      required final List<Resource> resources,
      required final List<Resource> availableResources,
      required final Set<TechnologyType> technologies,
      required final Set<TilePosition> tilesToClean,
      required final GameScore score,
      required final double gameSpeed,
      required final bool useAutomaticCleanup,
      required final List<TilePosition> pollutedTiles,
      required final List<int?> templateTiles}) = _$GameStateSavedDataImpl;

  factory _GameStateSavedData.fromJson(Map<String, dynamic> json) =
      _$GameStateSavedDataImpl.fromJson;

  @override
  int get level;
  @override
  String get slot;
  @override
  String? get name;
  @override
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  List<SavedBuildingTile> get buildings;
  @override
  List<SavedCleanupTile> get cleanupTiles;
  @override
  List<SavedDipomaticMissionTile> get diplomaticMissionTiles;
  @override
  List<Resource> get resources;
  @override
  List<Resource> get availableResources;
  @override
  Set<TechnologyType> get technologies;
  @override
  Set<TilePosition> get tilesToClean;
  @override
  GameScore get score;
  @override
  double get gameSpeed;
  @override
  bool get useAutomaticCleanup;
  @override
  List<TilePosition> get pollutedTiles;
  @override
  List<int?> get templateTiles;
  @override
  @JsonKey(ignore: true)
  _$$GameStateSavedDataImplCopyWith<_$GameStateSavedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavedBuildingTile _$SavedBuildingTileFromJson(Map<String, dynamic> json) {
  return _SavedGameObject.fromJson(json);
}

/// @nodoc
mixin _$SavedBuildingTile {
  int get buildingId => throw _privateConstructorUsedError;
  TilePosition get position => throw _privateConstructorUsedError;
  double get constructionTimeElapsed => throw _privateConstructorUsedError;
  double? get cleaningTimeElapsed => throw _privateConstructorUsedError;
  bool? get cleaningPaused => throw _privateConstructorUsedError;
  int? get diplomacyCycles => throw _privateConstructorUsedError;
  bool? get pollutingPaused => throw _privateConstructorUsedError;
  bool get addResources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedBuildingTileCopyWith<SavedBuildingTile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedBuildingTileCopyWith<$Res> {
  factory $SavedBuildingTileCopyWith(
          SavedBuildingTile value, $Res Function(SavedBuildingTile) then) =
      _$SavedBuildingTileCopyWithImpl<$Res, SavedBuildingTile>;
  @useResult
  $Res call(
      {int buildingId,
      TilePosition position,
      double constructionTimeElapsed,
      double? cleaningTimeElapsed,
      bool? cleaningPaused,
      int? diplomacyCycles,
      bool? pollutingPaused,
      bool addResources});

  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class _$SavedBuildingTileCopyWithImpl<$Res, $Val extends SavedBuildingTile>
    implements $SavedBuildingTileCopyWith<$Res> {
  _$SavedBuildingTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildingId = null,
    Object? position = null,
    Object? constructionTimeElapsed = null,
    Object? cleaningTimeElapsed = freezed,
    Object? cleaningPaused = freezed,
    Object? diplomacyCycles = freezed,
    Object? pollutingPaused = freezed,
    Object? addResources = null,
  }) {
    return _then(_value.copyWith(
      buildingId: null == buildingId
          ? _value.buildingId
          : buildingId // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      constructionTimeElapsed: null == constructionTimeElapsed
          ? _value.constructionTimeElapsed
          : constructionTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
      cleaningTimeElapsed: freezed == cleaningTimeElapsed
          ? _value.cleaningTimeElapsed
          : cleaningTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double?,
      cleaningPaused: freezed == cleaningPaused
          ? _value.cleaningPaused
          : cleaningPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
      diplomacyCycles: freezed == diplomacyCycles
          ? _value.diplomacyCycles
          : diplomacyCycles // ignore: cast_nullable_to_non_nullable
              as int?,
      pollutingPaused: freezed == pollutingPaused
          ? _value.pollutingPaused
          : pollutingPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
      addResources: null == addResources
          ? _value.addResources
          : addResources // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TilePositionCopyWith<$Res> get position {
    return $TilePositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedGameObjectImplCopyWith<$Res>
    implements $SavedBuildingTileCopyWith<$Res> {
  factory _$$SavedGameObjectImplCopyWith(_$SavedGameObjectImpl value,
          $Res Function(_$SavedGameObjectImpl) then) =
      __$$SavedGameObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int buildingId,
      TilePosition position,
      double constructionTimeElapsed,
      double? cleaningTimeElapsed,
      bool? cleaningPaused,
      int? diplomacyCycles,
      bool? pollutingPaused,
      bool addResources});

  @override
  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$SavedGameObjectImplCopyWithImpl<$Res>
    extends _$SavedBuildingTileCopyWithImpl<$Res, _$SavedGameObjectImpl>
    implements _$$SavedGameObjectImplCopyWith<$Res> {
  __$$SavedGameObjectImplCopyWithImpl(
      _$SavedGameObjectImpl _value, $Res Function(_$SavedGameObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildingId = null,
    Object? position = null,
    Object? constructionTimeElapsed = null,
    Object? cleaningTimeElapsed = freezed,
    Object? cleaningPaused = freezed,
    Object? diplomacyCycles = freezed,
    Object? pollutingPaused = freezed,
    Object? addResources = null,
  }) {
    return _then(_$SavedGameObjectImpl(
      buildingId: null == buildingId
          ? _value.buildingId
          : buildingId // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      constructionTimeElapsed: null == constructionTimeElapsed
          ? _value.constructionTimeElapsed
          : constructionTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
      cleaningTimeElapsed: freezed == cleaningTimeElapsed
          ? _value.cleaningTimeElapsed
          : cleaningTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double?,
      cleaningPaused: freezed == cleaningPaused
          ? _value.cleaningPaused
          : cleaningPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
      diplomacyCycles: freezed == diplomacyCycles
          ? _value.diplomacyCycles
          : diplomacyCycles // ignore: cast_nullable_to_non_nullable
              as int?,
      pollutingPaused: freezed == pollutingPaused
          ? _value.pollutingPaused
          : pollutingPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
      addResources: null == addResources
          ? _value.addResources
          : addResources // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedGameObjectImpl implements _SavedGameObject {
  const _$SavedGameObjectImpl(
      {required this.buildingId,
      required this.position,
      required this.constructionTimeElapsed,
      this.cleaningTimeElapsed,
      this.cleaningPaused,
      this.diplomacyCycles,
      this.pollutingPaused,
      this.addResources = true});

  factory _$SavedGameObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedGameObjectImplFromJson(json);

  @override
  final int buildingId;
  @override
  final TilePosition position;
  @override
  final double constructionTimeElapsed;
  @override
  final double? cleaningTimeElapsed;
  @override
  final bool? cleaningPaused;
  @override
  final int? diplomacyCycles;
  @override
  final bool? pollutingPaused;
  @override
  @JsonKey()
  final bool addResources;

  @override
  String toString() {
    return 'SavedBuildingTile(buildingId: $buildingId, position: $position, constructionTimeElapsed: $constructionTimeElapsed, cleaningTimeElapsed: $cleaningTimeElapsed, cleaningPaused: $cleaningPaused, diplomacyCycles: $diplomacyCycles, pollutingPaused: $pollutingPaused, addResources: $addResources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedGameObjectImpl &&
            (identical(other.buildingId, buildingId) ||
                other.buildingId == buildingId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(
                    other.constructionTimeElapsed, constructionTimeElapsed) ||
                other.constructionTimeElapsed == constructionTimeElapsed) &&
            (identical(other.cleaningTimeElapsed, cleaningTimeElapsed) ||
                other.cleaningTimeElapsed == cleaningTimeElapsed) &&
            (identical(other.cleaningPaused, cleaningPaused) ||
                other.cleaningPaused == cleaningPaused) &&
            (identical(other.diplomacyCycles, diplomacyCycles) ||
                other.diplomacyCycles == diplomacyCycles) &&
            (identical(other.pollutingPaused, pollutingPaused) ||
                other.pollutingPaused == pollutingPaused) &&
            (identical(other.addResources, addResources) ||
                other.addResources == addResources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      buildingId,
      position,
      constructionTimeElapsed,
      cleaningTimeElapsed,
      cleaningPaused,
      diplomacyCycles,
      pollutingPaused,
      addResources);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedGameObjectImplCopyWith<_$SavedGameObjectImpl> get copyWith =>
      __$$SavedGameObjectImplCopyWithImpl<_$SavedGameObjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedGameObjectImplToJson(
      this,
    );
  }
}

abstract class _SavedGameObject implements SavedBuildingTile {
  const factory _SavedGameObject(
      {required final int buildingId,
      required final TilePosition position,
      required final double constructionTimeElapsed,
      final double? cleaningTimeElapsed,
      final bool? cleaningPaused,
      final int? diplomacyCycles,
      final bool? pollutingPaused,
      final bool addResources}) = _$SavedGameObjectImpl;

  factory _SavedGameObject.fromJson(Map<String, dynamic> json) =
      _$SavedGameObjectImpl.fromJson;

  @override
  int get buildingId;
  @override
  TilePosition get position;
  @override
  double get constructionTimeElapsed;
  @override
  double? get cleaningTimeElapsed;
  @override
  bool? get cleaningPaused;
  @override
  int? get diplomacyCycles;
  @override
  bool? get pollutingPaused;
  @override
  bool get addResources;
  @override
  @JsonKey(ignore: true)
  _$$SavedGameObjectImplCopyWith<_$SavedGameObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavedCleanupTile _$SavedCleanupTileFromJson(Map<String, dynamic> json) {
  return _SavedCleanupTile.fromJson(json);
}

/// @nodoc
mixin _$SavedCleanupTile {
  TilePosition get position => throw _privateConstructorUsedError;
  double get cleaningTimeElapsed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedCleanupTileCopyWith<SavedCleanupTile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedCleanupTileCopyWith<$Res> {
  factory $SavedCleanupTileCopyWith(
          SavedCleanupTile value, $Res Function(SavedCleanupTile) then) =
      _$SavedCleanupTileCopyWithImpl<$Res, SavedCleanupTile>;
  @useResult
  $Res call({TilePosition position, double cleaningTimeElapsed});

  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class _$SavedCleanupTileCopyWithImpl<$Res, $Val extends SavedCleanupTile>
    implements $SavedCleanupTileCopyWith<$Res> {
  _$SavedCleanupTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? cleaningTimeElapsed = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      cleaningTimeElapsed: null == cleaningTimeElapsed
          ? _value.cleaningTimeElapsed
          : cleaningTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TilePositionCopyWith<$Res> get position {
    return $TilePositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedCleanupTileImplCopyWith<$Res>
    implements $SavedCleanupTileCopyWith<$Res> {
  factory _$$SavedCleanupTileImplCopyWith(_$SavedCleanupTileImpl value,
          $Res Function(_$SavedCleanupTileImpl) then) =
      __$$SavedCleanupTileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TilePosition position, double cleaningTimeElapsed});

  @override
  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$SavedCleanupTileImplCopyWithImpl<$Res>
    extends _$SavedCleanupTileCopyWithImpl<$Res, _$SavedCleanupTileImpl>
    implements _$$SavedCleanupTileImplCopyWith<$Res> {
  __$$SavedCleanupTileImplCopyWithImpl(_$SavedCleanupTileImpl _value,
      $Res Function(_$SavedCleanupTileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? cleaningTimeElapsed = null,
  }) {
    return _then(_$SavedCleanupTileImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      cleaningTimeElapsed: null == cleaningTimeElapsed
          ? _value.cleaningTimeElapsed
          : cleaningTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedCleanupTileImpl implements _SavedCleanupTile {
  const _$SavedCleanupTileImpl(
      {required this.position, required this.cleaningTimeElapsed});

  factory _$SavedCleanupTileImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedCleanupTileImplFromJson(json);

  @override
  final TilePosition position;
  @override
  final double cleaningTimeElapsed;

  @override
  String toString() {
    return 'SavedCleanupTile(position: $position, cleaningTimeElapsed: $cleaningTimeElapsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedCleanupTileImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.cleaningTimeElapsed, cleaningTimeElapsed) ||
                other.cleaningTimeElapsed == cleaningTimeElapsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, cleaningTimeElapsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedCleanupTileImplCopyWith<_$SavedCleanupTileImpl> get copyWith =>
      __$$SavedCleanupTileImplCopyWithImpl<_$SavedCleanupTileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedCleanupTileImplToJson(
      this,
    );
  }
}

abstract class _SavedCleanupTile implements SavedCleanupTile {
  const factory _SavedCleanupTile(
      {required final TilePosition position,
      required final double cleaningTimeElapsed}) = _$SavedCleanupTileImpl;

  factory _SavedCleanupTile.fromJson(Map<String, dynamic> json) =
      _$SavedCleanupTileImpl.fromJson;

  @override
  TilePosition get position;
  @override
  double get cleaningTimeElapsed;
  @override
  @JsonKey(ignore: true)
  _$$SavedCleanupTileImplCopyWith<_$SavedCleanupTileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavedDipomaticMissionTile _$SavedDipomaticMissionTileFromJson(
    Map<String, dynamic> json) {
  return _SavedDipomaticMissionTile.fromJson(json);
}

/// @nodoc
mixin _$SavedDipomaticMissionTile {
  TilePosition get position => throw _privateConstructorUsedError;
  double get missionTimeElapsed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedDipomaticMissionTileCopyWith<SavedDipomaticMissionTile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedDipomaticMissionTileCopyWith<$Res> {
  factory $SavedDipomaticMissionTileCopyWith(SavedDipomaticMissionTile value,
          $Res Function(SavedDipomaticMissionTile) then) =
      _$SavedDipomaticMissionTileCopyWithImpl<$Res, SavedDipomaticMissionTile>;
  @useResult
  $Res call({TilePosition position, double missionTimeElapsed});

  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class _$SavedDipomaticMissionTileCopyWithImpl<$Res,
        $Val extends SavedDipomaticMissionTile>
    implements $SavedDipomaticMissionTileCopyWith<$Res> {
  _$SavedDipomaticMissionTileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? missionTimeElapsed = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      missionTimeElapsed: null == missionTimeElapsed
          ? _value.missionTimeElapsed
          : missionTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TilePositionCopyWith<$Res> get position {
    return $TilePositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedDipomaticMissionTileImplCopyWith<$Res>
    implements $SavedDipomaticMissionTileCopyWith<$Res> {
  factory _$$SavedDipomaticMissionTileImplCopyWith(
          _$SavedDipomaticMissionTileImpl value,
          $Res Function(_$SavedDipomaticMissionTileImpl) then) =
      __$$SavedDipomaticMissionTileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TilePosition position, double missionTimeElapsed});

  @override
  $TilePositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$SavedDipomaticMissionTileImplCopyWithImpl<$Res>
    extends _$SavedDipomaticMissionTileCopyWithImpl<$Res,
        _$SavedDipomaticMissionTileImpl>
    implements _$$SavedDipomaticMissionTileImplCopyWith<$Res> {
  __$$SavedDipomaticMissionTileImplCopyWithImpl(
      _$SavedDipomaticMissionTileImpl _value,
      $Res Function(_$SavedDipomaticMissionTileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? missionTimeElapsed = null,
  }) {
    return _then(_$SavedDipomaticMissionTileImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as TilePosition,
      missionTimeElapsed: null == missionTimeElapsed
          ? _value.missionTimeElapsed
          : missionTimeElapsed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedDipomaticMissionTileImpl implements _SavedDipomaticMissionTile {
  const _$SavedDipomaticMissionTileImpl(
      {required this.position, required this.missionTimeElapsed});

  factory _$SavedDipomaticMissionTileImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedDipomaticMissionTileImplFromJson(json);

  @override
  final TilePosition position;
  @override
  final double missionTimeElapsed;

  @override
  String toString() {
    return 'SavedDipomaticMissionTile(position: $position, missionTimeElapsed: $missionTimeElapsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedDipomaticMissionTileImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.missionTimeElapsed, missionTimeElapsed) ||
                other.missionTimeElapsed == missionTimeElapsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, missionTimeElapsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedDipomaticMissionTileImplCopyWith<_$SavedDipomaticMissionTileImpl>
      get copyWith => __$$SavedDipomaticMissionTileImplCopyWithImpl<
          _$SavedDipomaticMissionTileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedDipomaticMissionTileImplToJson(
      this,
    );
  }
}

abstract class _SavedDipomaticMissionTile implements SavedDipomaticMissionTile {
  const factory _SavedDipomaticMissionTile(
          {required final TilePosition position,
          required final double missionTimeElapsed}) =
      _$SavedDipomaticMissionTileImpl;

  factory _SavedDipomaticMissionTile.fromJson(Map<String, dynamic> json) =
      _$SavedDipomaticMissionTileImpl.fromJson;

  @override
  TilePosition get position;
  @override
  double get missionTimeElapsed;
  @override
  @JsonKey(ignore: true)
  _$$SavedDipomaticMissionTileImplCopyWith<_$SavedDipomaticMissionTileImpl>
      get copyWith => throw _privateConstructorUsedError;
}

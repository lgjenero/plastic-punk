// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_saved_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateSavedDataImpl _$$GameStateSavedDataImplFromJson(
        Map<String, dynamic> json) =>
    _$GameStateSavedDataImpl(
      level: json['level'] as int,
      slot: json['slot'] as String,
      name: json['name'] as String?,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      buildings: (json['buildings'] as List<dynamic>)
          .map((e) => SavedBuildingTile.fromJson(e as Map<String, dynamic>))
          .toList(),
      cleanupTiles: (json['cleanupTiles'] as List<dynamic>)
          .map((e) => SavedCleanupTile.fromJson(e as Map<String, dynamic>))
          .toList(),
      diplomaticMissionTiles: (json['diplomaticMissionTiles'] as List<dynamic>)
          .map((e) =>
              SavedDipomaticMissionTile.fromJson(e as Map<String, dynamic>))
          .toList(),
      resources: (json['resources'] as List<dynamic>)
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableResources: (json['availableResources'] as List<dynamic>)
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => $enumDecode(_$TechnologyTypeEnumMap, e))
          .toSet(),
      tilesToClean: (json['tilesToClean'] as List<dynamic>)
          .map((e) => TilePosition.fromJson(e as Map<String, dynamic>))
          .toSet(),
      score: $enumDecode(_$GameScoreEnumMap, json['score']),
      gameSpeed: (json['gameSpeed'] as num).toDouble(),
      useAutomaticCleanup: json['useAutomaticCleanup'] as bool,
      pollutedTiles: (json['pollutedTiles'] as List<dynamic>)
          .map((e) => TilePosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      templateTiles: (json['templateTiles'] as List<dynamic>)
          .map((e) => e as int?)
          .toList(),
    );

Map<String, dynamic> _$$GameStateSavedDataImplToJson(
        _$GameStateSavedDataImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'slot': instance.slot,
      'name': instance.name,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'buildings': instance.buildings.map((e) => e.toJson()).toList(),
      'cleanupTiles': instance.cleanupTiles.map((e) => e.toJson()).toList(),
      'diplomaticMissionTiles':
          instance.diplomaticMissionTiles.map((e) => e.toJson()).toList(),
      'resources': instance.resources.map((e) => e.toJson()).toList(),
      'availableResources':
          instance.availableResources.map((e) => e.toJson()).toList(),
      'technologies': instance.technologies
          .map((e) => _$TechnologyTypeEnumMap[e]!)
          .toList(),
      'tilesToClean': instance.tilesToClean.map((e) => e.toJson()).toList(),
      'score': _$GameScoreEnumMap[instance.score]!,
      'gameSpeed': instance.gameSpeed,
      'useAutomaticCleanup': instance.useAutomaticCleanup,
      'pollutedTiles': instance.pollutedTiles.map((e) => e.toJson()).toList(),
      'templateTiles': instance.templateTiles,
    };

const _$TechnologyTypeEnumMap = {
  TechnologyType.plasticsReduce: 'plasticsReduce',
  TechnologyType.plasticsReuse: 'plasticsReuse',
  TechnologyType.plasticsRecycle: 'plasticsRecycle',
  TechnologyType.waterTreatment: 'waterTreatment',
  TechnologyType.waterCleanup: 'waterCleanup',
  TechnologyType.microplasticsFilter: 'microplasticsFilter',
  TechnologyType.microplasticsCleanup: 'microplasticsCleanup',
};

const _$GameScoreEnumMap = {
  GameScore.notStarted: 'notStarted',
  GameScore.playing: 'playing',
  GameScore.lost: 'lost',
  GameScore.won: 'won',
};

_$SavedGameObjectImpl _$$SavedGameObjectImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedGameObjectImpl(
      buildingId: json['buildingId'] as int,
      position: TilePosition.fromJson(json['position'] as Map<String, dynamic>),
      constructionTimeElapsed:
          (json['constructionTimeElapsed'] as num).toDouble(),
      cleaningTimeElapsed: (json['cleaningTimeElapsed'] as num?)?.toDouble(),
      cleaningPaused: json['cleaningPaused'] as bool?,
      diplomacyCycles: json['diplomacyCycles'] as int?,
      pollutingPaused: json['pollutingPaused'] as bool?,
      addResources: json['addResources'] as bool? ?? true,
    );

Map<String, dynamic> _$$SavedGameObjectImplToJson(
        _$SavedGameObjectImpl instance) =>
    <String, dynamic>{
      'buildingId': instance.buildingId,
      'position': instance.position.toJson(),
      'constructionTimeElapsed': instance.constructionTimeElapsed,
      'cleaningTimeElapsed': instance.cleaningTimeElapsed,
      'cleaningPaused': instance.cleaningPaused,
      'diplomacyCycles': instance.diplomacyCycles,
      'pollutingPaused': instance.pollutingPaused,
      'addResources': instance.addResources,
    };

_$SavedCleanupTileImpl _$$SavedCleanupTileImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedCleanupTileImpl(
      position: TilePosition.fromJson(json['position'] as Map<String, dynamic>),
      cleaningTimeElapsed: (json['cleaningTimeElapsed'] as num).toDouble(),
    );

Map<String, dynamic> _$$SavedCleanupTileImplToJson(
        _$SavedCleanupTileImpl instance) =>
    <String, dynamic>{
      'position': instance.position.toJson(),
      'cleaningTimeElapsed': instance.cleaningTimeElapsed,
    };

_$SavedDipomaticMissionTileImpl _$$SavedDipomaticMissionTileImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedDipomaticMissionTileImpl(
      position: TilePosition.fromJson(json['position'] as Map<String, dynamic>),
      missionTimeElapsed: (json['missionTimeElapsed'] as num).toDouble(),
    );

Map<String, dynamic> _$$SavedDipomaticMissionTileImplToJson(
        _$SavedDipomaticMissionTileImpl instance) =>
    <String, dynamic>{
      'position': instance.position.toJson(),
      'missionTimeElapsed': instance.missionTimeElapsed,
    };

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/data/game_state_data.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';

part 'game_state_saved_data.freezed.dart';
part 'game_state_saved_data.g.dart';

enum GameStateSavedDataSlots {
  slot1,
  slot2,
  slot3,
  slot4;
}

@freezed
class GameStateSavedData with _$GameStateSavedData {
  const factory GameStateSavedData({
    required int level,
    required String slot,
    String? name,
    @DateTimeConverter() DateTime? createdAt,
    required List<SavedBuildingTile> buildings,
    required List<SavedCleanupTile> cleanupTiles,
    required List<SavedDipomaticMissionTile> diplomaticMissionTiles,
    required List<Resource> resources,
    required List<Resource> availableResources,
    required Set<TechnologyType> technologies,
    required Set<TilePosition> tilesToClean,
    required GameScore score,
    required double gameSpeed,
    required bool useAutomaticCleanup,
    required List<TilePosition> pollutedTiles,
    required List<int?> templateTiles,
  }) = _GameStateSavedData;

  factory GameStateSavedData.fromJson(Map<String, dynamic> json) => _$GameStateSavedDataFromJson(json);
}

@freezed
class SavedBuildingTile with _$SavedBuildingTile {
  const factory SavedBuildingTile({
    required int buildingId,
    required TilePosition position,
    required double constructionTimeElapsed,
    double? cleaningTimeElapsed,
    bool? cleaningPaused,
    int? diplomacyCycles,
    bool? pollutingPaused,
    @Default(true) bool addResources,
  }) = _SavedGameObject;

  factory SavedBuildingTile.fromJson(Map<String, dynamic> json) => _$SavedBuildingTileFromJson(json);
}

@freezed
class SavedCleanupTile with _$SavedCleanupTile {
  const factory SavedCleanupTile({
    required TilePosition position,
    required double cleaningTimeElapsed,
  }) = _SavedCleanupTile;

  factory SavedCleanupTile.fromJson(Map<String, dynamic> json) => _$SavedCleanupTileFromJson(json);
}

@freezed
class SavedDipomaticMissionTile with _$SavedDipomaticMissionTile {
  const factory SavedDipomaticMissionTile({
    required TilePosition position,
    required double missionTimeElapsed,
  }) = _SavedDipomaticMissionTile;

  factory SavedDipomaticMissionTile.fromJson(Map<String, dynamic> json) => _$SavedDipomaticMissionTileFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime?, Object?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(Object? data) {
    try {
      if (data is String) {
        return DateTime.tryParse(data);
      } else if (data is num) {
        if (data > 100000000000000) {
          return DateTime.fromMicrosecondsSinceEpoch(data.toInt());
        }
        return DateTime.fromMillisecondsSinceEpoch(data.toInt());
      } else if (data is Timestamp) {
        return data.toDate();
      } else if (data is DateTime) {
        return data;
      }
    } catch (e) {
      log('DateTimeConverter fromJson: $e');
    }
    return null;
  }

  @override
  Timestamp? toJson(DateTime? data) => data != null ? Timestamp.fromDate(data) : null;
}

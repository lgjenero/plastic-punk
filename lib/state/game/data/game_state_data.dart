import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/logic/achievement_tree.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';

part 'game_state_data.freezed.dart';

enum GameScore {
  notStarted,
  playing,
  lost,
  won,
}

@freezed
class GameStateData with _$GameStateData {
  const factory GameStateData({
    required bool initialised,
    required List<GameObject> objects,
    required Map<ResourceType, Resource> resources,
    required Map<ResourceType, Resource> availableResources,
    required Set<TechnologyType> technologies,
    BuildingNode? buildingToBuild,
    required Set<TilePosition> tilesToClean,
    required int transportsState,
    Message? message,
    AchievementNode? achievement,
    required GameScore score,
    required double gameSpeed,
    required bool useAutomaticCleanup,
    BuildingTile? selectedBuilding,
  }) = _GameStateData;
}

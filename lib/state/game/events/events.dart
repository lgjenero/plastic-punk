import 'package:collection/collection.dart';
import 'package:plastic_punk/state/game/events/event.dart';
import 'package:plastic_punk/state/game/logic/achievement_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

abstract class Events {
  static final list = [
    Event(
      tag: EventTag.buildingBuilt,
      data: {'buildingId': AppTiles.townHall},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '1'),
    ),
    Event(
      tag: EventTag.buildingBuilt,
      data: {'buildingId': AppTiles.garden},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '2'),
    ),
    Event(
      tag: EventTag.buildingBuilt,
      data: {'buildingId': AppTiles.house},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '3'),
    ),
    Event(
      tag: EventTag.technologyResearched,
      data: {'type': TechnologyType.plasticsReduce},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '4'),
    ),
    Event(
      tag: EventTag.buildingBuilt,
      data: {'buildingId': AppTiles.plasticRecycling},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '5'),
    ),
    Event(
      tag: EventTag.buildingBuilt,
      data: {'buildingId': AppTiles.waterTreatment},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '6'),
    ),
    Event(
      tag: EventTag.waterTilesCleaned,
      data: {},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '7'),
    ),
    Event(
      tag: EventTag.diplomacyExecuted,
      data: {},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '8'),
    ),
    Event(
      tag: EventTag.levelCompleted,
      data: {'level': 9},
      achievement: AchievementTree.nodes.firstWhereOrNull((e) => e.id == '9'),
    ),
  ];
}

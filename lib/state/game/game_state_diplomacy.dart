// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateDiplomacy on GameState {
  void initiateDiplomacy() {
    // find enemy buildings
    final possibleTiles = <TileData>{};
    final enemyBuildings = state.objects.whereType<BadTownHall>();
    for (final building in enemyBuildings) {
      final tile = mapComponent.tileMap
          .getTileData(layerId: AppLayers.terrain, x: building.tilePosition.x, y: building.tilePosition.y);
      if (tile == null) continue;

      possibleTiles.add(TileData(layerId: AppLayers.terrain, position: building.tilePosition, data: tile));
    }

    if (possibleTiles.isEmpty) {
      scheduleMicrotask(() {
        showMessage(Messages.nowhereToHaveDiplomacy);
      });
      return;
    }

    // if available tiles, highlight them
    for (final tile in possibleTiles) {
      add(DiplomacyPlacementTile(tilePosition: tile.position, isPaused: false));
    }
    _game.overlays.add(DiplomacyOverlay.overlayId);
  }

  void cancelDiplomacy() {
    final diplomacyOverlays = state.objects.whereType<DiplomacyPlacementTile>();
    for (final overlay in diplomacyOverlays) {
      overlay.remove(this);
    }

    _game.overlays.remove(DiplomacyOverlay.overlayId);
  }

  void startDiplomaticMission(TilePosition tilePosition) {
    final diplomacyOverlays = state.objects.whereType<DiplomacyPlacementTile>();
    for (final overlay in diplomacyOverlays) {
      overlay.remove(this);
    }

    final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: tilePosition.x, y: tilePosition.y);
    if (tile == null) throw Exception('Tile not found: $tilePosition');

    final buildingTile = state.objects
        .whereType<BuildingTile>()
        .firstWhereOrNull((e) => e.tilePosition == tilePosition && AppTiles.enemyBuildingTiles.contains(e.buildingId));
    if (buildingTile == null) throw Exception('Building not found: $tilePosition');

    final mission = DiplomaticMissionTile(tilePosition: tilePosition, isPaused: false);
    add(mission);
    _game.overlays.remove(DiplomacyOverlay.overlayId);
  }

  void executeDiplomaticMission(TilePosition tilePosition) {
    final missionTile =
        state.objects.whereType<DiplomaticMissionTile>().firstWhereOrNull((e) => e.tilePosition == tilePosition);
    if (missionTile == null) throw Exception('Diplomatic mission not found: $tilePosition');
    missionTile.remove(this);

    print('Executing diplomacy');

    // execute the diplomacy through the education center
    final educationCenter =
        state.objects.whereType<EducationCentreTile>().firstWhereOrNull((e) => e.canExecuteDiplomacy);
    if (educationCenter == null) {
      print('No education center found');
      return;
    }
    educationCenter.diplomacyExecuted();

    final buildindTile = state.objects.whereType<BadTownHall>().firstWhereOrNull((e) => e.tilePosition == tilePosition);
    if (buildindTile == null) throw Exception('Bad town hall not found: $tilePosition');

    final tiles =
        FloodFiller(_mapComponent, AppLayers.terrain, {}, AppTiles.enemyBuildingTiles, {}).getFilledArea(tilePosition);

    for (final tile in tiles) {
      final building = state.objects.whereType<BuildingTile>().firstWhereOrNull((e) => e.tilePosition == tile);
      if (building == null) continue;
      building.remove(this);

      // change the buildings but do not add resources
      if (building.buildingId == AppTiles.badHousing) {
        add(HouseTile(tilePosition: tile, isPaused: false, startsConstructed: true, addResources: false));
      } else if (building.buildingId == AppTiles.plasticsFactory) {
        add(PlasticsRecyclingTile(tilePosition: tile, isPaused: false, startsConstructed: true, addResources: false)
          ..pauseCleaning = true);
      } else if (building.buildingId == AppTiles.badTownHall) {
        add(TownHallTile(tilePosition: tile, isPaused: false, startsConstructed: true, addResources: false)
          ..pauseCleaning = true);
      } else if (AppTiles.pollutedTransportationTiles.contains(building.buildingId)) {
        add(TracksTile(tilePosition: tile, isPaused: false, startsConstructed: true, addResources: false));
      } else {
        throw Exception('Unknown building id: ${building.buildingId}');
      }
    }
  }
}

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateDiplomacy on GameState {
  void initiateDiplomacy() {
    // ask where to build it
    // find enemy buildings
    final possibleTiles = <TileData>{};
    final enemyBuildings =
        state.objects.whereType<BuildingTile>().where((e) => AppTiles.enemyBuildingTiles.contains(e.buildingId));
    for (final building in enemyBuildings) {
      final tile = mapComponent.tileMap
          .getTileData(layerId: AppLayers.terrain, x: building.tilePosition.x, y: building.tilePosition.y);
      if (tile == null) continue;

      possibleTiles.add(TileData(layerId: AppLayers.terrain, position: building.tilePosition, data: tile));
    }

    print('possibleTiles: $possibleTiles');

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
}

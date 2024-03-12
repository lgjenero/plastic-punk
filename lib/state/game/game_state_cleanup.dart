// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateCleanup on GameState {
  bool _tapCleanup(TilePosition tilePosition) {
    final mapWidth = mapComponent.tileMap.map.width;
    final mapHeight = mapComponent.tileMap.map.height;
    if (tilePosition.x < 0 || tilePosition.x >= mapWidth) return false;
    if (tilePosition.y < 0 || tilePosition.y >= mapHeight) return false;

    final tile = mapComponent.tileMap.getTileData(
      layerId: AppLayers.terrain,
      x: tilePosition.x.toInt(),
      y: tilePosition.y.toInt(),
    );

    if (tile == null) return false;

    // cleanup tile?
    if (state.tilesToClean.contains(tilePosition)) {
      state = state.copyWith(tilesToClean: {...state.tilesToClean}..remove(tilePosition));
      final toCleanObject =
          state.objects.whereType<CleanupTile>().firstWhereOrNull((e) => e.tilePosition == tilePosition);
      toCleanObject?.remove(this);

      return false;
    }

    final tryGround = _tryGroundCleanup(tilePosition, tile.tile);
    if (tryGround) return true;

    final tryWater = _tryWaterCleanup(tilePosition, tile.tile);
    if (tryWater) return true;

    return false;
  }

  bool _tryGroundCleanup(TilePosition tilePos, int tileId) {
    final isGroundPolluted = AppTiles.groundPollutedTiles.contains(tileId);
    if (!isGroundPolluted) return false;

    final hasCapability =
        objects.whereType<BuildingTile>().any((e) => (e is TownHallTile || e is PlasticsEnergyTile) && e.constructed);
    if (!hasCapability) return false;

    final neighbours = AppMath.getNeighbouringTile(
      tilePos,
      AppLayers.terrain,
      mapComponent,
    );

    final canBeReached = neighbours.any(
      (neighbour) {
        return AppTiles.grassTiles.contains(neighbour.data.tile) ||
            AppTiles.forestTiles.contains(neighbour.data.tile) ||
            AppTiles.buildingTiles.contains(neighbour.data.tile);
      },
    );

    if (!canBeReached) return false;

    state = state.copyWith(tilesToClean: state.tilesToClean..add(tilePos));

    add(SelectedTile(type: SelectedTileType.toBeCleaned, tilePosition: tilePos, isPaused: false));
    state = state.copyWith(tilesToClean: {...state.tilesToClean, tilePos});
    return true;
  }

  bool _tryWaterCleanup(TilePosition tilePos, int tileId) {
    final isWaterPolluted = AppTiles.waterPollutedTiles.contains(tileId);
    if (!isWaterPolluted) return false;

    final hasCapability = objects.whereType<BuildingTile>().any((e) => (e is WaterCleanupTile) && e.constructed);
    if (!hasCapability) return false;

    final neighbours = AppMath.getNeighbouringTile(
      tilePos,
      AppLayers.terrain,
      mapComponent,
    );

    final canBeReached = neighbours.any(
      (neighbour) {
        return AppTiles.grassShoreTiles.contains(neighbour.data.tile) ||
            AppTiles.buildingTiles.contains(neighbour.data.tile) ||
            AppTiles.waterTiles.contains(neighbour.data.tile);
      },
    );

    if (!canBeReached) return false;

    state = state.copyWith(tilesToClean: state.tilesToClean..add(tilePos));
    add(SelectedTile(type: SelectedTileType.toBeCleaned, tilePosition: tilePos, isPaused: false));
    return true;
  }

  TilePosition? getTileToClean(bool waterTiles) {
    final tilesToClean = state.tilesToClean;
    for (final tile in tilesToClean) {
      final tileData = _mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: tile.x, y: tile.y);
      if (tileData == null) continue;

      if (waterTiles) {
        if (AppTiles.waterTiles.contains(tileData.tile)) {
          return tile;
        }
      } else {
        if (AppTiles.grassTiles.contains(tileData.tile) || AppTiles.forestTiles.contains(tileData.tile)) {
          return tile;
        }
      }
    }

    return null;
  }

  void cleanTile(TilePosition tile) {
    final tileData = _mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: tile.x, y: tile.y);
    if (tileData == null) return;

    state = state.copyWith(tilesToClean: <TilePosition>{...state.tilesToClean}..remove(tile));
    final toCleanObject = state.objects.whereType<SelectedTile>().firstWhereOrNull((e) => e.tilePosition == tile);
    toCleanObject?.remove(this);

    if (AppTiles.waterPollutedTiles.contains(tileData.tile) || AppTiles.groundPollutedTiles.contains(tileData.tile)) {
      add(CleanupTile(tilePosition: tile, isPaused: false));
    }
  }
}

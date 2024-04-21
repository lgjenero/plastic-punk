// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStatePollution on GameState {
  void addPollution(TilePosition position) {
    final tile = _mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: position.x, y: position.y);
    if (tile == null) throw Exception('Tile not found: $position');

    final templateTile = _mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: position.x, y: position.y);
    if (templateTile == null) throw Exception('Template tile not found: $position');

    final plutionTileId = AppTiles.tileToPollution(templateTile.tile);
    final object = state.objects.whereType<BuildingTile>().firstWhereOrNull((e) => e.tilePosition == position);
    object?.remove(this);

    _mapComponent.tileMap.setTileData(
      layerId: AppLayers.terrain,
      x: position.x,
      y: position.y,
      gid: Gid(plutionTileId, const Flips.defaults()),
    );

    final isWater = AppTiles.waterTiles.contains(templateTile.tile);
    if (isWater) {
      _removeWaterAnimation(position);
      _addWaterPollutionAnimation(position);
    }
  }

  void removePollution(TilePosition position, {bool addAnimation = true}) {
    final terrainTile = _mapComponent.tileMap.getTileData(
      layerId: AppLayers.terrain,
      x: position.x,
      y: position.y,
    );
    if (!AppTiles.pollutionTiles.contains(terrainTile?.tile)) return;

    final tile = mapComponent.tileMap.getTileData(
      layerId: AppLayers.template,
      x: position.x,
      y: position.y,
    );
    if (tile != null) {
      mapComponent.tileMap.setTileData(
        layerId: AppLayers.terrain,
        x: position.x,
        y: position.y,
        gid: tile,
      );
    } else {
      throw Exception('No template tile found at ${position.x}, ${position.y}');
    }

    final isWater = AppTiles.waterTiles.contains(tile.tile);
    if (isWater) {
      _removeWaterPollutionAnimation(position);
      if (addAnimation) _addWaterAnimation(position);
    }
  }
}

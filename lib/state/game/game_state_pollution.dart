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
  }
}

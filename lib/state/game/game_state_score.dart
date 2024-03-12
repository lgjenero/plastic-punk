// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

enum GameScore {
  notStarted,
  playing,
  lost,
  won,
}

extension GameStateScore on GameState {
  void _checkScore() {
    if (state.score == GameScore.notStarted) {
      final townHallBuilt = objects.whereType<BuildingTile>().any((e) => e is TownHallTile && e.constructed);
      if (townHallBuilt) state = state.copyWith(score: GameScore.playing);
      return;
    }

    if (state.score != GameScore.playing) return;

    scheduleMicrotask(() {
      _chekIfPlayerHasBuildings();
      _checkIfThereIsPollution();
    });
  }

  void _chekIfPlayerHasBuildings() async {
    final playerHasBuildings =
        objects.whereType<BuildingTile>().any((e) => !AppTiles.enemyBuildingTiles.contains(e.buildingId));

    if (!playerHasBuildings) {
      state = state.copyWith(score: GameScore.lost);
      _game.overlays.add(GameOver.overlayId);
    }
  }

  void _checkIfThereIsPollution() async {
    for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
      for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
        final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: x, y: y);
        if (tile == null) continue;

        final isPolluted = AppTiles.groundPollutedTiles.contains(tile.tile) ||
            AppTiles.waterPollutedTiles.contains(tile.tile) ||
            AppTiles.enemyBuildingTiles.contains(tile.tile);

        if (isPolluted) return;
      }
    }

    state = state.copyWith(score: GameScore.won);
    _game.overlays.add(GameOver.overlayId);
  }
}

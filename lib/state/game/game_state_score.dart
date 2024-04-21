// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateScore on GameState {
  void _checkScore() {
    if (state.score == GameScore.notStarted) {
      final townHallBuilt = objects.whereType<BuildingTile>().any((e) => e is TownHallTile && e.constructed);
      if (townHallBuilt) state = state.copyWith(score: GameScore.playing);
      return;
    }

    if (state.score != GameScore.playing) return;

    scheduleMicrotask(() {
      final playerHasBuildings = _chekIfPlayerHasBuildings();
      if (!playerHasBuildings) {
        state = state.copyWith(score: GameScore.lost);
        _game.overlays.add(GameOver.overlayId);
        return;
      }

      final levelCompleted = _checkLevelCompleted();
      if (levelCompleted) {
        state = state.copyWith(score: GameScore.won);
        _game.overlays.add(GameOver.overlayId);

        onEvent(Event(tag: EventTag.levelCompleted, data: {'level': level.level}));
      }
    });
  }

  bool _chekIfPlayerHasBuildings() {
    final playerHasBuildings =
        objects.whereType<BuildingTile>().any((e) => !AppTiles.enemyBuildingTiles.contains(e.buildingId));
    return playerHasBuildings;
  }

  bool _checkIfThereIsPollution() {
    for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
      for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
        final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: x, y: y);
        if (tile == null) continue;

        final isPolluted = AppTiles.groundPollutedTiles.contains(tile.tile) ||
            AppTiles.waterPollutedTiles.contains(tile.tile) ||
            AppTiles.enemyBuildingTiles.contains(tile.tile);

        if (isPolluted) return true;
      }
    }

    return false;
  }

  bool _checkLevelCompleted() {
    final levelBuildingsCompleated = level.requiredBuildings.every((levelBuilding) => objects
        .whereType<BuildingTile>()
        .any((building) => building.buildingId == levelBuilding && building.constructed));
    final levelResearchCompleated =
        level.requiredTechnologies.every((levelResearch) => technologies.contains(levelResearch));

    final pollutionOk = !level.requiredCleanup || !_checkIfThereIsPollution();

    return levelBuildingsCompleated && levelResearchCompleated && pollutionOk;
  }

  void gameOver() {
    // mark level as finished
    if (state.score == GameScore.won) {
      ref.read(userServiceProvider.notifier).levelFinished(level.level);
    }

    // navigate back
    final context = _game.buildContext;
    if (context == null) return;
    Navigator.of(context).pop();
  }
}

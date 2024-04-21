// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateSave on GameState {
  void saveGame(String slot, String? name) async {
    bool saved = false;
    try {
      final pollutedTiles = <TilePosition>[];
      for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
        for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
          final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: x, y: y);
          final tileId = tile?.tile;
          if (tileId == null) continue;

          if (!AppTiles.pollutionTiles.contains(tileId)) continue;
          pollutedTiles.add(TilePosition(x: x, y: y));
        }
      }

      final templateTiles = <int?>[];
      for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
        for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
          final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: x, y: y);
          final tileId = tile?.tile;
          templateTiles.add(tileId);
        }
      }

      final saveData = GameStateSavedData(
        level: level.level,
        slot: slot,
        name: name,
        buildings: objects.whereType<BuildingTile>().map((e) {
          return SavedBuildingTile(
            buildingId: e.buildingId,
            position: e.tilePosition,
            constructionTimeElapsed: e.constructionTimeElapsed,
            cleaningTimeElapsed: (e is BuildingCleaningTile) ? e.cleaningTimeElapsed : null,
            cleaningPaused: (e is BuildingCleaningTile) ? e.pauseCleaning : null,
            diplomacyCycles: (e is EducationCentreTile) ? e.diplomacyExecutedCount : null,
            pollutingPaused: (e is BuildingPollutingTile) ? e.pausePollution : null,
            addResources: e.addResources,
          );
        }).toList(),
        cleanupTiles: objects
            .whereType<CleanupTile>()
            .map((e) => SavedCleanupTile(position: e.tilePosition, cleaningTimeElapsed: e.cleaningTimeElapsed))
            .toList(),
        diplomaticMissionTiles: objects
            .whereType<DiplomaticMissionTile>()
            .map((e) => SavedDipomaticMissionTile(position: e.tilePosition, missionTimeElapsed: e.missionTimeElapsed))
            .toList(),
        resources: resources.values.toList(),
        availableResources: availableResources.values.toList(),
        technologies: technologies,
        tilesToClean: tilesToClean,
        score: state.score,
        gameSpeed: state.gameSpeed,
        useAutomaticCleanup: state.useAutomaticCleanup,
        pollutedTiles: pollutedTiles,
        templateTiles: templateTiles,
      );

      _game.overlays.add(LoadingOverlay.overlayId);

      await ref.read(firestoreServiceProvider).saveGame(saveData, slot);
      saved = true;
    } catch (e, s) {
      print('Error saving game: $e\n$s');
    }

    _game.overlays.remove(LoadingOverlay.overlayId);

    showSnackbar(saved ? GameSnackbars.gameSaved() : GameSnackbars.errorSavingGame());
  }

  void loadGame(String slot) async {
    await _initialised.future;

    _game.paused = true;
    _game.overlays.removeAll(_game.overlays.activeOverlays.toList().whereNot((e) => e == Hud.overlayId));
    _game.overlays.add(LoadingOverlay.overlayId);

    GameStateSavedData? saveData;

    try {
      saveData = await ref.read(firestoreServiceProvider).loadGame(slot);
    } catch (e, s) {
      print('Error loading game: $e\n$s');
    }

    if (saveData == null) {
      _game.overlays.remove(LoadingOverlay.overlayId);
      showSnackbar(GameSnackbars.errorLoadingGame());
      return;
    }

    // clear the map
    for (var e in [...objects]) {
      e.remove(this);
    }
    mapComponent.removeAll([...mapComponent.children]);

    // set the tiles
    int templateIdx = 0;
    for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
      for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
        final savedTileId = saveData.templateTiles[templateIdx];
        final isPolluted = saveData.pollutedTiles.contains(TilePosition(x: x, y: y));
        late int? tileId;
        if (savedTileId != null) {
          mapComponent.tileMap.setTileData(
            layerId: AppLayers.template,
            x: x,
            y: y,
            gid: Gid(savedTileId, const Flips.defaults()),
          );
          tileId = savedTileId;
        } else {
          final templateTile = mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: x, y: y);
          tileId = templateTile?.tile;
        }
        if (tileId != null) {
          mapComponent.tileMap.setTileData(
            layerId: AppLayers.terrain,
            x: x,
            y: y,
            gid: isPolluted
                ? Gid(AppTiles.tileToPollution(tileId), const Flips.defaults())
                : Gid(tileId, const Flips.defaults()),
          );
        }

        templateIdx++;
      }
    }

    // set the game state
    state = state.copyWith(
      resources: Map.fromEntries(saveData.resources.map((e) => MapEntry(e.type, e))),
      availableResources: Map.fromEntries(saveData.availableResources.map((e) => MapEntry(e.type, e))),
      technologies: saveData.technologies,
      score: saveData.score,
      gameSpeed: saveData.gameSpeed,
      useAutomaticCleanup: saveData.useAutomaticCleanup,
    );
    updateGameSpeed(saveData.gameSpeed);
    _checkImpact(const Resource(type: ResourceType.impact, amount: 0));

    // need to add objects last
    state = state.copyWith(
      objects: [
        ...saveData.buildings.map((e) => _buildingTileFromSave(e)).whereType<BuildingTile>(),
        ...saveData.cleanupTiles.map((e) =>
            CleanupTile(tilePosition: e.position, isPaused: false)..setCleaningTimeElapsed(e.cleaningTimeElapsed)),
        ...saveData.diplomaticMissionTiles.map((e) => DiplomaticMissionTile(tilePosition: e.position, isPaused: false)
          ..setMissionTimeElapsed(e.missionTimeElapsed)),
      ],
    );

    // add animations
    _initAnimations();

    // set the tiles to clean
    for (final tile in saveData.tilesToClean) {
      _tapCleanup(tile);
    }

    _game.overlays.remove(LoadingOverlay.overlayId);

    _game.paused = false;
    removeAllSnackbars();
    showSnackbar(GameSnackbars.gameLoaded());
  }

  BuildingTile? _buildingTileFromSave(SavedBuildingTile savedBuildingTile) {
    final node = BuildingTree.nodes.firstWhereOrNull((node) => node.id == savedBuildingTile.buildingId);
    if (node == null) return null;

    final building = node.constructor(savedBuildingTile.position, false, savedBuildingTile.addResources)
      ..setConstructionTimeElapsed(savedBuildingTile.constructionTimeElapsed);

    if (building is BuildingCleaningTile) {
      final cleaningTimeElapsed = savedBuildingTile.cleaningTimeElapsed;
      if (cleaningTimeElapsed != null) {
        building.setCleaningTimeElapsed(cleaningTimeElapsed);
      }
      final cleaningPaused = savedBuildingTile.cleaningPaused;
      if (cleaningPaused != null) {
        building.pauseCleaning = cleaningPaused;
      }
    }

    if (building is EducationCentreTile) {
      final diplomacyCycles = savedBuildingTile.diplomacyCycles;
      print('Diplomacy cycles: $diplomacyCycles');

      if (diplomacyCycles != null) {
        for (int i = 0; i < diplomacyCycles; i++) {
          building.diplomacyExecuted();
        }
      }
    }

    if (building is BuildingPollutingTile) {
      final pollutingPaused = savedBuildingTile.pollutingPaused;
      if (pollutingPaused != null) {
        building.pausePollution = pollutingPaused;
      }
    }

    return building;
  }
}

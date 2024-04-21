// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateBuilding on GameState {
  void placeBuilding(BuildingNode buildingNode) {
    state = state.copyWith(buildingToBuild: buildingNode);
    _game.overlays.add(PlaceOverlay.overlayId);

    if (buildingNode.isOnWater) {
      _placeBuildingOnWater(buildingNode);
    } else {
      _placeBuildingOnLand(buildingNode);
    }
  }

  void _placeBuildingOnWater(BuildingNode buildingNode) {
    // ask where to build it
    // find water tiles that have cleaned shores

    final possibleTiles = <TileData>{};
    for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
      for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
        final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: x, y: y);
        if (!AppTiles.waterTiles.contains(tile?.tile)) continue;

        final tilePos = TilePosition(x: x, y: y);

        final neighbours = AppMath.getNeighbouringTiles(tilePos, AppLayers.template, mapComponent);
        final hasShore = neighbours.any((e) => AppTiles.grassShoreTiles.contains(e.data.tile));
        if (!hasShore) continue;

        final terrainTile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: x, y: y);
        if (terrainTile == null) continue;

        possibleTiles.add(TileData(layerId: AppLayers.terrain, position: tilePos, data: terrainTile));
      }
    }

    final avaiableTiles = <TileData>{};
    for (final tile in possibleTiles) {
      // only non built out tiles
      final tileOk = !AppTiles.buildingTiles.contains(tile.data.tile);
      if (tileOk) avaiableTiles.add(tile);
    }

    // if no available tiles, cancel building
    if (avaiableTiles.isEmpty) {
      cancelBuilding();
    }

    // if available tiles, highlight them
    for (final tile in avaiableTiles) {
      add(WaterPlacementTile(tilePosition: tile.position, isPaused: false));
    }
  }

  void _placeBuildingOnLand(BuildingNode buildingNode) {
    // ask where to build it
    // can build negbouring tiles to the tracks
    final List<BuildingTile> existingBuildings =
        objects.whereType<BuildingTile>().where((e) => e is TracksTile && e.constructed).toList();

    if (AppTiles.transportationTiles.contains(buildingNode.id)) {
      final townHalls = objects.whereType<TownHallTile>().where((e) => e.constructed);
      existingBuildings.addAll(townHalls);
    }

    // get available tiles
    final possibleTiles = <TileData>{};
    if (existingBuildings.isEmpty && buildingNode.id == AppTiles.townHall) {
      final surroundingTiles = AppMath.getSurroundingTiles(
        _start,
        2,
        AppLayers.terrain,
        mapComponent,
      );
      possibleTiles.addAll(surroundingTiles);
    } else {
      for (final building in existingBuildings) {
        final surroundingTiles = AppMath.getNeighbouringTiles(
          building.tilePosition,
          AppLayers.terrain,
          mapComponent,
        );
        possibleTiles.addAll(surroundingTiles);
      }
    }

    final availableTiles = <TileData>{};
    for (final tile in possibleTiles) {
      // only grass and forest tiles
      final templateTile = mapComponent.tileMap.getTileData(
        layerId: AppLayers.template,
        x: tile.position.x,
        y: tile.position.y,
      );
      if (templateTile == null) {
        throw Exception('No template tile found at $tile');
      }

      final existingBuilding = objects.whereType<BuildingTile>().firstWhereOrNull(
            (e) => e.tilePosition == tile.position,
          );

      final tileOk = existingBuilding == null &&
          !AppTiles.buildingTiles.contains(tile.data.tile) &&
          (AppTiles.grassSquareTiles.contains(templateTile.tile) || AppTiles.forestTiles.contains(templateTile.tile));
      if (tileOk) availableTiles.add(tile);
    }

    // if no available tiles, cancel building
    if (availableTiles.isEmpty) {
      cancelBuilding();
      ref.read(gameStateProvider.notifier).showMessage(Messages.nowhereToBuild);
    }

    // if available tiles, highlight them
    for (final tile in availableTiles) {
      add(PlacementTile(tilePosition: tile.position, isPaused: false));
    }
  }

  void cancelBuilding() {
    state = state.copyWith(buildingToBuild: null);
    _game.overlays.remove(PlaceOverlay.overlayId);

    // remove the placement tiles
    final placementTiles = objects.whereType<PlacementTile>();
    for (final tile in placementTiles) {
      tile.remove(this);
    }
    final waterPlacementTiles = objects.whereType<WaterPlacementTile>();
    for (final tile in waterPlacementTiles) {
      tile.remove(this);
    }
  }

  void buildBuilding(TilePosition tilePosition) {
    final buildingNode = state.buildingToBuild;
    if (buildingNode == null) {
      throw Exception('No building to build');
    }

    cancelBuilding();

    // add the building
    final buildingTile = buildingNode.constructor(tilePosition, false, true);
    add(buildingTile);
  }

  void deconstructBuilding(BuildingTile buildingTile) {
    buildingTile.remove(this);
    final node = BuildingTree.nodes.firstWhereOrNull((e) => e.id == buildingTile.buildingId);
    if (node == null) return;

    for (final resource in node.resourcesConsumed) {
      addResource(resource);
    }
  }

  void selectBuilding(BuildingTile buildingTile) {
    state = state.copyWith(selectedBuilding: buildingTile);
    _game.overlays.add(BuildingInfoOverlay.overlayId);
  }

  void deselectBuilding() {
    state = state.copyWith(selectedBuilding: null);
    _game.overlays.remove(BuildingInfoOverlay.overlayId);
  }

  bool _tapBuilding(TilePosition tilePos) {
    final object = objects.whereType<BuildingTile>().firstWhereOrNull((e) => e.tilePosition == tilePos);

    print('Tapped building: $object | ${object?.buildingId}');

    if (object == null) return false;
    if (AppTiles.enemyBuildingTiles.contains(object.buildingId)) return false;

    print('Selecting building: $object');

    selectBuilding(object);
    return true;
  }

  void _checkPlacementTiles() {
    final buildingToBuild = state.buildingToBuild;
    if (buildingToBuild == null) return;

    // remove the placement tiles
    final placementTiles = objects.whereType<PlacementTile>();
    for (final tile in placementTiles) {
      tile.remove(this);
    }
    final waterPlacementTiles = objects.whereType<WaterPlacementTile>();
    for (final tile in waterPlacementTiles) {
      tile.remove(this);
    }

    if (buildingToBuild.isOnWater) {
      _placeBuildingOnWater(buildingToBuild);
    } else {
      _placeBuildingOnLand(buildingToBuild);
    }
  }
}

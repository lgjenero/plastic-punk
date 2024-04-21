// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateObject on GameState {
  void _removeAllPollution() {
    for (var x = 0; x < mapComponent.tileMap.map.width; x++) {
      for (var y = 0; y < mapComponent.tileMap.map.height; y++) {
        final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: x, y: y);
        if (AppTiles.buildingTiles.contains(tile?.tile)) continue;

        final templateTile = mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: x, y: y);
        if (templateTile == null) continue;

        _mapComponent.tileMap.setTileData(
          layerId: AppLayers.terrain,
          x: x,
          y: y,
          gid: templateTile,
        );
      }
    }
  }

  void _initObjects() {
    // _removeAllPollution();

    for (final object in _mapComponent.tileMap.getLayer<ObjectGroup>('Objects')?.objects ?? const <TiledObject>[]) {
      // clean around the start point
      if (object.name == AppObjects.start) {
        // final tileSize = AppSizes.tileTexture.toVector2();
        // final mapWidth = mapComponent.tileMap.map.width;
        // final mapHeight = mapComponent.tileMap.map.height;
        // final tilePosition = AppMath.positionToTile(object.position, tileSize, mapWidth, mapHeight);

        print('Start point found: $object');

        final tileX = object.properties.firstWhereOrNull((e) => e.name == AppObjectProperties.tileX)?.value;
        final tileY = object.properties.firstWhereOrNull((e) => e.name == AppObjectProperties.tileY)?.value;

        if (tileX is! double || tileY is! double) {
          throw Exception('Start point must have tileX and tileY properties of type double');
        }

        final tilePosition = TilePosition(x: tileX.floor(), y: tileY.floor());

        _start = tilePosition;

        final startTiles = AppMath.getSurroundingTiles(_start, 1, AppLayers.terrain, mapComponent);

        for (final tile in startTiles) {
          final templateTile = mapComponent.tileMap.getTileData(
            layerId: AppLayers.template,
            x: tile.position.x,
            y: tile.position.y,
          );
          if (templateTile == null) {
            throw Exception('No template tile found at $tile');
          }

          mapComponent.tileMap.setTileData(
            layerId: AppLayers.terrain,
            x: tile.position.x,
            y: tile.position.y,
            gid: templateTile,
          );
        }

        moveCameraTo(_start);

        continue;
      }

      // Add buildings
      if (object.type == AppObjects.building) {
        // final tileSize = AppSizes.tileTexture.toVector2();
        // final mapWidth = mapComponent.tileMap.map.width;
        // final mapHeight = mapComponent.tileMap.map.height;
        // final tilePosition = AppMath.positionToTile(object.position, tileSize, mapWidth, mapHeight);

        final tileX = object.properties.firstWhereOrNull((e) => e.name == AppObjectProperties.tileX)?.value;
        final tileY = object.properties.firstWhereOrNull((e) => e.name == AppObjectProperties.tileY)?.value;

        if (tileX is! double || tileY is! double) {
          throw Exception('Building must have tileX and tileY properties of type double');
        }

        final tilePosition = TilePosition(x: tileX.floor(), y: tileY.floor());

        final buildingId = object.properties.firstWhereOrNull((e) => e.name == AppObjectProperties.buildingId)?.value;
        if (buildingId is! int) {
          throw Exception('Building must have a buildingId property of type int');
        }

        final node = BuildingTree.nodes.firstWhereOrNull((node) => node.id == buildingId);
        if (node == null) {
          throw Exception('Unknown buildingId: $buildingId');
        }

        add(node.constructor(tilePosition, true, true));
      }
    }

    _initAnimations();
  }

  void add(GameObject object) {
    final updatedObjects = [...objects, object];
    final availableResources = {...state.availableResources};

    if (object is BuildingTile && object.addResources) {
      final treeNode = BuildingTree.nodes.firstWhereOrNull((node) => node.id == object.buildingId);
      if (treeNode != null) {
        for (final resource in treeNode.resourcesRequired) {
          final availableResource = availableResources[resource.type] ?? Resource(type: resource.type, amount: 0);
          final updatedResource = availableResource - resource;
          availableResources[resource.type] = updatedResource;
        }
        if (!object.startsConstructed) {
          for (final resource in treeNode.resourcesConsumed) {
            final availableResource = availableResources[resource.type] ?? Resource(type: resource.type, amount: 0);
            final updatedResource = availableResource - resource;
            availableResources[resource.type] = updatedResource;
          }
        }
      }
    }

    state = state.copyWith(objects: updatedObjects, availableResources: availableResources);

    // check if we need to recalculate placement tiles
    if (object is BuildingTile) _checkPlacementTiles();
  }

  void remove(GameObject object) {
    final updatedObjects = [...objects]..remove(object);
    final availableResources = {...state.availableResources};

    if (object is BuildingTile && object.addResources) {
      final treeNode = BuildingTree.nodes.firstWhereOrNull((node) => node.id == object.buildingId);
      if (treeNode != null) {
        for (final resource in treeNode.resourcesRequired) {
          final availableResource = availableResources[resource.type] ?? Resource(type: resource.type, amount: 0);
          final updatedResource = availableResource + resource;
          availableResources[resource.type] = updatedResource;
        }
      }
    }

    state = state.copyWith(objects: updatedObjects, availableResources: availableResources);

    // check if we need to recalculate placement tiles
    if (object is BuildingTile) _checkPlacementTiles();
  }
}

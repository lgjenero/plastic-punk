// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateAnimations on GameState {
  void _initAnimations() {
    final mapWidth = mapComponent.tileMap.map.width;
    final mapHeight = mapComponent.tileMap.map.height;

    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        final templateTile = mapComponent.tileMap.getTileData(layerId: AppLayers.template, x: i, y: j);
        if (templateTile == null) continue;
        if (!AppTiles.waterTiles.contains(templateTile.tile)) continue;

        final tile = mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: i, y: j);
        final isPolluted = AppTiles.pollutionTiles.contains(tile?.tile);

        if (isPolluted) {
          _addWaterPollutionAnimation(TilePosition(x: i, y: j));
        } else {
          _addWaterAnimation(TilePosition(x: i, y: j));
        }
      }
    }
  }

  void _addWaterPollutionAnimation(
    TilePosition position,
  ) {
    final tileSize = mapComponent.tileMap.destTileSize;
    final animation = components.SpriteAnimationComponent.fromFrameData(
      Flame.images.fromCache('animations/pollution_water_animation_2.png'),
      components.SpriteAnimationData.variable(
        amount: 24,
        stepTimes: List.generate(24, (index) => 0.1),
        textureSize: Vector2(256, 160),
        amountPerRow: 4,
      ),
      size: tileSize,
      position: Vector2.zero(),
      anchor: const components.Anchor(0, 0),
    );

    final animationComponent = _PollutionWaterAnimationTileComponent(
      [animation],
      position,
      this,
    );

    mapComponent.add(animationComponent);
  }

  void _removeWaterPollutionAnimation(TilePosition position) {
    final animation = mapComponent.children.firstWhereOrNull(
        (element) => element is _PollutionWaterAnimationTileComponent && element.tilePosition == position);
    if (animation == null) return;
    mapComponent.remove(animation);
  }

  void _addWaterAnimation(TilePosition position) {
    final tileSize = mapComponent.tileMap.destTileSize;
    final animation = components.SpriteAnimationComponent.fromFrameData(
      Flame.images.fromCache('animations/water_animation_2.png'),
      components.SpriteAnimationData.variable(
        amount: 24,
        stepTimes: List.generate(24, (index) => 0.1),
        textureSize: Vector2(256, 160),
        amountPerRow: 4,
      ),
      size: tileSize,
      position: Vector2.zero(),
      anchor: const components.Anchor(0, 0),
    );

    final animationComponent = _WaterAnimationTileComponent(
      [animation],
      position,
      this,
    );

    mapComponent.add(animationComponent);
  }

  void _removeWaterAnimation(TilePosition position) {
    final animation = mapComponent.children
        .firstWhereOrNull((element) => element is _WaterAnimationTileComponent && element.tilePosition == position);
    if (animation == null) return;
    mapComponent.remove(animation);
  }
}

class _PollutionWaterAnimationTileComponent extends TileAnimationComponent {
  _PollutionWaterAnimationTileComponent(super.animationComponents, super.position, super.state)
      : super(priority: AppRenderPriorities.terrainAnimations);
}

class _WaterAnimationTileComponent extends TileAnimationComponent {
  _WaterAnimationTileComponent(super.animationComponents, super.position, super.state)
      : super(priority: AppRenderPriorities.terrainAnimations);
}

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_sprite_component.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_cleaning_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class WaterCleanupTile extends BuildingCleaningTile {
  WaterCleanupTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(
            cleaningPeriod: () => AppTimes.waterCleanupDuration,
            cleansWater: true,
            buildingId: AppTiles.waterCleanup,
            sfxLoop: SfxLoop.waterCleanup);

  WaterCleanupTileComponent? _buildingComponent;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_buildingComponent == null) {
      final tileSize = state.mapComponent.tileMap.destTileSize;
      final spriteComponent = SpriteComponent.fromImage(
        Flame.images.fromCache('Tiles/water_cleanup.png'),
        size: Vector2.all(tileSize.x),
        position: Vector2(0, tileSize.y),
        anchor: Anchor.bottomLeft,
      );

      final positions = [
        Vector2(tileSize.x * 0.49, tileSize.y * 0.28),
        Vector2(tileSize.x * 0.65, tileSize.y * 0.43),
      ];

      final animations = positions
          .map(
            (position) => SpriteAnimationComponent.fromFrameData(
                Flame.images.fromCache('animations/water_bubbles.png'),
                SpriteAnimationData.variable(
                  amount: 20,
                  stepTimes: List.generate(20, (index) => 0.1),
                  textureSize: Vector2(42.5, 64),
                  amountPerRow: 5,
                ),
                size: Vector2(6, 9),
                position: position,
                anchor: const Anchor(0.61, 1)),
          )
          .toList();

      _buildingComponent = WaterCleanupTileComponent(animations, [spriteComponent], tilePosition, state);
      state.mapComponent.add(_buildingComponent!);
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (_buildingComponent != null) {
      state.mapComponent.remove(_buildingComponent!);
    }
  }
}

class WaterCleanupTileComponent extends TileSpriteComponent with Animation {
  WaterCleanupTileComponent(
      List<SpriteAnimationComponent> animationComponents, super.spriteComponents, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition)) {
    initializeAnimation(animationComponents);
  }
}

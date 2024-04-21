import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class SolarPanelsTile extends BuildingTile {
  SolarPanelsTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.solarPanels, sfxLoop: SfxLoop.solarPanels);

  SolarPanelsTileComponent? _animationComponent;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_animationComponent == null) {
      final tileSize = state.mapComponent.tileMap.destTileSize;

      final researchSheet = SpriteAnimation.fromFrameData(
          Flame.images.fromCache('animations/sparks.png'),
          SpriteAnimationData.variable(
            amount: 36,
            stepTimes: List.generate(36, (index) => 0.1),
            textureSize: Vector2(42.5, 42.5),
            amountPerRow: 6,
          ));

      final frames = researchSheet.frames.getRange(12, 24).toList();

      // final framesSets = [
      //   researchSheet.frames.getRange(0, 12).toList(),
      //   researchSheet.frames.getRange(12, 24).toList(),
      //   researchSheet.frames.getRange(24, 36).toList(),
      // ];

      final positions = [
        Vector2(tileSize.x * 0.3125, tileSize.y * -0.025),
        Vector2(tileSize.x * 0.594, tileSize.y * 0.05),
        Vector2(tileSize.x * 0.695, tileSize.y * -0.1),
      ];

      final animations = positions
          .map((e) => SpriteAnimationComponent(
                animation: SpriteAnimation(frames, loop: true),
                size: Vector2.all(8),
                position: e,
                anchor: Anchor.bottomCenter,
              ))
          .toList();

      _animationComponent = SolarPanelsTileComponent(animations, tilePosition, state);
      state.mapComponent.add(_animationComponent!);
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (_animationComponent != null) {
      state.mapComponent.remove(_animationComponent!);
    }
  }
}

class SolarPanelsTileComponent extends TileAnimationComponent {
  SolarPanelsTileComponent(super.animationComponents, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));
}

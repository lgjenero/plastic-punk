import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_polluting_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class PlasticsFactoryTile extends BuildingPollutingTile {
  PlasticsFactoryTile({required super.tilePosition, required super.isPaused, super.startsConstructed = true})
      : super(
          buildingId: AppTiles.plasticsFactory,
          sfxLoop: SfxLoop.plasticsFactory,
          pollutingPeriod: () => AppTimes.plasticsFactoryProductionTime,
          pollutesWater: true,
        );

  PlasticsFactoryTileObject? _animationComponent;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_animationComponent == null) {
      _setupAnimation(state);
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    _removeAnimation(state);
  }

  void _setupAnimation(GameState state) {
    final tileSize = state.mapComponent.tileMap.destTileSize;

    final positions = [
      Vector2(tileSize.x * 0.445, tileSize.y * -0.2125),
      Vector2(tileSize.x * 0.325, tileSize.y * -0.2125),
      Vector2(tileSize.x * 0.625, tileSize.y * -0.1875),
      Vector2(tileSize.x * 0.545, tileSize.y * -0.2625),
    ].reversed;

    final animations = positions
        .map(
          (position) => SpriteAnimationComponent.fromFrameData(
              Flame.images.fromCache('animations/smoke_1.png'),
              SpriteAnimationData.variable(
                amount: 16,
                stepTimes: List.generate(16, (index) => 0.1),
                textureSize: Vector2(64, 64),
                amountPerRow: 4,
              ),
              size: Vector2.all(16),
              position: position,
              anchor: const Anchor(0.61, 1)),
        )
        .toList();

    _animationComponent = PlasticsFactoryTileObject(animations, tilePosition, state);
    state.mapComponent.add(_animationComponent!);
  }

  void _removeAnimation(GameState state) {
    if (_animationComponent != null) {
      state.mapComponent.remove(_animationComponent!);
      _animationComponent = null;
    }
  }
}

class PlasticsFactoryTileObject extends TileAnimationComponent {
  PlasticsFactoryTileObject(super.animationComponent, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));
}

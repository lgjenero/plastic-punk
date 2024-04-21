import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_cleaning_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class TownHallTile extends BuildingCleaningTile {
  TownHallTile({required super.tilePosition, required super.isPaused, super.startsConstructed, super.addResources})
      : super(
          cleaningPeriod: () => AppTimes.townHallCleanupDuration,
          cleansWater: false,
          resourceProduced:
              const Resource(type: ResourceType.material, amount: AppAmmounts.townHallMaterialProductionAmount),
          buildingId: AppTiles.townHall,
          sfxLoop: SfxLoop.townHall,
        );
  TownHallTileObject? _animationComponent;

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
    final flagCode = state.flagCode;
    final animation = SpriteAnimationComponent.fromFrameData(
      Flame.images.fromCache('flags/$flagCode.png'),
      SpriteAnimationData.variable(
        amount: 16,
        stepTimes: List.generate(16, (index) => 0.1),
        textureSize: Vector2(192, 136),
        amountPerRow: 4,
      ),
      size: Vector2(12, 8.5),
      position: Vector2(tileSize.x * 0.484, tileSize.y * -0.237),
      anchor: Anchor.bottomLeft,
    );

    _animationComponent = TownHallTileObject([animation], tilePosition, state);
    state.mapComponent.add(_animationComponent!);
  }

  void _removeAnimation(GameState state) {
    if (_animationComponent != null) {
      state.mapComponent.remove(_animationComponent!);
      _animationComponent = null;
    }
  }
}

class TownHallTileObject extends TileAnimationComponent {
  TownHallTileObject(super.animationComponent, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));
}

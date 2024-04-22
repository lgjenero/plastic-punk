import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_cleaning_tile.dart';
import 'package:plastic_punk/state/game/objects/train.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/math.dart';

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

  Train? _leftTrain;
  Train? _rightTrain;
  Train? _upTrain;
  Train? _downnTrain;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_animationComponent == null) {
      _setupAnimation(state);
    }

    _checkTrains(state);
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    _removeAnimation(state);
    _removeTrains(state);
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

  void _checkTrains(GameState state) {
    final neightbours = AppMath.getNeighbouringTiles(tilePosition, AppLayers.terrain, state.mapComponent);
    final leftTrain = neightbours.firstWhereOrNull(
            (e) => e.position == tilePosition.left && AppTiles.transportationTiles.contains(e.data.tile)) !=
        null;
    final rightTrain = neightbours.firstWhereOrNull(
            (e) => e.position == tilePosition.right && AppTiles.transportationTiles.contains(e.data.tile)) !=
        null;
    final upTrain = neightbours.firstWhereOrNull(
            (e) => e.position == tilePosition.up && AppTiles.transportationTiles.contains(e.data.tile)) !=
        null;
    final downTrain = neightbours.firstWhereOrNull(
            (e) => e.position == tilePosition.down && AppTiles.transportationTiles.contains(e.data.tile)) !=
        null;

    if (leftTrain && _leftTrain == null) {
      _leftTrain = Train(tilePosition.left, state, priority: AppRenderPriorities.terrainAnimations);
      state.mapComponent.add(_leftTrain!);
    } else if (!leftTrain && _leftTrain != null) {
      state.mapComponent.remove(_leftTrain!);
      _leftTrain = null;
    }

    if (rightTrain && _rightTrain == null) {
      _rightTrain = Train(tilePosition.right, state, priority: AppRenderPriorities.terrainAnimations);
      state.mapComponent.add(_rightTrain!);
    } else if (!rightTrain && _rightTrain != null) {
      state.mapComponent.remove(_rightTrain!);
      _rightTrain = null;
    }

    if (upTrain && _upTrain == null) {
      _upTrain = Train(tilePosition.up, state, priority: AppRenderPriorities.terrainAnimations);
      state.mapComponent.add(_upTrain!);
    } else if (!upTrain && _upTrain != null) {
      state.mapComponent.remove(_upTrain!);
      _upTrain = null;
    }

    if (downTrain && _downnTrain == null) {
      _downnTrain = Train(tilePosition.down, state, priority: AppRenderPriorities.terrainAnimations);
      state.mapComponent.add(_downnTrain!);
    } else if (!downTrain && _downnTrain != null) {
      state.mapComponent.remove(_downnTrain!);
      _downnTrain = null;
    }
  }

  void _removeTrains(GameState state) {
    if (_leftTrain != null) {
      state.mapComponent.remove(_leftTrain!);
      _leftTrain = null;
    }

    if (_rightTrain != null) {
      state.mapComponent.remove(_rightTrain!);
      _rightTrain = null;
    }

    if (_upTrain != null) {
      state.mapComponent.remove(_upTrain!);
      _upTrain = null;
    }

    if (_downnTrain != null) {
      state.mapComponent.remove(_downnTrain!);
      _downnTrain = null;
    }
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

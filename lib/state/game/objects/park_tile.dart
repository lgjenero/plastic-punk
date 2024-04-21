import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class ParkTile extends BuildingTile {
  ParkTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.park, sfxLoop: SfxLoop.park);

  ParkTileTileObject? _animationComponent;

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
    _animationComponent = ParkTileTileObject(tilePosition, state);
    state.mapComponent.add(_animationComponent!);
  }

  void _removeAnimation(GameState state) {
    if (_animationComponent != null) {
      state.mapComponent.remove(_animationComponent!);
      _animationComponent = null;
    }
  }
}

class ParkTileTileObject extends TileComponent {
  ParkTileTileObject(super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));

  late final SpriteAnimationComponent _feedAnimation;
  late final SpriteAnimationComponent _flyAnimation;
  double _totalTime = 0;
  final List<double> _birdTimes = [3, 5, 4, 6, 2, 7, 4, 8];
  final List<Vector2> _birdPositions = [
    Vector2(0.3, 0.46),
    Vector2(0.5, 0.32),
    Vector2(0.67, 0.45),
    Vector2(0.5, 0.68),
  ];
  int _step = 0;

  @override
  FutureOr<void> onLoad() {
    final birdSheet = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('animations/bird.png'),
        SpriteAnimationData.variable(
          amount: 12,
          stepTimes: List.generate(12, (index) => 0.1),
          textureSize: Vector2(16, 16),
          amountPerRow: 4,
        ));

    final feedingFrames = birdSheet.frames.getRange(0, 4).toList();
    final flyingFrames = birdSheet.frames.getRange(4, 8).toList();

    _feedAnimation = SpriteAnimationComponent(
      animation: SpriteAnimation(feedingFrames, loop: true),
      size: Vector2.all(5),
      position: _adjustedPosition(0),
      anchor: Anchor.bottomCenter,
    );

    _flyAnimation = SpriteAnimationComponent(
      animation: SpriteAnimation(flyingFrames, loop: true),
      size: Vector2.all(5),
      position: Vector2.zero(),
      anchor: Anchor.bottomCenter,
    );

    add(_feedAnimation);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _totalTime += dt;
    if (_totalTime > _birdTimes[_step]) {
      _totalTime = 0;
      _step = (_step + 1) % _birdTimes.length;

      removeAll(children);

      switch (_step) {
        case 1:
          _flyAnimation.scale = Vector2(1, 1);
          _flyAnimation.position = _adjustedPosition(0);
          add(_flyAnimation);
          break;
        case 2:
          _feedAnimation.scale = Vector2(1, 1);
          _feedAnimation.position = _adjustedPosition(1);
          add(_feedAnimation);
          break;
        case 3:
          _flyAnimation.scale = Vector2(1, 1);
          _flyAnimation.position = _adjustedPosition(1);
          add(_flyAnimation);
          break;
        case 4:
          _feedAnimation.scale = Vector2(-1, 1);
          _feedAnimation.position = _adjustedPosition(2);
          add(_feedAnimation);
          break;
        case 5:
          _flyAnimation.scale = Vector2(-1, 1);
          _flyAnimation.position = _adjustedPosition(2);
          add(_flyAnimation);
          break;
        case 6:
          _feedAnimation.scale = Vector2(-1, 1);
          _feedAnimation.position = _adjustedPosition(3);
          add(_feedAnimation);
          break;
        case 7:
          _flyAnimation.scale = Vector2(-1, 1);
          _flyAnimation.position = _adjustedPosition(3);
          add(_flyAnimation);
          break;
        case 0:
          _feedAnimation.scale = Vector2(1, 1);
          _feedAnimation.position = _adjustedPosition(0);
          add(_feedAnimation);
          _step = 0;
          break;
      }
    }

    final progress = _totalTime / _birdTimes[_step];
    if (_step.isOdd) {
      final previousPosition = _step ~/ 2;
      final nextPosition = (_step ~/ 2 + 1) % _birdPositions.length;
      final start = _adjustedPosition(previousPosition);
      final end = _adjustedPosition(nextPosition);
      final currentPostion = start + (end - start) * progress;
      _flyAnimation.position = currentPostion;
    }
  }

  Vector2 _adjustedPosition(int index) {
    final position = _birdPositions[index];
    final size = tileRect.size;
    return Vector2(position.x * size.width, position.y * size.height);
  }
}

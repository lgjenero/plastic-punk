import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/math.dart';

class Car extends PositionComponent {
  final GameState state;

  TilePosition _tilePosition;
  TilePosition? _prevTilePosition;
  TilePosition? _nextTilePosition;
  late final SpriteComponent _topDownSprite;
  late final SpriteComponent _leftRigthSprite;
  double _timeElapsed = 0;

  static final _random = math.Random();
  static const double _speed = 2;
  static const double _size = 9;

  Car(TilePosition start, this.state, {super.priority}) : _tilePosition = start {
    final tileSize = state.mapComponent.tileMap.destTileSize;
    final mapWidth = state.mapComponent.tileMap.map.width;
    final mapHeight = state.mapComponent.tileMap.map.height;

    position = AppMath.getTilePosition(start, tileSize, mapWidth, mapHeight).center.toVector2();
    anchor = Anchor.center;
    width = _size;
    height = _size;
  }

  @override
  FutureOr<void> onLoad() async {
    _topDownSprite = SpriteComponent(
      sprite:
          Sprite(Flame.images.fromCache('animations/car.png'), srcSize: Vector2.all(128), srcPosition: Vector2.zero()),
      size: Vector2.all(_size),
      position: Vector2.all(_size / 2),
      anchor: Anchor.center,
    );

    _leftRigthSprite = SpriteComponent(
      sprite:
          Sprite(Flame.images.fromCache('animations/car.png'), srcSize: Vector2.all(128), srcPosition: Vector2(128, 0)),
      size: Vector2.all(_size),
      position: Vector2.all(_size / 2),
      anchor: Anchor.center,
    );

    add(_topDownSprite);
    add(_leftRigthSprite);

    _initialChooseDirection();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_nextTilePosition == null) {
      _initialChooseDirection();
      if (_nextTilePosition == null) return;
    }

    _timeElapsed += dt;
    if (_timeElapsed >= _speed) {
      _chooseDirection();
    }

    final tileSize = state.mapComponent.tileMap.destTileSize;
    final mapWidth = state.mapComponent.tileMap.map.width;
    final mapHeight = state.mapComponent.tileMap.map.height;
    final start = AppMath.getTilePosition(_tilePosition, tileSize, mapWidth, mapHeight).center.toVector2();
    final end = AppMath.getTilePosition(_nextTilePosition!, tileSize, mapWidth, mapHeight).center.toVector2();

    position = start + (end - start) * (_timeElapsed / _speed);
  }

  void _chooseDirection() {
    _timeElapsed = 0;
    _prevTilePosition = _tilePosition;
    _tilePosition = _nextTilePosition!;

    _initialChooseDirection();
  }

  void _initialChooseDirection() {
    final availableDirection = <TilePosition>[];
    final neighbours = AppMath.getNeighbouringTiles(_tilePosition, AppLayers.terrain, state.mapComponent);
    for (final neighbour in neighbours) {
      if (_prevTilePosition == neighbour.position) continue;
      final buildingId = neighbour.data.tile;
      if (AppTiles.pollutedTransportationTiles.contains(buildingId)) {
        availableDirection.add(neighbour.position);
      }
    }

    if (availableDirection.isEmpty) {
      _nextTilePosition = _prevTilePosition;
    } else {
      _nextTilePosition = availableDirection[_random.nextInt(availableDirection.length)];
    }

    _leftRigthSprite.opacity =
        (_nextTilePosition == _tilePosition.left || _nextTilePosition == _tilePosition.right) ? 1 : 0;
    _topDownSprite.opacity = (_nextTilePosition == _tilePosition.up || _nextTilePosition == _tilePosition.down) ? 1 : 0;
  }
}

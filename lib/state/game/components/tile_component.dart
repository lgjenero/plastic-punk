import 'dart:ui';

import 'package:flame/components.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/math/math.dart';

class TileComponent extends PositionComponent {
  final TilePosition tilePosition;
  late final Rect _rect;
  Rect get tileRect => _rect;

  TileComponent(this.tilePosition, GameState state, {super.priority}) {
    _initialize(state, tilePosition);
    position = Vector2(_rect.left, _rect.top);
    size = Vector2(_rect.width, _rect.height);
  }

  void _initialize(GameState state, TilePosition position) {
    final tileSize = state.mapComponent.tileMap.destTileSize;
    _rect = AppMath.getTilePosition(
      position,
      tileSize,
      state.mapComponent.tileMap.map.width,
      state.mapComponent.tileMap.map.height,
    );
  }
}

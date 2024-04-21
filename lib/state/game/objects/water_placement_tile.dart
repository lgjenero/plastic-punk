import 'dart:async';
import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/math.dart';

class WaterPlacementTile extends GameObject {
  final TilePosition tilePosition;

  WaterPlacementTile({required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  bool _highlightAdded = false;
  bool _highlightOk = true;

  WaterPlacementTileObject? _placementTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    // check if the tile is valid (not polluted shore)
    final neighbours = AppMath.getNeighbouringTiles(tilePosition, AppLayers.terrain, state.mapComponent);
    final highlightOk = neighbours.any((neighbour) => AppTiles.grassShoreTiles.contains(neighbour.data.tile));
    if (highlightOk != _highlightOk) {
      _highlightOk = highlightOk;
      _placementTileObject?.setHighlightOk(highlightOk);
    }

    if (!_highlightAdded) {
      _highlightAdded = true;
      scheduleMicrotask(() {
        _placementTileObject = WaterPlacementTileObject(
          tilePosition,
          state,
          onTap: () => state.buildBuilding(tilePosition),
          highlightOk: highlightOk,
        );
        state.mapComponent.add(_placementTileObject!);
      });
    }
  }

  void _removeComponent(GameState state) {
    if (_placementTileObject != null) {
      state.mapComponent.remove(_placementTileObject!);
      _placementTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    scheduleMicrotask(() {
      state.remove(this);

      // remove the cleanup tile from the map
      _removeComponent(state);

      // remove the highligh from the map
      state.mapComponent.tileMap.setTileData(
        layerId: AppLayers.overlay,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: const Gid(0, Flips.defaults()),
      );
    });
  }
}

class WaterPlacementTileObject extends TileComponent with TapCallbacks {
  final VoidCallback? onTap;
  bool _highlightOk = true;
  WaterPlacementTileObject(super.tilePosition, super.state, {this.onTap, bool highlightOk = true})
      : super(priority: AppRenderPriorities.selection) {
    _highlightOk = highlightOk;
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!_highlightOk) return;
    onTap?.call();
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    final a = Vector2(0, tileRect.height / 2);
    final b = Vector2(tileRect.width / 2, 0);
    final c = Vector2(tileRect.width, tileRect.height / 2);
    final d = Vector2(tileRect.width / 2, tileRect.height);

    return AppMath.isPointInPolygon([a, b, c, d], point);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = _highlightOk ? const Color.fromARGB(128, 0, 186, 248) : const Color.fromARGB(128, 255, 1, 1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(tileRect.size.width / 2, 0)
      ..lineTo(tileRect.size.width, tileRect.size.height / 2)
      ..lineTo(tileRect.size.width / 2, tileRect.size.height)
      ..lineTo(0, tileRect.size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  void setHighlightOk(bool highlightOk) {
    _highlightOk = highlightOk;
  }
}

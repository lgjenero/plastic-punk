import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/bad_town_hall.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/math/math.dart';

class DiplomacyPlacementTile extends GameObject {
  final TilePosition tilePosition;

  DiplomacyPlacementTile({required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  bool _highlightAdded = false;
  bool _highlightOk = true;

  DiplomacyPlacementTileObject? _placementTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    final townHall = state.objects.whereType<BadTownHall>().firstWhereOrNull((e) => e.tilePosition == tilePosition);
    final highlightOk = townHall?.pausePollution == false;
    if (highlightOk != _highlightOk) {
      _highlightOk = highlightOk;
      _placementTileObject?.setHighlightOk(highlightOk);
    }

    if (!_highlightAdded) {
      _highlightAdded = true;
      scheduleMicrotask(() {
        _placementTileObject = DiplomacyPlacementTileObject(
          tilePosition,
          state,
          onTap: () => _tryToStartDiplomacy(state),
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

  void _tryToStartDiplomacy(GameState state) {
    final townHall = state.objects.whereType<BadTownHall>().firstWhereOrNull((e) => e.tilePosition == tilePosition);
    final diplomacyOk = townHall?.pausePollution == false;
    if (!diplomacyOk) {
      state.showMessage(Messages.crossRedLineToHaveDiplomacy);
      return;
    }

    state.startDiplomaticMission(tilePosition);
  }
}

class DiplomacyPlacementTileObject extends TileComponent with TapCallbacks {
  final VoidCallback? onTap;
  bool _highlightOk = true;
  DiplomacyPlacementTileObject(super.tilePosition, super.state, {this.onTap, bool highlightOk = true})
      : super(priority: AppRenderPriorities.progress) {
    _highlightOk = highlightOk;
  }

  @override
  void onTapUp(TapUpEvent event) {
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

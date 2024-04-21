import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/building_polluting_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/flood_fill.dart';
import 'package:plastic_punk/utils/math/math.dart';

class BadTownHall extends BuildingPollutingTile {
  BadTownHall({required super.tilePosition, required super.isPaused, super.startsConstructed = true})
      : super(
          buildingId: AppTiles.badTownHall,
          sfxLoop: SfxLoop.plasticsFactory,
          pollutingPeriod: () => AppTimes.badTownHallProductionTime,
          pollutesWater: true,
        );

  List<BadTownHallBorderTileObject>? _borderTiles;
  bool _alarmSounded = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_borderTiles == null) {
      _setupBorderTiles(state);
    }
  }

  @override
  void remove(GameState state) {
    _removeBorderTiles(state);
    super.remove(state);
  }

  void _setupBorderTiles(GameState state) {
    final borderTiles = AppMath.getTilesAtDistance(
      tilePosition,
      AppAmmounts.badTownHallAlarmDistance,
      AppLayers.terrain,
      state.mapComponent,
    );

    final tiles = borderTiles
        .map(
          (e) => BadTownHallBorderTileObject(
            e.position,
            state,
            onTap: () => _turnOnPollution(state, e.position),
          ),
        )
        .toList();

    _borderTiles = tiles;
    for (final borderTile in tiles) {
      state.mapComponent.add(borderTile);
    }
  }

  void _removeBorderTiles(GameState state) {
    final tiles = _borderTiles;
    if (tiles == null) return;

    for (final borderTile in tiles) {
      state.mapComponent.remove(borderTile);
    }

    _borderTiles?.clear();
  }

  void _turnOnPollution(GameState state, TilePosition borderPosition) {
    scheduleMicrotask(() {
      state.cleanTile(borderPosition);
    });

    if (_alarmSounded) return;
    _alarmSounded = true;

    scheduleMicrotask(() {
      final tiles = FloodFiller(state.mapComponent, AppLayers.terrain, {}, AppTiles.enemyBuildingTiles, {})
          .getFilledArea(tilePosition);

      for (final tile in tiles) {
        final building =
            state.objects.whereType<BuildingPollutingTile>().firstWhereOrNull((e) => e.tilePosition == tile);
        if (building == null) continue;
        building.pausePollution = false;
      }

      _removeBorderTiles(state);

      state.showMessage(Messages.badTownHallAlarm);
    });
  }
}

class BadTownHallBorderTileObject extends TileComponent with TapCallbacks {
  final VoidCallback? onTap;
  final GameState state;
  BadTownHallBorderTileObject(TilePosition tilePosition, this.state, {this.onTap})
      : super(tilePosition, state, priority: AppRenderPriorities.progress);

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
  void update(double dt) {
    final tile =
        state.mapComponent.tileMap.getTileData(layerId: AppLayers.terrain, x: tilePosition.x, y: tilePosition.y)?.tile;
    if (tile != null) {
      final isClean = !AppTiles.pollutionTiles.contains(tile) && !AppTiles.enemyBuildingTiles.contains(tile);
      if (isClean) onTap?.call();
      return;
    }

    final cleaning = state.objects.whereType<CleanupTile>().any((e) => e.tilePosition == tilePosition);
    if (cleaning) onTap?.call();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = const Color.fromARGB(128, 255, 1, 1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(tileRect.size.width / 2, 0)
      ..lineTo(tileRect.size.width, tileRect.size.height / 2)
      ..lineTo(tileRect.size.width / 2, tileRect.size.height)
      ..lineTo(0, tileRect.size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }
}

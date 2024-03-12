import 'dart:async';
import 'dart:ui';

import 'package:plastic_punk/state/game/components/icon_component.dart';
import 'package:plastic_punk/state/game/components/progress_component.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/flood_fill.dart';

class CleanupTile extends GameObject {
  final TilePosition tilePosition;

  CleanupTile({required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  double _timeElapsed = 0;
  CleanupTileObject? _cleanupTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    _timeElapsed += dt;

    // if the cleanup duration has passed, remove the cleanup tile
    if (_timeElapsed > AppTimes.cleanupDuration) {
      scheduleMicrotask(() {
        state.remove(this);

        // remove the cleanup tile from the map
        if (_cleanupTileObject != null) {
          state.mapComponent.remove(_cleanupTileObject!);
        }

        // remove the pollution from the map and put the template tile back
        final tile = state.mapComponent.tileMap.getTileData(
          layerId: AppLayers.template,
          x: tilePosition.x,
          y: tilePosition.y,
        );
        if (tile != null) {
          state.mapComponent.tileMap.setTileData(
            layerId: AppLayers.terrain,
            x: tilePosition.x,
            y: tilePosition.y,
            gid: tile,
          );
        } else {
          throw Exception('No template tile found at $x, $y');
        }
      });

      return;
    }

    if (_cleanupTileObject == null) {
      _cleanupTileObject = CleanupTileObject(tilePosition, state);
      state.mapComponent.add(_cleanupTileObject!);
    }
  }

  @override
  void remove(GameState state) {
    if (_cleanupTileObject != null) {
      state.mapComponent.remove(_cleanupTileObject!);
    }
  }

  static CleanupTile? spawn(TilePosition tilePosition, GameState state, bool waterTiles) {
    final tile = FloodFiller(
      state.mapComponent,
      AppLayers.terrain,
      waterTiles ? AppTiles.waterPollutedTiles : AppTiles.groundPollutedTiles,
      waterTiles
          ? {...AppTiles.waterTiles, AppTiles.waterCleanup}
          : {...AppTiles.grassTiles, ...AppTiles.forestTiles, ...AppTiles.buildingTiles},
      state.objects.whereType<CleanupTile>().map((e) => e.tilePosition).toSet(),
    ).getNextPoint(tilePosition);
    if (tile == null) return null;

    return CleanupTile(tilePosition: tile, isPaused: false);
  }

  static CleanupTile? spawnFromSelectedTile(GameState state, bool waterTiles) {
    final tile = state.getTileToClean(waterTiles);
    if (tile == null) return null;

    return CleanupTile(tilePosition: tile, isPaused: false);
  }
}

class CleanupTileObject extends TileComponent with Progress, Icon {
  CleanupTileObject(TilePosition tilePosition, GameState state) : super(tilePosition, state) {
    initializeProgress(state, AppTimes.cleanupDuration);
    initializeIcon(state, 'app_assets/icons/cleaning_icon.png', 1.0);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0x40000000)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(tileRect.size.width / 2, 0)
      ..lineTo(tileRect.size.width, tileRect.size.height / 2)
      ..lineTo(tileRect.size.width / 2, tileRect.size.height)
      ..lineTo(0, tileRect.size.height / 2)
      ..close();

    canvas.drawPath(path, paint);

    super.render(canvas);
    renderProgress(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateProgress(dt);
  }
}

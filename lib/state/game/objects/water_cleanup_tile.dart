import 'dart:async';

import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class WaterCleanupTile extends BuildingTile {
  WaterCleanupTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.waterCleanup);

  double _cleaningTimeElapsed = AppTimes.waterCleanupDuration;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    _cleaningTimeElapsed += dt;
    if (_cleaningTimeElapsed >= AppTimes.townHallCleanupDuration) {
      // setup a tile to be cleaned
      scheduleMicrotask(() {
        _initiateCleaning(state);
      });
    }
  }

  void _initiateCleaning(GameState state) async {
    final useAutomaticCleanup = state.useAutomaticCleanup;
    for (int i = 0; i < AppAmmounts.waterCleanupCleanupTileSpawnCount; i++) {
      TilePosition? tile = state.getTileToClean(true);
      if (tile == null) {
        if (!useAutomaticCleanup) return;

        final autoTile = CleanupTile.spawn(tilePosition, state, true);
        print('Water cleanup autoTile: ${autoTile?.tilePosition}');

        if (autoTile == null) return;

        tile = autoTile.tilePosition;
      }

      state.cleanTile(tile);
      _cleaningTimeElapsed = 0;
    }
  }
}

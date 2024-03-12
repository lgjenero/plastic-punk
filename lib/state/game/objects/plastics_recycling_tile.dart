import 'dart:async';

import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class PlasticsRecyclingTile extends BuildingTile {
  PlasticsRecyclingTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.plasticRecycling);

  double _timeElapsed = 0;

  double _cleaningTimeElapsed = AppTimes.townHallCleanupDuration;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_timeElapsed >= AppTimes.plasticsRecyclingDuration) {
      scheduleMicrotask(() {
        state.addResource(Resource(type: ResourceType.material, amount: AppAmmounts.plasticRecyclingMaterialAmount));
      });
      _timeElapsed = 0;
    }

    _cleaningTimeElapsed += dt;
    if (_cleaningTimeElapsed >= AppTimes.plasticsRecyclingCleanupDuration) {
      // setup a tile to be cleaned
      scheduleMicrotask(() {
        _initiateCleaning(state);
      });
    } else {
      _timeElapsed += dt;
    }
  }

  void _initiateCleaning(GameState state) async {
    final useAutomaticCleanup = state.useAutomaticCleanup;
    for (int i = 0; i < AppAmmounts.townHallCleanupTileSpawnCount; i++) {
      TilePosition? tile = state.getTileToClean(false);
      if (tile == null) {
        if (!useAutomaticCleanup) return;

        final autoTile = CleanupTile.spawn(tilePosition, state, false);
        if (autoTile == null) return;

        tile = autoTile.tilePosition;
      }

      state.cleanTile(tile);
      _cleaningTimeElapsed = 0;
    }
  }
}

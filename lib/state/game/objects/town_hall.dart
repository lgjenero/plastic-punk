import 'dart:async';

import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class TownHallTile extends BuildingTile {
  TownHallTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.townHall);

  bool _resourcesAdded = false;
  double _timeElapsed = 0;
  double _cleaningTimeElapsed = AppTimes.townHallCleanupDuration;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (!_resourcesAdded) {
      _resourcesAdded = true;
      scheduleMicrotask(() {
        state.addResource(Resource(type: ResourceType.water, amount: AppAmmounts.townHallWaterAmount));
        state.addResource(Resource(type: ResourceType.population, amount: AppAmmounts.townHallPopulationAmount));
        state.addResource(Resource(type: ResourceType.electricity, amount: AppAmmounts.townHallElectricityAmount));
      });
    }

    // _timeElapsed += dt;
    if (_timeElapsed >= AppTimes.townHallProductionDuration) {
      scheduleMicrotask(() {
        state.addResource(Resource(type: ResourceType.material, amount: AppAmmounts.townHallMaterialProductionAmount));
      });
      _timeElapsed = 0;
    }

    _cleaningTimeElapsed += dt;
    if (_cleaningTimeElapsed >= AppTimes.townHallCleanupDuration) {
      // setup a tile to be cleaned
      scheduleMicrotask(() {
        _initiateCleaning(state);
      });
    } else {
      _timeElapsed += dt;
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (!_resourcesAdded) return;
    scheduleMicrotask(() {
      state.removeResource(Resource(type: ResourceType.water, amount: AppAmmounts.townHallWaterAmount));
      state.removeResource(Resource(type: ResourceType.population, amount: AppAmmounts.townHallPopulationAmount));
      state.removeResource(Resource(type: ResourceType.electricity, amount: AppAmmounts.townHallElectricityAmount));
    });
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

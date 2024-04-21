import 'dart:async';

import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';

abstract class BuildingCleaningTile extends BuildingTile {
  final double Function() cleaningPeriod;
  final bool cleansWater;
  final int cleaningCylces;
  final Resource? resourceProduced;

  BuildingCleaningTile({
    required this.cleaningPeriod,
    required this.cleansWater,
    this.cleaningCylces = -1,
    this.pauseCleaning = false,
    this.resourceProduced,
    required super.tilePosition,
    required super.isPaused,
    required super.buildingId,
    super.startsConstructed = false,
    super.addResources,
    super.sfxLoop,
  });

  bool pauseCleaning;
  double _timeElapsed = double.infinity;
  int _cleaningCylcesCompleted = 0;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (pauseCleaning) return;

    if (_timeElapsed >= cleaningPeriod() && canClean) {
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
    TilePosition? tile = state.getTileToClean(cleansWater);
    if (tile == null) {
      if (!useAutomaticCleanup) return;

      final autoTile = CleanupTile.spawn(tilePosition, state, cleansWater);
      if (autoTile == null) return;

      tile = autoTile.tilePosition;
    }

    state.cleanTile(tile, resourceProduced: resourceProduced);
    _timeElapsed = 0;
    _cleaningCylcesCompleted++;
  }

  bool get canClean => cleaningCylces <= 0 || _cleaningCylcesCompleted < cleaningCylces;

  double get cleaningTimeElapsed => _timeElapsed / cleaningPeriod();

  void setCleaningTimeElapsed(double value) {
    _timeElapsed = value * cleaningPeriod();
  }
}

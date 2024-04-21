import 'dart:async';
import 'dart:math';

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/flood_fill.dart';

abstract class BuildingPollutingTile extends BuildingTile {
  final double Function() pollutingPeriod;
  final bool pollutesWater;
  final int pollutingCylces;

  BuildingPollutingTile({
    required this.pollutingPeriod,
    required this.pollutesWater,
    this.pollutingCylces = -1,
    this.pausePollution = true,
    required super.tilePosition,
    required super.isPaused,
    required super.buildingId,
    super.startsConstructed = false,
    super.sfxLoop,
    super.manageTile,
  }) {
    _timeElapsed = Random().nextDouble() * pollutingPeriod();
  }

  bool pausePollution;
  double _timeElapsed = 0;
  int _pollutingCylcesCompleted = 0;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (!canPollute) return;

    if (pausePollution) return;

    if (_timeElapsed >= pollutingPeriod()) {
      // setup a tile to be cleaned
      scheduleMicrotask(() {
        _initiatePolluting(state);
      });
    } else {
      _timeElapsed += dt;
    }
  }

  void _initiatePolluting(GameState state) async {
    if (!canPollute) return;

    final tile = FloodFiller(
      state.mapComponent,
      AppLayers.terrain,
      {...AppTiles.grassTiles, ...AppTiles.forestTiles, ...AppTiles.playerBuildingTiles, ...AppTiles.waterTiles},
      {...AppTiles.enemyBuildingTiles, ...AppTiles.pollutionTiles},
      {},
    ).getNextPoint(tilePosition);
    if (tile == null) return null;

    state.addPollution(tile);
    _timeElapsed = 0;
    _pollutingCylcesCompleted++;
  }

  bool get canPollute => pollutingCylces <= 0 || _pollutingCylcesCompleted < pollutingCylces;

  double get pollutingTimeElapsed => _timeElapsed / pollutingPeriod();

  void setPollutingTimeElapsed(double value) {
    _timeElapsed = value * pollutingPeriod();
  }
}

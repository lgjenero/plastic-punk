import 'dart:async';
import 'dart:math' as math;

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/tile_data.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/math.dart';

class PlasticsFactoryTile extends BuildingTile {
  PlasticsFactoryTile({required super.tilePosition, required super.isPaused, super.startsConstructed = true})
      : super(buildingId: AppTiles.plasticsFactory);

  double _timeElapsed = 0;
  bool _alarmSounded = false;
  int _pollutingDistance = AppAmmounts.plasticsFactoryAlarmDistance;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (!_alarmSounded) {
      final alarmRingTiles = AppMath.getTilesAtDistance(
        tilePosition,
        AppAmmounts.plasticsFactoryAlarmDistance,
        AppLayers.terrain,
        state.mapComponent,
      );

      final alarm = alarmRingTiles.any((e) =>
          !AppTiles.waterPollutedTiles.contains(e.data.tile) && !AppTiles.groundPollutedTiles.contains(e.data.tile));

      if (alarm) {
        _alarmSounded = true;
        state.showMessage(Messages.plasticsFactoryAlarm);
      }
      return;
    }

    _timeElapsed += dt;
    if (_timeElapsed >= AppTimes.plasticsFactoryProductionTime) {
      _timeElapsed = 0;
      scheduleMicrotask(() {
        _initiatePolluting(state);
      });
    }
  }

  void _initiatePolluting(GameState state) async {
    int distance = _pollutingDistance;
    int maxDimension = math.max(state.mapComponent.tileMap.map.width, state.mapComponent.tileMap.map.height);
    int maxCoordinate = math.max(tilePosition.x, tilePosition.y);
    int maxDistance = math.max(maxDimension - maxCoordinate, maxCoordinate);

    TileData? tile;
    while (true) {
      if (distance > maxDistance) break;

      final tilesAtDistance = AppMath.getTilesAtDistance(
        tilePosition,
        distance,
        AppLayers.terrain,
        state.mapComponent,
      );

      if (tilesAtDistance.isEmpty) {
        distance++;
        continue;
      }

      final cleanTiles = tilesAtDistance.where((e) =>
          !AppTiles.waterPollutedTiles.contains(e.data.tile) &&
          !AppTiles.groundPollutedTiles.contains(e.data.tile) &&
          !AppTiles.enemyBuildingTiles.contains(e.data.tile));

      if (cleanTiles.isEmpty) {
        distance++;
        continue;
      }

      tile = cleanTiles.elementAt(math.Random().nextInt(cleanTiles.length));
      break;
    }

    if (tile == null) return;

    state.addPollution(tile.position);
    _pollutingDistance = math.max(1, distance - 2);
  }
}

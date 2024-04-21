import 'dart:async';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_polluting_tile.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/math.dart';

class RoadTile extends BuildingPollutingTile {
  RoadTile({
    required super.tilePosition,
    required super.isPaused,
    super.startsConstructed,
  }) : super(
          buildingId: AppTiles.pollutedTransportationMin,
          manageTile: false,
          pollutingPeriod: () => AppTimes.roadProductionTime,
          pollutesWater: true,
        );

  int _tilesState = -1;
  bool _signalPlaced = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    // update the tracks tile if needed
    if (_tilesState != state.transportsState) {
      _tilesState = state.transportsState;

      final tileId = _calculateTileId(state);
      state.mapComponent.tileMap.setTileData(
        layerId: AppLayers.terrain,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: Gid(tileId, const Flips.defaults()),
      );

      if (!_signalPlaced) {
        _signalPlaced = true;
        scheduleMicrotask(() {
          state.checkBuildTransport();
        });
      }
    }
  }

  @override
  void remove(GameState state) {
    scheduleMicrotask(() {
      super.remove(state);
      state.checkDestroyTransport();
    });
  }

  int _calculateTileId(GameState state) {
    bool left = false;
    bool right = false;
    bool top = false;
    bool bottom = false;

    final neighbours = AppMath.getNeighbouringTiles(tilePosition, AppLayers.terrain, state.mapComponent);
    for (final neighbour in neighbours) {
      if (AppTiles.pollutedTransportationTiles.contains(neighbour.data.tile) ||
          neighbour.data.tile == AppTiles.badTownHall) {
        if (neighbour.position == tilePosition.left) left = true;
        if (neighbour.position == tilePosition.right) right = true;
        if (neighbour.position == tilePosition.up) top = true;
        if (neighbour.position == tilePosition.down) bottom = true;
      }
    }

    if (left) {
      if (right) {
        if (top) {
          if (bottom) {
            return AppTiles.roadCross;
          } else {
            return AppTiles.roadLeftUpRight;
          }
        } else {
          if (bottom) {
            return AppTiles.roadRightDownLeft;
          } else {
            return AppTiles.roadLeftRight;
          }
        }
      } else {
        if (top) {
          if (bottom) {
            return AppTiles.roadDownLeftUp;
          } else {
            return AppTiles.roadUpLeft;
          }
        } else {
          if (bottom) {
            return AppTiles.roadDownLeft;
          } else {
            return AppTiles.roadLeftRight;
          }
        }
      }
    } else {
      if (right) {
        if (top) {
          if (bottom) {
            return AppTiles.roadDownRightUp;
          } else {
            return AppTiles.roadUpRight;
          }
        } else {
          if (bottom) {
            return AppTiles.roadDownRight;
          } else {
            return AppTiles.roadLeftRight;
          }
        }
      } else {
        if (top) {
          if (bottom) {
            return AppTiles.roadUpDown;
          } else {
            return AppTiles.roadUpDown;
          }
        } else {
          if (bottom) {
            return AppTiles.roadUpDown;
          } else {
            return AppTiles.roadLeftRight;
          }
        }
      }
    }
  }
}

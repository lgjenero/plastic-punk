import 'dart:async';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/math.dart';

class TracksTile extends BuildingTile {
  TracksTile({
    required super.tilePosition,
    required super.isPaused,
    super.startsConstructed,
    super.addResources,
  }) : super(buildingId: AppTiles.transportationMin, manageTile: false);

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
    super.remove(state);
    scheduleMicrotask(() {
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
      if (AppTiles.transportationTiles.contains(neighbour.data.tile) || neighbour.data.tile == AppTiles.townHall) {
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
            return AppTiles.tracksCross;
          } else {
            return AppTiles.tracksLeftUpRight;
          }
        } else {
          if (bottom) {
            return AppTiles.tracksRightDownLeft;
          } else {
            return AppTiles.tracksLeftRight;
          }
        }
      } else {
        if (top) {
          if (bottom) {
            return AppTiles.tracksDownLeftUp;
          } else {
            return AppTiles.tracksUpLeft;
          }
        } else {
          if (bottom) {
            return AppTiles.tracksDownLeft;
          } else {
            return AppTiles.tracksLeftRight;
          }
        }
      }
    } else {
      if (right) {
        if (top) {
          if (bottom) {
            return AppTiles.tracksDownRightUp;
          } else {
            return AppTiles.tracksUpRight;
          }
        } else {
          if (bottom) {
            return AppTiles.tracksDownRight;
          } else {
            return AppTiles.tracksLeftRight;
          }
        }
      } else {
        if (top) {
          if (bottom) {
            return AppTiles.tracksUpDown;
          } else {
            return AppTiles.tracksUpDown;
          }
        } else {
          if (bottom) {
            return AppTiles.tracksUpDown;
          } else {
            return AppTiles.tracksLeftRight;
          }
        }
      }
    }
  }
}

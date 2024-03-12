import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/icon_component.dart';
import 'package:plastic_punk/state/game/components/progress_component.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/math.dart';

abstract class BuildingTile extends GameObject {
  final int buildingId;
  final bool startsConstructed;
  final TilePosition tilePosition;

  BuildingTile(
      {required this.tilePosition, required super.isPaused, required this.buildingId, this.startsConstructed = false})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  bool _buildingAdded = false;
  double _timeElapsed = 0;
  BuildingTileObject? _buildingTileObject;

  bool _constructionAdded = false;
  bool _constructed = false;
  bool get constructed => _constructed;
  final bool _resourcesAdded = false;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    // add the construction component
    if (!_constructionAdded) {
      _constructionAdded = true;

      // add the building ground to the map
      state.mapComponent.tileMap.setTileData(
        layerId: AppLayers.terrain,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: const Gid(AppTiles.buildingGround, Flips.defaults()),
      );

      // clear forest around the building
      final getSurroundingTiles = AppMath.getSurroundingTiles(tilePosition, 1, AppLayers.terrain, state.mapComponent);
      for (final tile in getSurroundingTiles) {
        final tileId = tile.data.tile;
        if (tileId >= AppTiles.forestMin && tileId <= AppTiles.forestMax) {
          state.mapComponent.tileMap.setTileData(
            layerId: AppLayers.terrain,
            x: tile.position.x,
            y: tile.position.y,
            gid: Gid(
              math.Random().nextInt(AppTiles.grassSquareMax - AppTiles.grassMin) + AppTiles.grassMin,
              const Flips.defaults(),
            ),
          );
        }
      }

      // clear forest around the building in the template layer
      final getTemplateSurroundingTiles =
          AppMath.getSurroundingTiles(tilePosition, 1, AppLayers.template, state.mapComponent);
      for (final tile in getTemplateSurroundingTiles) {
        final tileId = tile.data.tile;
        if (tileId >= AppTiles.forestMin && tileId <= AppTiles.forestMax) {
          state.mapComponent.tileMap.setTileData(
            layerId: AppLayers.template,
            x: tile.position.x,
            y: tile.position.y,
            gid: Gid(
              AppTiles.grassSquareTiles.elementAt(math.Random().nextInt((AppTiles.grassSquareTiles.length))),
              const Flips.defaults(),
            ),
          );
        }
      }

      // state.mapComponent.tileMap.setTileData(
      //   layerId: AppLayers.build,
      //   x: tile.x,
      //   y: tile.y,
      //   gid: const Gid(AppTiles.buildingGround, Flips.defaults()),
      // );

      if (startsConstructed) {
        _constructed = true;
      } else {
        // add the transparent overlay
        state.mapComponent.tileMap.setTileData(
          layerId: AppLayers.overlay,
          x: tilePosition.x,
          y: tilePosition.y,
          gid: Gid(buildingId, const Flips.defaults()),
        );

        _buildingTileObject = BuildingTileObject(tilePosition, state);
        state.mapComponent.add(_buildingTileObject!);
      }
    }

    if (!_constructed) {
      _timeElapsed += dt;

      // if the construction duration has passed, remove the cleanup tile
      if (_timeElapsed > AppTimes.buildingConstruction) {
        _constructed = true;
      }
    }

    if (_constructed) {
      if (!_buildingAdded) {
        _buildingAdded = true;

        scheduleMicrotask(() {
          _removeConstructionComponent(state);

          // remove the transparent overlay
          state.mapComponent.tileMap.setTileData(
            layerId: AppLayers.overlay,
            x: tilePosition.x,
            y: tilePosition.y,
            gid: const Gid(0, Flips.defaults()),
          );

          // add the building to the map
          state.mapComponent.tileMap.setTileData(
            layerId: AppLayers.terrain,
            x: tilePosition.x,
            y: tilePosition.y,
            gid: Gid(buildingId, const Flips.defaults()),
          );
        });
      }
    }
  }

  void _removeConstructionComponent(GameState state) {
    if (_buildingTileObject != null) {
      state.mapComponent.remove(_buildingTileObject!);
      _buildingTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    scheduleMicrotask(() {
      state.remove(this);

      // remove the cleanup tile from the map
      _removeConstructionComponent(state);

      // remove the building from the map and put grass back
      state.mapComponent.tileMap.setTileData(
        layerId: AppLayers.terrain,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: Gid(
          math.Random().nextInt(AppTiles.grassSquareMax - AppTiles.grassMin) + AppTiles.grassMin,
          const Flips.defaults(),
        ),
      );
    });
  }
}

class BuildingTileObject extends TileComponent with Progress, Icon {
  BuildingTileObject(TilePosition tilePosition, GameState state) : super(tilePosition, state) {
    initializeProgress(state, AppTimes.buildingConstruction);
    initializeIcon(state, 'app_assets/icons/constructing_icon.png', 1.0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderProgress(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateProgress(dt);
  }
}

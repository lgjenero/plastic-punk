import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:plastic_punk/state/game/components/icon_component.dart';
import 'package:plastic_punk/state/game/components/progress_component.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/objects/house_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_recycling_tile.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class DiplomaticMissionTile extends GameObject {
  final TilePosition tilePosition;

  DiplomaticMissionTile({required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  double _timeElapsed = 0;
  DiplomaticMissionTileObject? _missionTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    _timeElapsed += dt;

    // if the missin duration has passed, remove the mission tile
    if (_timeElapsed > AppTimes.diplomacyDuration) {
      scheduleMicrotask(() {
        state.remove(this);

        // remove the cleanup tile from the map
        if (_missionTileObject != null) {
          state.mapComponent.remove(_missionTileObject!);
        }

        // remove the enemy building
        final enemyBuilding = state.objects.whereType<BuildingTile>().firstWhereOrNull(
              (e) => e.tilePosition == tilePosition,
            );
        if (enemyBuilding == null) throw Exception('No enemy building found at $tilePosition');
        enemyBuilding.remove(state);

        // add the eco building
        if (enemyBuilding.buildingId == AppTiles.badHousing) {
          state.add(HouseTile(tilePosition: tilePosition, isPaused: isPaused));
        } else if (enemyBuilding.buildingId == AppTiles.plasticsFactory) {
          state.add(PlasticsRecyclingTile(tilePosition: tilePosition, isPaused: isPaused));
        } else {
          throw Exception('Unknown building id: ${enemyBuilding.buildingId}');
        }
      });

      return;
    }

    if (_missionTileObject == null) {
      _missionTileObject = DiplomaticMissionTileObject(tilePosition, state);
      state.mapComponent.add(_missionTileObject!);
    }
  }

  @override
  void remove(GameState state) {
    if (_missionTileObject != null) {
      state.mapComponent.remove(_missionTileObject!);
    }
  }
}

class DiplomaticMissionTileObject extends TileComponent with Progress, Icon {
  DiplomaticMissionTileObject(TilePosition tilePosition, GameState state) : super(tilePosition, state) {
    initializeProgress(state, AppTimes.diplomacyDuration);
    initializeIcon(state, 'app_assets/icons/diplomatic_mission.png', 1.0);
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

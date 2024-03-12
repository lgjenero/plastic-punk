import 'dart:async';

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class WaterTreatmentTile extends BuildingTile {
  WaterTreatmentTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.waterTreatment);

  double _timeElapsed = 0;

  bool _waterAdded = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (!_waterAdded) {
      _waterAdded = true;
      scheduleMicrotask(() {
        state.addResource(Resource(type: ResourceType.water, amount: AppAmmounts.waterTreatmentWaterAmount));
      });
    }

    _timeElapsed += dt;

    // TODO: what does the water cleanup do?
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (!_waterAdded) return;
    scheduleMicrotask(() {
      state.removeResource(Resource(type: ResourceType.water, amount: AppAmmounts.waterTreatmentWaterAmount));
    });
  }
}

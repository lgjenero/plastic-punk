import 'dart:async';

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class SolarPanelsTile extends BuildingTile {
  SolarPanelsTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.solarPanels);

  double _timeElapsed = 0;

  bool _electricityAdded = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (!_electricityAdded) {
      _electricityAdded = true;
      scheduleMicrotask(() {
        state.addResource(Resource(type: ResourceType.electricity, amount: AppAmmounts.solarPanelsElectricityAmount));
      });
    }

    _timeElapsed += dt;

    // TODO: what does the solar panels do?
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (!_electricityAdded) return;
    scheduleMicrotask(() {
      state.removeResource(Resource(type: ResourceType.electricity, amount: AppAmmounts.solarPanelsElectricityAmount));
    });
  }
}

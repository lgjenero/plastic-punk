import 'dart:async';

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class HouseTile extends BuildingTile {
  HouseTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.house);

  bool _populdationAdded = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_populdationAdded) return;
    _populdationAdded = true;
    scheduleMicrotask(() {
      state.addResource(Resource(type: ResourceType.population, amount: AppAmmounts.housePopulationAmount));
    });
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (!_populdationAdded) return;
    scheduleMicrotask(() {
      state.removeResource(Resource(type: ResourceType.population, amount: AppAmmounts.housePopulationAmount));
    });
  }
}

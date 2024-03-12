import 'dart:async';

import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class GardenTile extends BuildingTile {
  GardenTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.garden);

  bool _foodAdded = false;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_foodAdded) return;
    _foodAdded = true;
    scheduleMicrotask(() {
      state.addResource(Resource(type: ResourceType.food, amount: AppAmmounts.gardenFoodAmount));
    });
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    if (!_foodAdded) return;
    scheduleMicrotask(() {
      state.removeResource(Resource(type: ResourceType.food, amount: AppAmmounts.gardenFoodAmount));
    });
  }
}

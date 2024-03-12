import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class BadHousingTile extends BuildingTile {
  BadHousingTile({required super.tilePosition, required super.isPaused, super.startsConstructed = true})
      : super(buildingId: AppTiles.badHousing);

  double _timeElapsed = 0;

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;
    _timeElapsed += dt;

    // TODO: what does the bad housing do?
  }
}

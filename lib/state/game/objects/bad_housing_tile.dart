import 'package:plastic_punk/state/game/objects/building_polluting_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class BadHousingTile extends BuildingPollutingTile {
  BadHousingTile({required super.tilePosition, required super.isPaused, super.startsConstructed = true})
      : super(
          buildingId: AppTiles.badHousing,
          sfxLoop: SfxLoop.badHousing,
          pollutingPeriod: () => AppTimes.badHousingProductionTime,
          pollutesWater: true,
        );
}

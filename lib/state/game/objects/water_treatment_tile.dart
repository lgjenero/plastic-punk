import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class WaterTreatmentTile extends BuildingTile {
  WaterTreatmentTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.waterTreatment, sfxLoop: SfxLoop.waterTreatment);
}

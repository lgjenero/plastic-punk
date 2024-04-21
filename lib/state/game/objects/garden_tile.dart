import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class GardenTile extends BuildingTile {
  GardenTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.garden, sfxLoop: SfxLoop.garden);
}

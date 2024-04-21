import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class HouseTile extends BuildingTile {
  HouseTile({required super.tilePosition, required super.isPaused, super.startsConstructed, super.addResources})
      : super(buildingId: AppTiles.house, sfxLoop: SfxLoop.house);
}

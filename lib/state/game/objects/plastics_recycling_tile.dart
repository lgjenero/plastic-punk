import 'package:plastic_punk/state/game/objects/building_cleaning_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class PlasticsRecyclingTile extends BuildingCleaningTile {
  PlasticsRecyclingTile({
    required super.tilePosition,
    required super.isPaused,
    super.startsConstructed,
    super.addResources,
  }) : super(
          cleaningPeriod: () => AppTimes.townHallCleanupDuration,
          cleansWater: false,
          resourceProduced:
              const Resource(type: ResourceType.material, amount: AppAmmounts.plasticRecyclingMaterialAmount),
          buildingId: AppTiles.plasticRecycling,
        );
}

import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class EducationCentreTile extends BuildingTile {
  final int diplomacyCycles;

  EducationCentreTile(
      {required super.tilePosition, required super.isPaused, this.diplomacyCycles = 1, super.startsConstructed})
      : super(buildingId: AppTiles.educationCentre, sfxLoop: SfxLoop.education);

  int _diplomacyExecuted = 0;

  bool get canExecuteDiplomacy => diplomacyCycles > 0 && _diplomacyExecuted < diplomacyCycles;

  void diplomacyExecuted() {
    _diplomacyExecuted++;
  }

  int get diplomacyExecutedCount => _diplomacyExecuted;
}

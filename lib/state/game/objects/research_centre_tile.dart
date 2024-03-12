import 'dart:async';

import 'package:plastic_punk/state/game/components/progress_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class ResearchCentreTile extends BuildingTile {
  ResearchCentreTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.researchCentre);

  double _timeElapsed = 0;
  TechnologyType? _researching;
  ResearchCentreTileObject? _researchCentreTileObject;

  TechnologyType? get researching => _researching;
  bool get isResearching => _researching != null;

  void startResearch(TechnologyType technology) {
    if (_researching != null) return;
    _researching = technology;
    _timeElapsed = 0;
  }

  @override
  void update(double dt, GameState state) {
    super.update(dt, state);

    if (isPaused) return;

    if (!constructed) return;

    if (_researching == null) return;

    if (_researchCentreTileObject == null) {
      _createProgress(state);
      return;
    }

    _timeElapsed += dt;
    if (_timeElapsed >= AppTimes.researchCentreResearchDuration) {
      _timeElapsed = 0;
      scheduleMicrotask(() {
        final tech = _researching!;
        _researching = null;
        _removeProgress(state);
        state.addTechnology(tech);
      });
    }
  }

  void _createProgress(GameState state) {
    _researchCentreTileObject = ResearchCentreTileObject(tilePosition, state);
    state.mapComponent.add(_researchCentreTileObject!);
  }

  void _removeProgress(GameState state) {
    if (_researchCentreTileObject != null) {
      state.mapComponent.remove(_researchCentreTileObject!);
      _researchCentreTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    _removeProgress(state);
  }
}

class ResearchCentreTileObject extends ProgressComponent {
  ResearchCentreTileObject(TilePosition tilePosition, GameState state)
      : super(tilePosition, state, AppTimes.researchCentreResearchDuration);
}

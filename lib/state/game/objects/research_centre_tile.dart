import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/state/game/components/progress_component.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/events/event.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/state/game/snackbars/snackbars.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class ResearchCentreTile extends BuildingTile {
  ResearchCentreTile({required super.tilePosition, required super.isPaused, super.startsConstructed})
      : super(buildingId: AppTiles.researchCentre, sfxLoop: SfxLoop.research);

  double _timeElapsed = 0;
  TechnologyType? _researching;
  ResearchCentreTileObject? _researchCentreTileObject;
  ResearchCentreProgressTileObject? _researchCentreProgressTileObject;

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

    if (_researchCentreTileObject == null) {
      _createComponent(state);
      return;
    }

    if (_researching == null) return;

    if (_researchCentreProgressTileObject == null) {
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
        state.showSnackbar(GameSnackbars.researchCompleted(tech));
        state.onEvent(Event(tag: EventTag.technologyResearched, data: {'type': tech}));
      });
    }
  }

  void _createComponent(GameState state) {
    final tileSize = state.mapComponent.tileMap.destTileSize;
    final scale = tileSize.x / 256;

    final researchSheet = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('animations/research.png'),
        SpriteAnimationData.variable(
          amount: 24,
          stepTimes: List.generate(24, (index) => 0.8),
          textureSize: Vector2(32, 32),
          amountPerRow: 8,
        ));

    final leafFrames = researchSheet.frames.getRange(0, 8).toList();
    final petalsFrames = researchSheet.frames.getRange(8, 16).toList();

    // leaf 1 -> 0.496, 0.275
    // leaf 2 -> 0.586, 0.181

    // petals -> 0.21, 0.01875

    final animations = [
      SpriteAnimationComponent(
        animation: SpriteAnimation(leafFrames, loop: true),
        size: Vector2.all(32 * scale),
        position: Vector2(0.586 * tileSize.x, 0.181 * tileSize.y),
        anchor: Anchor.bottomLeft,
      ),
      SpriteAnimationComponent(
        animation: SpriteAnimation(leafFrames, loop: true),
        size: Vector2.all(32 * scale),
        position: Vector2(0.496 * tileSize.x, 0.275 * tileSize.y),
        anchor: Anchor.bottomLeft,
      ),
      SpriteAnimationComponent(
        animation: SpriteAnimation(petalsFrames, loop: true),
        size: Vector2.all(32 * scale),
        position: Vector2(0.22 * tileSize.x, 0.05 * tileSize.y),
        anchor: Anchor.bottomLeft,
      ),
    ];

    _researchCentreTileObject = ResearchCentreTileObject(animations, tilePosition, state);
    state.mapComponent.add(_researchCentreTileObject!);
  }

  void _removeComponent(GameState state) {
    if (_researchCentreTileObject != null) {
      state.mapComponent.remove(_researchCentreTileObject!);
      _researchCentreTileObject = null;
    }
  }

  void _createProgress(GameState state) {
    _researchCentreProgressTileObject = ResearchCentreProgressTileObject(tilePosition, state);
    state.mapComponent.add(_researchCentreProgressTileObject!);
  }

  void _removeProgress(GameState state) {
    if (_researchCentreProgressTileObject != null) {
      state.mapComponent.remove(_researchCentreProgressTileObject!);
      _researchCentreProgressTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    super.remove(state);
    _removeComponent(state);
    _removeProgress(state);
  }
}

class ResearchCentreTileObject extends TileAnimationComponent {
  ResearchCentreTileObject(super.animationComponent, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));
}

class ResearchCentreProgressTileObject extends ProgressComponent {
  ResearchCentreProgressTileObject(TilePosition tilePosition, GameState state)
      : super(
          tilePosition,
          state,
          AppTimes.researchCentreResearchDuration,
        );
}

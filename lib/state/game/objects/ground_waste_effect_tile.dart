import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/objects/sfx_tile.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart' as sfx;
import 'package:plastic_punk/utils/constants/priorities.dart';

class GroundWasteEffectTile extends GameObject with Sfx {
  final TilePosition tilePosition;
  GroundWasteEffectTileObject? _animationComponent;

  GroundWasteEffectTile({
    required this.tilePosition,
    required super.isPaused,
  }) : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble()) {
    setupSfx(true, sfx.SfxLoop.wind);
  }

  @override
  void remove(GameState state) {
    if (_animationComponent != null) {
      state.mapComponent.remove(_animationComponent!);
    }
  }

  @override
  void update(double dt, GameState state) {
    checkSfxLoop(state, tilePosition);

    if (_animationComponent == null) {
      // final animation = _animationComponent = GroundWasteEffectTileObject(
      //   animationComponent: this,
      //   tilePosition: tilePosition,
      //   state: state,
      // );
      // state.mapComponent.add(_animationComponent);
    }
  }
}

class GroundWasteEffectTileObject extends TileAnimationComponent {
  GroundWasteEffectTileObject(super.animationComponent, super.tilePosition, super.state)
      : super(priority: AppRenderPriorities.buildingPriority(state, tilePosition));
}

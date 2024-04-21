import 'dart:math' as math;

import 'package:flame/extensions.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart' as sfx;
import 'package:plastic_punk/utils/math/math.dart';

mixin Sfx on GameObject {
  late bool _soundEnabled = true;
  late sfx.SfxLoop? _sfxLoop;

  void setupSfx(bool soundEnabled, sfx.SfxLoop? sfxLoop) {
    _soundEnabled = soundEnabled;
    _sfxLoop = sfxLoop;
  }

  void checkSfxLoop(GameState state, TilePosition tilePosition) {
    if (!_soundEnabled) return;

    final sfxLoop = _sfxLoop;
    if (sfxLoop == null) return;

    final cameraTilePosition = AppMath.positionToTileDouble(
      state.camera.visibleWorldRect.center.toVector2(),
      state.mapComponent.tileMap.destTileSize,
      state.mapComponent.tileMap.map.width,
      state.mapComponent.tileMap.map.height,
    );
    final cameraDiameter = math.min(
      state.camera.visibleWorldRect.size.width / state.mapComponent.tileMap.destTileSize.x,
      state.camera.visibleWorldRect.size.height / state.mapComponent.tileMap.destTileSize.y,
    );

    final distance = cameraTilePosition.distanceTo(tilePosition.toVector2()) / cameraDiameter;
    if (distance > 1) return;

    // volume distance depends on the distance from the center of the camera
    final volumeDistance = math.exp(-distance * 4);

    // max volume depends on the zoom level
    final volumeMax = ((10 - cameraDiameter) / 10).clamp(0.1, 1);

    sfx.Sfx.setEffectVolume(sfxLoop, volumeDistance * volumeMax);
  }
}

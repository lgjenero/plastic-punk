import 'dart:ui';

import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';

mixin Progress on TileComponent {
  double timeElapsed = 0;
  late final Rect _rect;
  late final double duration;

  Rect get progressRect => _rect;

  void initializeProgress(GameState state, double duration) {
    this.duration = duration;
    final tileSize = state.mapComponent.tileMap.destTileSize;
    _rect = Rect.fromLTWH(
      tileSize.x * 0.2,
      tileSize.y * 0.45,
      tileRect.width * 0.6,
      tileRect.height * 0.1,
    );
  }

  void renderProgress(Canvas canvas) {
    canvas.drawRect(
        _rect,
        Paint()
          ..color = AppColors.progressBar
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);

    final bar = Rect.fromLTWH(
      _rect.left + 1,
      _rect.top + 1,
      (_rect.width - 2) * (timeElapsed / duration).clamp(0, 1),
      _rect.height - 2,
    );

    canvas.drawRect(
        bar,
        Paint()
          ..color = AppColors.progressBar
          ..style = PaintingStyle.fill);
  }

  void updateProgress(double dt) {
    timeElapsed += dt;
  }
}

class ProgressComponent extends TileComponent with Progress {
  ProgressComponent(TilePosition position, GameState state, double duration)
      : super(position, state, priority: AppRenderPriorities.progress) {
    initializeProgress(state, duration);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderProgress(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateProgress(dt);
  }
}

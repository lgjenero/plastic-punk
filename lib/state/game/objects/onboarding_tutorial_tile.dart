import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/math.dart';

class OnboardingTutorialTile extends GameObject {
  final OnboardingTooltip tooltip;
  final TilePosition tilePosition;

  OnboardingTutorialTile({required this.tooltip, required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  bool _highlightAdded = false;
  final bool _highlightOk = true;

  OnboardingTutorialTileObject? _tooltipTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    // check if the tile is valid (not polluted)
    final pollutionTile = state.mapComponent.tileMap.getTileData(
      layerId: AppLayers.terrain,
      x: tilePosition.x,
      y: tilePosition.y,
    );

    final highlightOk = AppTiles.pollutionTiles.contains(pollutionTile?.tile);
    if (highlightOk != _highlightOk) {
      if (!highlightOk) {
        scheduleMicrotask(() {
          remove(state);
        });
        return;
      }
    }

    if (!_highlightAdded) {
      _highlightAdded = true;
      scheduleMicrotask(() {
        final tileSize = state.mapComponent.tileMap.destTileSize;
        final animation = SpriteAnimationComponent.fromFrameData(
          Flame.images.fromCache('animations/tap.png'),
          SpriteAnimationData.variable(
            amount: 15,
            stepTimes: List.generate(15, (index) => 0.2),
            textureSize: Vector2(48, 60),
            amountPerRow: 4,
          ),
          size: Vector2(12, 15),
          position: Vector2(tileSize.x * 0.5, tileSize.y * 0.5),
          anchor: Anchor.center,
        );

        _tooltipTileObject = OnboardingTutorialTileObject(
          [animation],
          tilePosition,
          state,
          onTap: () {
            scheduleMicrotask(() {
              state.removeTooltips(tooltip);
              state.cleanTile(tilePosition);
            });
          },
        );
        state.mapComponent.add(_tooltipTileObject!);
      });
    }
  }

  void _removeComponent(GameState state) {
    if (_tooltipTileObject != null) {
      state.mapComponent.remove(_tooltipTileObject!);
      _tooltipTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    scheduleMicrotask(() {
      state.remove(this);

      // remove the cleanup tile from the map
      _removeComponent(state);
    });
  }
}

class OnboardingTutorialTileObject extends TileAnimationComponent with TapCallbacks {
  final VoidCallback? onTap;
  OnboardingTutorialTileObject(super.animationComponents, super.tilePosition, super.state, {this.onTap})
      : super(priority: AppRenderPriorities.progress);

  @override
  void onTapUp(TapUpEvent event) {
    onTap?.call();
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    final a = Vector2(0, tileRect.height / 2);
    final b = Vector2(tileRect.width / 2, 0);
    final c = Vector2(tileRect.width, tileRect.height / 2);
    final d = Vector2(tileRect.width / 2, tileRect.height);

    return AppMath.isPointInPolygon([a, b, c, d], point);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = const Color(0x40000000)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(tileRect.size.width / 2, 0)
      ..lineTo(tileRect.size.width, tileRect.size.height / 2)
      ..lineTo(tileRect.size.width / 2, tileRect.size.height)
      ..lineTo(0, tileRect.size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }
}

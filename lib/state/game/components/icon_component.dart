import 'dart:ui';

import 'package:flame/components.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';

mixin Icon on TileComponent {
  late final String iconPath;
  late final double aspectRatio;
  late final Rect _rect;

  Rect get iconRect => _rect;

  void initializeIcon(GameState state, String iconPath, double aspectRatio) async {
    this.iconPath = iconPath;
    this.aspectRatio = aspectRatio;

    double width = tileRect.width * 0.3;
    double height = tileRect.height * 0.3;
    final spaceAspectRatio = width / height;
    if (spaceAspectRatio > aspectRatio) {
      width = height * aspectRatio;
    } else {
      height = width / aspectRatio;
    }

    _rect = Rect.fromLTWH(
      (tileRect.width - width) * 0.5,
      tileRect.height * 0.1,
      width,
      height,
    );

    final sprite = await Sprite.load(iconPath);

    if (isRemoved || isRemoving) return;

    final spriteComponent = SpriteComponent(
      sprite: sprite,
      position: Vector2(_rect.left, _rect.top),
      size: Vector2(_rect.width, _rect.height),
    );

    add(spriteComponent);
  }
}

class IconComponent extends TileComponent with Icon {
  IconComponent(TilePosition tilePosition, GameState state, String iconPath, {double aspectRatio = 1.0})
      : super(tilePosition, state) {
    initializeIcon(state, iconPath, aspectRatio);
  }
}

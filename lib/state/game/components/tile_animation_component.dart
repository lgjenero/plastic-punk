import 'package:flame/components.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';

mixin Animation on TileComponent {
  late final List<SpriteAnimationComponent> animationComponents;

  void initializeAnimation(List<SpriteAnimationComponent> animationComponents) {
    this.animationComponents = animationComponents;
    addAll(animationComponents);
  }
}

class TileAnimationComponent extends TileComponent with Animation {
  TileAnimationComponent(
    List<SpriteAnimationComponent> animationComponents,
    super.position,
    super.state, {
    super.priority,
  }) {
    initializeAnimation(animationComponents);
  }
}

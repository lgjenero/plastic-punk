import 'package:flame/components.dart';
import 'package:plastic_punk/state/game/components/tile_component.dart';

mixin Sprite on TileComponent {
  late final List<SpriteComponent> spriteComponents;

  void initializeSprites(List<SpriteComponent> spriteComponents) {
    this.spriteComponents = spriteComponents;
    addAll(spriteComponents);
  }
}

class TileSpriteComponent extends TileComponent with Sprite {
  TileSpriteComponent(List<SpriteComponent> spriteComponents, super.position, super.state, {super.priority}) {
    initializeSprites(spriteComponents);
  }
}

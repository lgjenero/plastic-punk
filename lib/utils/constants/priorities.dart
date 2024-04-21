import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';

int _test = 1500;

abstract class AppRenderPriorities {
  static const int terrainAnimations = 1;
  static const int buildings = 1000;
  // static const int buildingAnimations = 2000;
  static const int progress = 3000;
  static const int icons = 4000;
  static const int selection = 5000;

  static int buildingPriority(GameState state, TilePosition tilePosition) {
    final mapWidth = state.mapComponent.tileMap.map.width;
    int priorityIndex = tilePosition.y * mapWidth + tilePosition.x;
    return buildings + priorityIndex;
  }
}

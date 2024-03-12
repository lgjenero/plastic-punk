import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';

class TileData {
  final int layerId;
  final TilePosition position;
  final Gid data;

  TileData({
    required this.layerId,
    required this.position,
    required this.data,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TileData && other.layerId == layerId && other.position == position && other.data.tile == data.tile;
  }

  @override
  int get hashCode => Object.hash(layerId, position, data.tile);
}

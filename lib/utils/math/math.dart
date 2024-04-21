import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/logic/tile_data.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';

class AppMath {
  static Vector2 viewportSize(Vector2 canvasSize) {
    final aspectRatio = canvasSize.x / canvasSize.y;
    final width = AppSizes.tile.width * 4;
    final height = width / aspectRatio;
    return Vector2(width, height);
  }

  static TilePosition positionToTile(Vector2 position, Vector2 tileSize, int mapWidth, int mapHeight) {
    final start = Vector2(mapWidth / 2 * tileSize.x, 0);
    final x = position.x - start.x;
    final y = position.y;
    final xMove = x / (tileSize.x / 2);
    final yMove = y / (tileSize.y / 2);
    final tileX = (xMove + yMove) / 2;
    final tileY = (yMove - xMove) / 2;
    return TilePosition(x: tileX.floor(), y: tileY.floor());
  }

  static Vector2 positionToTileDouble(Vector2 position, Vector2 tileSize, int mapWidth, int mapHeight) {
    final start = Vector2(mapWidth / 2 * tileSize.x, 0);
    final x = position.x - start.x;
    final y = position.y;
    final xMove = x / (tileSize.x / 2);
    final yMove = y / (tileSize.y / 2);
    final tileX = (xMove + yMove) / 2;
    final tileY = (yMove - xMove) / 2;
    return Vector2(tileX, tileY);
  }

  static Rect getTilePosition(TilePosition position, Vector2 tileSize, int mapWidth, int mapHeight) {
    final start = Vector2(mapWidth / 2 * tileSize.x, 0);
    final xMove = Vector2(position.x * (tileSize.x / 2), position.x * tileSize.y / 2);
    final yMove = Vector2(-position.y * tileSize.x / 2, position.y * (tileSize.y / 2));
    final point = start + xMove + yMove;
    return Rect.fromLTWH(point.x - tileSize.x / 2, point.y, tileSize.x, tileSize.y);
  }

  static List<TileData> getSurroundingTiles(
      TilePosition position, int radius, int layerId, TiledComponent mapComponent) {
    final mapWidth = mapComponent.tileMap.map.width;
    final mapHeight = mapComponent.tileMap.map.height;
    final tiles = <TileData>[];

    for (int i = -radius; i <= radius; i++) {
      for (int j = -radius; j <= radius; j++) {
        if (position.x + i < 0 || position.x + i >= mapWidth) continue;
        if (position.y + j < 0 || position.y + j >= mapHeight) continue;
        tiles.add(
          TileData(
            layerId: layerId,
            position: TilePosition(x: position.x + i, y: position.y + j),
            data: mapComponent.tileMap.getTileData(layerId: layerId, x: position.x + i, y: position.y + j) ??
                const Gid(0, Flips.defaults()),
          ),
        );
      }
    }

    return tiles;
  }

  static List<TileData> getNeighbouringTiles(TilePosition position, int layerId, TiledComponent mapComponent) {
    final mapWidth = mapComponent.tileMap.map.width;
    final mapHeight = mapComponent.tileMap.map.height;
    final points = [
      TilePosition(x: position.x - 1, y: position.y),
      TilePosition(x: position.x + 1, y: position.y),
      TilePosition(x: position.x, y: position.y - 1),
      TilePosition(x: position.x, y: position.y + 1),
    ];
    final tiles = <TileData>{};
    for (var point in points) {
      if (point.x < 0 || point.x >= mapWidth) continue;
      if (point.y < 0 || point.y >= mapHeight) continue;
      tiles.add(
        TileData(
          layerId: layerId,
          position: point,
          data: mapComponent.tileMap.getTileData(layerId: layerId, x: point.x, y: point.y) ??
              const Gid(0, Flips.defaults()),
        ),
      );
    }

    return tiles.toList();
  }

  static List<TileData> getTilesAtDistance(
      TilePosition position, int distance, int layerId, TiledComponent mapComponent) {
    final mapWidth = mapComponent.tileMap.map.width;
    final mapHeight = mapComponent.tileMap.map.height;
    final tiles = <TileData>{};

    for (int i = -distance; i <= distance; i++) {
      List<TilePosition> points = [];

      // top edge
      int topPointX = position.x + i;
      int topPointY = position.y - distance;
      points.add(TilePosition(x: topPointX, y: topPointY));

      // bottom edge
      int bottomPointX = position.x + i;
      int bottomPointY = position.y + distance;
      points.add(TilePosition(x: bottomPointX, y: bottomPointY));

      // left edge
      int leftPointX = position.x - distance;
      int leftPointY = position.y + i;
      points.add(TilePosition(x: leftPointX, y: leftPointY));

      // right edge
      int rightPointX = position.x + distance;
      int rightPointY = position.y + i;
      points.add(TilePosition(x: rightPointX, y: rightPointY));

      for (var point in points) {
        if (point.x < 0 || point.x >= mapWidth) continue;
        if (point.y < 0 || point.y >= mapHeight) continue;
        tiles.add(
          TileData(
            layerId: layerId,
            position: point,
            data: mapComponent.tileMap.getTileData(layerId: layerId, x: point.x.toInt(), y: point.y.toInt()) ??
                const Gid(0, Flips.defaults()),
          ),
        );
      }
    }

    return tiles.toList();
  }

  static bool isPointInPolygon(List<Vector2> points, Vector2 point) {
    // Check if point P is on the right side poygon edges
    for (int i = 0; i < points.length; i++) {
      final a = points[i];
      final b = points[(i + 1) % points.length];
      if (_crossProduct(a, b, point) < 0) {
        return false; // P is outside the polygon
      }
    }

    return true; // P is inside the polygon
  }

  static double _crossProduct(Vector2 a, Vector2 b, Vector2 p) {
    // Calculate the vector cross product of AP and AB
    var ab = Vector2(b.x - a.x, b.y - a.y);
    var ap = Vector2(p.x - a.x, p.y - a.y);
    return ab.x * ap.y - ab.y * ap.x;
  }
}

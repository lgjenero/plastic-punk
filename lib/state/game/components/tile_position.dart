import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tile_position.freezed.dart';
part 'tile_position.g.dart';

@freezed
class TilePosition with _$TilePosition {
  const factory TilePosition({
    required int x,
    required int y,
  }) = _TilePosition;

  factory TilePosition.fromJson(Map<String, dynamic> json) => _$TilePositionFromJson(json);

  factory TilePosition.fromVector2(Vector2 vector2) {
    return TilePosition(x: vector2.x.toInt(), y: vector2.y.toInt());
  }
}

extension TilePositionExtension on TilePosition {
  TilePosition get left => TilePosition(x: x - 1, y: y);
  TilePosition get right => TilePosition(x: x + 1, y: y);
  TilePosition get up => TilePosition(x: x, y: y - 1);
  TilePosition get down => TilePosition(x: x, y: y + 1);

  Vector2 distanceTo(TilePosition other) {
    return Vector2((x - other.x).toDouble(), (y - other.y).toDouble());
  }

  Vector2 toVector2() {
    return Vector2(x.toDouble(), y.toDouble());
  }
}

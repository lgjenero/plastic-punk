class TilePosition {
  final int x;
  final int y;

  TilePosition(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TilePosition && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'TilePosition{x: $x, y: $y}';
  }

  TilePosition get left => TilePosition(x - 1, y);
  TilePosition get right => TilePosition(x + 1, y);
  TilePosition get up => TilePosition(x, y - 1);
  TilePosition get down => TilePosition(x, y + 1);
}

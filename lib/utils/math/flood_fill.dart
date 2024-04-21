//Original algorithm by J. Dunlap queuelinearfloodfill.aspx
//Java port by Owen Kaluza
//Android port by Darrin Smith (Standard Android)
//Flutter port by Garlen Javier

import 'dart:collection';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';

class FloodFiller {
  final TiledComponent mapComponent;
  final int layerId;
  final Set<int> valuesToFill;
  final Set<int> filledValues;
  final Set<TilePosition> inProcess;

  late List<List<bool>> _visited;
  late Queue<TilePosition> _steps;

  FloodFiller(this.mapComponent, this.layerId, this.valuesToFill, this.filledValues, this.inProcess) {
    _visited = List.generate(_mapWidth, (_) => List.generate(_mapHeight, (_) => false));
    _steps = Queue<TilePosition>();
  }

  int get _mapWidth => mapComponent.tileMap.map.width;
  int get _mapHeight => mapComponent.tileMap.map.height;

  /// Finds the next point to fill starting from the specified point.
  TilePosition? getNextPoint(TilePosition start) {
    _addStep(start);

    final result = _process();
    return result;
  }

  TilePosition? _process() {
    while (_steps.isNotEmpty) {
      final step = _steps.removeFirst();

      if (_canBeFilled(step)) return step;

      if (_isFilled(step)) _addNighbours(step);
    }
    return null;
  }

  bool _isFilled(TilePosition position) {
    if (position.x < 0 || position.x >= _mapWidth) return false;
    if (position.y < 0 || position.y >= _mapHeight) return false;
    if (inProcess.contains(position)) return true;
    final tile = mapComponent.tileMap.getTileData(layerId: layerId, x: position.x, y: position.y)?.tile ?? 0;
    return filledValues.contains(tile);
  }

  bool _canBeFilled(TilePosition position) {
    if (position.x < 0 || position.x >= _mapWidth) return false;
    if (position.y < 0 || position.y >= _mapHeight) return false;
    if (inProcess.contains(position)) return false;
    final tile = mapComponent.tileMap.getTileData(layerId: layerId, x: position.x, y: position.y)?.tile ?? 0;
    return valuesToFill.contains(tile);
  }

  void _addNighbours(TilePosition position) {
    _addStep(position.left);
    _addStep(position.right);
    _addStep(position.up);
    _addStep(position.down);
  }

  void _addStep(TilePosition position) {
    if (position.x < 0 || position.x >= _mapWidth) return;
    if (position.y < 0 || position.y >= _mapHeight) return;
    if (_visited[position.x][position.y]) return;
    if (_isFilled(position) || _canBeFilled(position)) {
      _steps.add(position);
      _visited[position.x][position.y] = true;
    }
  }

  Set<TilePosition> getFilledArea(TilePosition start) {
    final area = <TilePosition>{};

    _addStep(start);
    while (_steps.isNotEmpty) {
      final step = _steps.removeFirst();

      if (_isFilled(step)) {
        area.add(step);
        _addNighbours(step);
      }
    }

    return area;
  }
}

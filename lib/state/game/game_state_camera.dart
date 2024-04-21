// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateCamera on GameState {
  void moveCameraTo(TilePosition tilePosition) {
    final position = AppMath.getTilePosition(
      tilePosition,
      _mapComponent.tileMap.destTileSize,
      _mapComponent.tileMap.map.width,
      _mapComponent.tileMap.map.height,
    ).center;

    _game.camera.moveTo(position.toVector2());
    _checkScaleBorders();
    _checkDragBorders();
  }

  static const double _minZoom = 0.3;
  static const double _maxZoom = 2.0;

  static const double _zoomPerScrollUnit = 0.01;

  void onScroll(PointerScrollInfo info) {
    camera.viewfinder.zoom += info.scrollDelta.global.y.sign * _zoomPerScrollUnit;
    _checkScaleBorders();
    _checkDragBorders();
  }

  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    if (currentScale.isIdentity()) {
      _processDrag(info);
    } else {
      _processScale(info, currentScale);
    }
  }

  void _processDrag(ScaleUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 / _startZoom;
    final currentPosition = camera.viewfinder.position;
    final worldRect = camera.visibleWorldRect;
    final mapSize = Offset(mapComponent.width, mapComponent.height);

    Vector2 newCameraPosition = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );

    double xTranslate = 0.0;
    double yTranslate = 0.0;

    (xTranslate, yTranslate) = _translateDragBorders(worldRect, mapSize);

    if (xTranslate != 0.0 || yTranslate != 0.0) {
      newCameraPosition = newCameraPosition.translated(xTranslate, yTranslate);
    }

    camera.viewfinder.position = newCameraPosition;
    _checkScaleBorders();
    _checkDragBorders();
  }

  void _processScale(ScaleUpdateInfo info, Vector2 currentScale) {
    final newZoom = _startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
    _checkScaleBorders();
    _checkDragBorders();
  }

  void onScaleEnd(ScaleEndInfo info) {
    _checkScaleBorders();
    _checkDragBorders();
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;

    final currentPosition = camera.viewfinder.position;

    final mapSize = Offset(mapComponent.width, mapComponent.height);

    double xTranslate = 0.0;
    double yTranslate = 0.0;

    (xTranslate, yTranslate) = _translateDragBorders(worldRect, mapSize);

    if (xTranslate == 0.0 && yTranslate == 0.0) return;

    camera.viewfinder.position = currentPosition.translated(xTranslate, yTranslate);
  }

  (double, double) _translateDragBorders(final Rect worldRect, final Offset mapSize) {
    double xTranslate = 0.0;
    double yTranslate = 0.0;

    if (worldRect.topLeft.dx < -AppSizes.tile.width * 2.0) {
      xTranslate = -worldRect.topLeft.dx - AppSizes.tile.width * 2.0;
    } else if (worldRect.bottomRight.dx > mapSize.dx + AppSizes.tile.width * 2.0) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx + AppSizes.tile.width * 2.0;
    }

    if (worldRect.topLeft.dy < -AppSizes.tile.height * 2.0) {
      yTranslate = -worldRect.topLeft.dy - AppSizes.tile.height * 2.0;
    } else if (worldRect.bottomRight.dy > mapSize.dy + AppSizes.tile.height * 2.0) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy + AppSizes.tile.height * 2.0;
    }

    return (xTranslate, yTranslate);
  }
}

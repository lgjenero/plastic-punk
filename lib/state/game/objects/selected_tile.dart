import 'dart:async';
import 'dart:ui';

import 'package:plastic_punk/state/game/components/icon_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';

enum SelectedTileType {
  toBeCleaned('app_assets/icons/cleaning_icon.png');

  final String iconPath;
  const SelectedTileType(this.iconPath);
}

class SelectedTile extends GameObject {
  final TilePosition tilePosition;
  SelectedTile({required this.type, required this.tilePosition, required super.isPaused})
      : super(x: tilePosition.x.toDouble(), y: tilePosition.y.toDouble());

  final SelectedTileType type;

  bool _highlightAdded = false;

  SelectedTileObject? _selectedTileObject;

  @override
  void update(double dt, GameState state) {
    if (isPaused) return;

    if (!_highlightAdded) {
      _highlightAdded = true;
      scheduleMicrotask(() {
        // add the highligh to the map
        _selectedTileObject = SelectedTileObject(type, tilePosition, state);
        state.mapComponent.add(_selectedTileObject!);
      });
    }
  }

  void _removeComponent(GameState state) {
    if (_selectedTileObject != null) {
      state.mapComponent.remove(_selectedTileObject!);
      _selectedTileObject = null;
    }
  }

  @override
  void remove(GameState state) {
    scheduleMicrotask(() {
      state.remove(this);

      // remove the higlight from the map
      _removeComponent(state);
    });
  }
}

class SelectedTileObject extends IconComponent {
  SelectedTileObject(SelectedTileType type, TilePosition tilePosition, GameState state)
      : super(tilePosition, state, type.iconPath);

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0x40000000)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(tileRect.size.width / 2, 0)
      ..lineTo(tileRect.size.width, tileRect.size.height / 2)
      ..lineTo(tileRect.size.width / 2, tileRect.size.height)
      ..lineTo(0, tileRect.size.height / 2)
      ..close();

    canvas.drawPath(path, paint);

    super.render(canvas);
  }
}

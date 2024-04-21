import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/saves_dialog.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class SavesOverlay extends ConsumerWidget {
  static const String overlayId = 'saves';

  final FlameGame game;

  const SavesOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = SizeLayoutBuilder.of(context);
      return SizeLayoutBuilder(
        small: (context, child) => _buildContent(context, ref, size),
        medium: (context, child) => _buildContent(context, ref, size),
        large: (context, child) => _buildContent(context, ref, size),
      );
    });
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, SizeLayout size) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SavesDialog(size: size, onBack: _back, onSelect: (slot, _) => _selectSave(slot, ref)),
      ),
    );
  }

  void _back() {
    game.overlays.remove(SavesOverlay.overlayId);
  }

  void _selectSave(String slot, WidgetRef ref) {
    game.overlays.remove(SavesOverlay.overlayId);
    ref.read(gameStateProvider.notifier).saveGame(slot, null);
  }
}

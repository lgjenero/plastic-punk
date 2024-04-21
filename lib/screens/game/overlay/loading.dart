import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/loading_widget.dart';

class LoadingOverlay extends StatelessWidget {
  static const String overlayId = 'loading';

  final FlameGame game;

  const LoadingOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: const Center(child: LoadingWidget()),
    );
  }
}

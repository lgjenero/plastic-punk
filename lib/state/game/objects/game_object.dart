import 'package:plastic_punk/state/game/game_state.dart';

abstract class GameObject {
  final double x;
  final double y;
  final bool isPaused;

  const GameObject({required this.x, required this.y, required this.isPaused});

  void update(double dt, GameState state);

  void remove(GameState state);
}

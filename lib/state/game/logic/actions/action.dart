import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';

abstract class Action {
  final GameObject gameObject;
  final double duration;
  final bool isRepeatable;

  Action({
    required this.gameObject,
    required this.duration,
    required this.isRepeatable,
  });

  bool get isCompleted;

  void update(double dt, GameState state) {}
}

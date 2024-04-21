// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateSettings on GameState {
  void updateGameSpeed(double speed) {
    AppTimes.gameSpeed = speed;
    state = state.copyWith(gameSpeed: speed);
  }

  double get gameSpeed => state.gameSpeed;

  void updateUseAutomaticCleanup(bool useAutomaticCleanup) {
    state = state.copyWith(useAutomaticCleanup: useAutomaticCleanup);
  }

  bool get useAutomaticCleanup => state.useAutomaticCleanup;

  void updateGameSpeedMultiplier(double speedMultiplier) {
    AppTimes.gameSpeedMultiplier = speedMultiplier;
  }

  double get gameSpeedMultiplier => AppTimes.gameSpeedMultiplier;
}

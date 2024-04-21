// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateMessage on GameState {
  void showMessage(Message message) {
    state = state.copyWith(message: message);
    _game.overlays.add(MessageOverlay.overlayId);
  }

  void hideMessage() {
    final currentMessage = state.message;
    state = state.copyWith(message: null);
    _game.overlays.remove(MessageOverlay.overlayId);

    // enable tooltips after the intro message
    if (currentMessage == level.introMessage) {
      ref.read(onboardingTooltipsProvider.notifier).setTooltipsEnabled(true);
    }
  }
}

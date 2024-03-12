// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateMessage on GameState {
  void showMessage(Message message) {
    state = state.copyWith(message: message);
    _game.overlays.add(MessageOverlay.overlayId);
  }

  void hideMessage() {
    state = state.copyWith(resetMessage: true);
    _game.overlays.remove(MessageOverlay.overlayId);
  }
}

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateTransport on GameState {
  void checkBuildTransport() {
    state = state.copyWith(transportsState: state.transportsState + 1);
  }

  void checkDestroyTransport() {
    state = state.copyWith(transportsState: state.transportsState + 1);
  }
}

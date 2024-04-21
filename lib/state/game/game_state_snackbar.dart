// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateSnackBar on GameState {
  void showSnackbar(GameSnackbar snackbar) {
    ref.read(gameSnackbarStateProvider.notifier).removeAll();
    ref.read(gameSnackbarStateProvider.notifier).scheduleSnackbar(snackbar);
  }

  void removeAllSnackbars() {
    ref.read(gameSnackbarStateProvider.notifier).removeAll();
  }
}

import 'package:plastic_punk/state/game/snackbars/snackbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar_state.g.dart';

class GameSnackbarData {
  final GameSnackbar? snackbar;
  final bool removeAll;

  const GameSnackbarData({this.snackbar, this.removeAll = false});

  GameSnackbarData copyWith({
    GameSnackbar? snackbar,
    bool resetSnackbar = false,
    bool? removeAll,
  }) {
    return GameSnackbarData(
      snackbar: resetSnackbar ? null : snackbar ?? this.snackbar,
      removeAll: removeAll ?? this.removeAll,
    );
  }
}

@riverpod
class GameSnackbarState extends _$GameSnackbarState {
  @override
  GameSnackbarData build() {
    return const GameSnackbarData();
  }

  void scheduleSnackbar(GameSnackbar snackbar) {
    state = state.copyWith(snackbar: snackbar);
  }

  void resetSnackbar() {
    state = state.copyWith(resetSnackbar: true);
  }

  void removeAll() {
    state = state.copyWith(removeAll: true);
  }

  void resetRemoveAll() {
    state = state.copyWith(removeAll: false);
  }
}

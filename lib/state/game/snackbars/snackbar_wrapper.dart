import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/snackbars/snackbar_state.dart';

class GameSnackbarWrapper extends ConsumerWidget {
  final Widget child;

  const GameSnackbarWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(gameSnackbarStateProvider.select((e) => e.snackbar), (prev, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(next.toSnackBar(context));
        ref.read(gameSnackbarStateProvider.notifier).resetSnackbar();
      }
    });

    ref.listen(gameSnackbarStateProvider.select((e) => e.removeAll), (prev, next) {
      if (next) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ref.read(gameSnackbarStateProvider.notifier).resetRemoveAll();
      }
    });

    return child;
  }
}

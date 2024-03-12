import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class SettingsOverlay extends ConsumerWidget {
  static const String overlayId = 'settings';

  final FlameGame game;

  const SettingsOverlay({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = SizeLayoutBuilder.of(context);
      return SizeLayoutBuilder(
        small: (context, child) => _buildContent(context, size),
        medium: (context, child) => _buildContent(context, size),
        large: (context, child) => _buildContent(context, size),
      );
    });
  }

  Widget _buildContent(BuildContext context, SizeLayout size) {
    return Material(
      type: MaterialType.transparency,
      child: SettingsContent(size: size, game: game),
    );
  }
}

class SettingsContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const SettingsContent({required this.size, required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: () => _next(message, ref),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.hudBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              constraints: BoxConstraints.tight(AppSizes.message(size)),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Settings', style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                  const SizedBox(height: 8),
                  _SpeedControlWidget(size: size),
                  const SizedBox(height: 8),
                  _AutomaticCleanupWidget(size: size),
                  const SizedBox(height: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonForeground,
                      foregroundColor: AppColors.buttonBackground,
                      textStyle: AppFonts.button(size),
                    ),
                    onPressed: () => _quit(context),
                    child: const Text('Quit'),
                  ),
                  const SizedBox(height: 8),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonForeground,
                      foregroundColor: AppColors.buttonBackground,
                      textStyle: AppFonts.button(size),
                    ),
                    onPressed: () => _back(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _back() {
    game.overlays.remove(SettingsOverlay.overlayId);
  }

  void _quit(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _SpeedControlWidget extends ConsumerWidget {
  final SizeLayout size;

  const _SpeedControlWidget({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speed = ref.watch(gameStateProvider.select((e) => e.gameSpeed));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Speed: ',
          style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
        ),
        Text(speed.toString(), style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground)),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () =>
              ref.read(gameStateProvider.notifier).updateGameSpeed(math.max(1 / 4, AppTimes.gameSpeed / 2)),
          icon: const Icon(Icons.fast_rewind, color: AppColors.hudForeground),
        ),
        const SizedBox(width: 8),
        Text(
          '${speed >= 1 ? speed.toStringAsFixed(0) : speed.toStringAsFixed(2)} x',
          style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => ref.read(gameStateProvider.notifier).updateGameSpeed(math.min(16, AppTimes.gameSpeed * 2)),
          icon: const Icon(Icons.fast_forward, color: AppColors.hudForeground),
        ),
      ],
    );
  }
}

class _AutomaticCleanupWidget extends ConsumerWidget {
  final SizeLayout size;

  const _AutomaticCleanupWidget({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useAutomaticCleanup = ref.watch(gameStateProvider.select((e) => e.useAutomaticCleanup));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Automatic Cleanup: ',
          style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
        ),
        Checkbox(
          value: useAutomaticCleanup,
          onChanged: (value) => ref.read(gameStateProvider.notifier).updateUseAutomaticCleanup(!useAutomaticCleanup),
          checkColor: AppColors.hudBackground,
          activeColor: AppColors.hudForeground,
        ),
      ],
    );
  }
}

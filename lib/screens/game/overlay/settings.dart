import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/saves_dialog.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class SettingsOverlay extends ConsumerWidget {
  static const String overlayId = 'settings';

  final FlameGame game;

  const SettingsOverlay({required this.game, super.key});

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

  const SettingsContent({required this.size, required this.game, super.key});

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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Settings', style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                        const SizedBox(height: 8),
                        _SpeedControlWidget(size: size),
                        const SizedBox(height: 8),
                        _AutomaticCleanupWidget(size: size),
                        const SizedBox(height: 8),
                        _MusicVolumeWidget(size: size),
                        const SizedBox(height: 8),
                        _SfxVolumeWidget(size: size),
                        const SizedBox(height: 8),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.buttonForeground,
                            foregroundColor: AppColors.buttonBackground,
                            textStyle: AppFonts.button(size),
                          ),
                          onPressed: () => _save(context, ref),
                          child: const Text('Save Game'),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.buttonForeground,
                            foregroundColor: AppColors.buttonBackground,
                            textStyle: AppFonts.button(size),
                          ),
                          onPressed: () => _quit(context),
                          child: const Text('Quit'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => _back(),
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColors.hudForeground,
                        size: 44,
                      ),
                    ),
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

  void _save(BuildContext context, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (context) {
          Widget buildDialog(SizeLayout size) => SavesDialog(
              size: size,
              showEmpty: true,
              onBack: () => Navigator.pop(context),
              onSelect: (slot, _) {
                Navigator.pop(context);
                _saveSlot(slot, ref);
              });

          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: SizeLayoutBuilder(
                small: (_, __) => buildDialog(SizeLayout.small),
                medium: (_, __) => buildDialog(SizeLayout.medium),
                large: (_, __) => buildDialog(SizeLayout.large),
              ),
            ),
          );
        });
  }

  void _saveSlot(String slot, WidgetRef ref) {
    ref.read(gameStateProvider.notifier).saveGame(slot, null);
  }
}

class _SpeedControlWidget extends ConsumerWidget {
  final SizeLayout size;

  const _SpeedControlWidget({required this.size, super.key});

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

  const _AutomaticCleanupWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useAutomaticCleanup = ref.watch(gameStateProvider.select((e) => e.useAutomaticCleanup));
    return InkWell(
      onTap: () => ref.read(gameStateProvider.notifier).updateUseAutomaticCleanup(!useAutomaticCleanup),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Automatic Cleanup: ',
            style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
          ),
          const SizedBox(width: 8),
          Icon(
            useAutomaticCleanup ? Icons.check_box : Icons.check_box_outline_blank,
            color: AppColors.hudForeground,
            size: AppFonts.messageTitle(size).fontSize,
          ),
          // Checkbox(
          //   value: useAutomaticCleanup,
          //   onChanged: (value) => ref.read(gameStateProvider.notifier).updateUseAutomaticCleanup(!useAutomaticCleanup),
          //   checkColor: AppColors.hudBackground,
          //   activeColor: AppColors.hudForeground,
          // ),
        ],
      ),
    );
  }
}

class _MusicVolumeWidget extends StatefulWidget {
  final SizeLayout size;

  const _MusicVolumeWidget({required this.size});

  @override
  State<_MusicVolumeWidget> createState() => _MusicVolumeWidgetState();
}

class _MusicVolumeWidgetState extends State<_MusicVolumeWidget> {
  @override
  Widget build(BuildContext context) {
    final musicVolume = Sfx.musicVolume;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Music Volume: ',
          style: AppFonts.messageTitle(widget.size).copyWith(color: AppColors.hudForeground),
        ),
        Expanded(
          child: Slider(
            value: musicVolume,
            onChanged: (value) {
              setState(() {
                Sfx.updateMusicVolume(value);
              });
            },
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: AppColors.hudForeground,
            inactiveColor: AppColors.hudForeground.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

class _SfxVolumeWidget extends StatefulWidget {
  final SizeLayout size;

  const _SfxVolumeWidget({required this.size});

  @override
  State<_SfxVolumeWidget> createState() => _SfxVolumeWidgetState();
}

class _SfxVolumeWidgetState extends State<_SfxVolumeWidget> {
  @override
  Widget build(BuildContext context) {
    final sfxVolume = Sfx.effectsVolume;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'SFX Volume: ',
          style: AppFonts.messageTitle(widget.size).copyWith(color: AppColors.hudForeground),
        ),
        Expanded(
          child: Slider(
            value: sfxVolume,
            onChanged: (value) {
              setState(() {
                Sfx.updateEffectsVolume(value);
              });
            },
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: AppColors.hudForeground,
            inactiveColor: AppColors.hudForeground.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

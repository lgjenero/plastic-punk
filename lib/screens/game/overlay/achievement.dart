import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class AchievementOverlay extends ConsumerWidget {
  static const String overlayId = 'achievement';

  final FlameGame game;

  const AchievementOverlay({required this.game, super.key});

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
      child: AchievementContent(size: size, game: game),
    );
  }
}

class AchievementContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const AchievementContent({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievement = ref.read(gameStateProvider).achievement;
    if (achievement == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(gameStateProvider.notifier).hideAchievement();
      });
      return const SizedBox();
    }

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
                  Text("Achievement", style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            achievement.name,
                            style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
                          ),
                          const SizedBox(height: 12),
                          Image.asset(
                            achievement.imagePath,
                            width: AppSizes.messageBadge(size).width,
                            height: AppSizes.messageBadge(size).height,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            achievement.description,
                            style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonForeground,
                      foregroundColor: AppColors.buttonBackground,
                      textStyle: AppFonts.button(size),
                    ),
                    onPressed: () => _next(ref),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _next(WidgetRef ref) {
    ref.read(gameStateProvider.notifier).hideAchievement();
  }
}

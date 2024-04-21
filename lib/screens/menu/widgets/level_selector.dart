import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/state/game/levels/levels.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/outlined_text.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class LevelSelector extends StatelessWidget {
  const LevelSelector({this.onBack, this.onLevelSeleced, super.key});

  final VoidCallback? onBack;
  final void Function(Level level)? onLevelSeleced;

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, child) => _buildLayout(context, child, SizeLayout.small),
      medium: (context, child) => _buildLayout(context, child, SizeLayout.medium),
      large: (context, child) => _buildLayout(context, child, SizeLayout.large),
    );
  }

  Widget _buildLayout(BuildContext context, Widget? child, SizeLayout size) {
    Widget back = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.hudBackground,
        shape: const CircleBorder(),
      ),
      onPressed: onBack,
      child: const Icon(Icons.arrow_back, color: AppColors.hudForeground),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(visible: onBack != null, child: back),
            OutlinedText(
              'Select Level',
              style: AppFonts.level(size),
              textColor: AppColors.titleColor,
              strokeColor: AppColors.titleOutline,
              strokeWidth: 2,
              textAlign: TextAlign.center,
            ),
            IgnorePointer(ignoring: true, child: Opacity(opacity: 0, child: back)),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              // width: size == SizeLayout.small
              //     ? 300
              //     : size == SizeLayout.medium
              //         ? 420
              //         : 560,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.titleOutline.withOpacity(0.4),
              ),
              padding: const EdgeInsets.all(12),
              child: Consumer(builder: (context, ref, _) {
                final finishedLevel = ref.watch(userServiceProvider.select((e) => e.userData.finishedLevel));
                return ListView.separated(
                  itemCount: Levels.levels.length,
                  itemBuilder: (_, index) {
                    final level = Levels.levels[index];
                    return _LevelWidget(
                      level: level,
                      size: size,
                      enabled: finishedLevel >= level.level - 1 || Levels.levels.first == level,
                      onTap: () => onLevelSeleced?.call(level),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LevelWidget extends StatelessWidget {
  const _LevelWidget({required this.level, required this.enabled, required this.size, this.onTap});

  final Level level;
  final bool enabled;
  final SizeLayout size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget text = OutlinedText(
      level.name,
      style: AppFonts.level(size),
      textColor: enabled ? AppColors.titleOutline : AppColors.titleColor.withOpacity(0.5),
      strokeColor: enabled ? AppColors.titleColor : AppColors.titleOutline.withOpacity(0.5),
      strokeWidth: 2,
      textAlign: TextAlign.center,
    );

    if (!enabled) text = Grayscale(child: text);

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Center(child: text),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/outlined_text.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class MenuContent extends StatelessWidget {
  const MenuContent({this.onStartGameTap, this.onContinueGameTap, super.key});

  final VoidCallback? onStartGameTap;
  final VoidCallback? onContinueGameTap;

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, child) => _buildLayout(context, child, SizeLayout.small),
      medium: (context, child) => _buildLayout(context, child, SizeLayout.medium),
      large: (context, child) => _buildLayout(context, child, SizeLayout.large),
    );
  }

  Widget _buildLayout(BuildContext context, Widget? child, SizeLayout size) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: OutlinedText(
              'PlasticPunk',
              style: AppFonts.title(size),
              textColor: AppColors.titleColor,
              strokeColor: AppColors.titleOutline,
              strokeWidth: 4,
            ),
          ),
          SizedBox(
              height: size == SizeLayout.small
                  ? 20
                  : size == SizeLayout.medium
                      ? 40
                      : 60),
          _buildButtons(SizeLayout.small),
        ],
      ),
    );
  }

  Widget _buildButtons(SizeLayout size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.buttonBackground,
            foregroundColor: AppColors.buttonForeground,
            fixedSize: AppSizes.button(size),
            textStyle: AppFonts.button(size),
          ),
          onPressed: onStartGameTap,
          child: const Text('Start Game'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.buttonBackground,
            foregroundColor: AppColors.buttonForeground,
            fixedSize: AppSizes.button(size),
            textStyle: AppFonts.button(size),
          ),
          onPressed: onContinueGameTap,
          child: const Text('Continue Game'),
        ),
      ],
    );
  }
}

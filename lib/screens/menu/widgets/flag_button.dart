import 'package:flutter/material.dart';
import 'package:plastic_punk/screens/menu/widgets/flag_widget.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class FlagButton extends StatelessWidget {
  final String flagCode;
  final SizeLayout size;
  final VoidCallback? onPressed;

  const FlagButton({required this.flagCode, required this.size, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.messageFlag(size).width + 32,
      height: AppSizes.messageFlag(size).height + 20,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.hudForeground,
          // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          // fixedSize: Size(AppSizes.messageFlag(size).width + 24, AppSizes.messageFlag(size).height + 12),
        ),
        child: FlagWidget(countryCode: flagCode, size: size),
      ),
    );
  }
}

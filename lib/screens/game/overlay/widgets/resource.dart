import 'package:flutter/widgets.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class ResourceWidget extends StatelessWidget {
  final SizeLayout size;
  final ResourceType type;
  final int amount;
  final int? availableAmount;
  final double scale;

  const ResourceWidget({
    required this.size,
    required this.type,
    required this.amount,
    this.availableAmount,
    this.scale = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final amountText = (availableAmount != null) ? '$availableAmount / $amount' : '$amount';
    final font = AppFonts.hud(size);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          type.icon,
          fit: BoxFit.contain,
          width: AppSizes.hudSymbol(size) * scale,
          height: AppSizes.hudSymbol(size) * scale,
        ),
        SizedBox(width: 6 * scale),
        Text(amountText, style: font.copyWith(color: AppColors.hudForeground, fontSize: font.fontSize! * scale)),
      ],
    );
  }

  static double width(SizeLayout size, double scale) {
    const textAmount = '000 / 000';
    final font = AppFonts.hud(size);
    final textWidth = font.copyWith(fontSize: font.fontSize! * scale).getTextSize(textAmount).width;
    return AppSizes.hudSymbol(size) * scale + 6 * scale + textWidth;
  }
}

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

  const ResourceWidget({required this.size, required this.type, required this.amount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          type.icon,
          fit: BoxFit.contain,
          width: AppSizes.hudSymbol(size),
          height: AppSizes.hudSymbol(size),
        ),
        const SizedBox(width: 6),
        Text('$amount', style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground)),
        const SizedBox(width: 32),
      ],
    );
  }
}

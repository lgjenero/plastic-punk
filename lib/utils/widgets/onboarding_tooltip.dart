import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/services/onboarding/onboarding_tooltips.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';
import 'package:super_tooltip/super_tooltip.dart';

class OnboardingTooltipWidget extends ConsumerWidget {
  final SizeLayout size;
  final String message;
  final OnboardingTooltip type;
  final Widget child;

  const OnboardingTooltipWidget(
      {required this.size, required this.message, required this.type, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(onboardingTooltipsProvider.select((e) => e.enableTooltips));
    final shown = ref.watch(onboardingTooltipsProvider.select((e) => e.shownTooltips.contains(type)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!shown && enabled) {
        ref.read(onboardingTooltipsProvider).tooltipControllers[type]?.showTooltip();
      } else {
        if (ref.read(onboardingTooltipsProvider).tooltipControllers[type]?.isVisible == true) {
          ref.read(onboardingTooltipsProvider).tooltipControllers[type]?.hideTooltip();
        }
      }
    });

    return SuperTooltip(
      backgroundColor: AppColors.onboardingTooltipBackground,
      content: Text(
        message,
        style: AppFonts.onboardingTooltip(size).copyWith(color: AppColors.onboardingTooltipForeground),
      ),
      arrowTipDistance: 30,
      popupDirection: TooltipDirection.up,
      controller: ref.read(onboardingTooltipsProvider).tooltipControllers[type],
      onHide: () {
        ref.read(onboardingTooltipsProvider.notifier).markTooltipAsShown(type);
      },
      child: child,
    );
  }
}

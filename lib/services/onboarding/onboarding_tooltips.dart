import 'dart:async';

import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_tooltip/super_tooltip.dart';

part 'onboarding_tooltips.g.dart';

class OnboardingTooltipsData {
  final Set<OnboardingTooltip> shownTooltips;
  final Map<OnboardingTooltip, SuperTooltipController> tooltipControllers;
  final bool enableTooltips;

  OnboardingTooltipsData({
    required this.shownTooltips,
    required this.tooltipControllers,
    required this.enableTooltips,
  });

  OnboardingTooltipsData copyWith({
    Set<OnboardingTooltip>? shownTooltips,
    Map<OnboardingTooltip, SuperTooltipController>? tooltipControllers,
    bool? enableTooltips,
  }) {
    return OnboardingTooltipsData(
      shownTooltips: shownTooltips ?? this.shownTooltips,
      tooltipControllers: tooltipControllers ?? this.tooltipControllers,
      enableTooltips: enableTooltips ?? this.enableTooltips,
    );
  }

  @override
  String toString() {
    return 'OnboardingTooltipsData(shownTooltips: $shownTooltips, tooltipControllers: $tooltipControllers, enableTooltips: $enableTooltips)';
  }
}

@Riverpod(keepAlive: true)
class OnboardingTooltips extends _$OnboardingTooltips {
  StreamSubscription<UserData?>? _userDataSubscription;

  @override
  OnboardingTooltipsData build() {
    ref.onDispose(() {
      _userDataSubscription?.cancel();
    });

    final tooltips = _initialise();
    return OnboardingTooltipsData(
      shownTooltips: tooltips,
      tooltipControllers: {for (var e in OnboardingTooltip.values) e: SuperTooltipController()},
      enableTooltips: false,
    );
  }

  Set<OnboardingTooltip> _initialise() {
    final tooltips = ref.read(userServiceProvider).userData.onboardingTooltipsShown;

    ref.listen(userServiceProvider.select((e) => e.userData.onboardingTooltipsShown), (_, tooltips) {
      state = state.copyWith(shownTooltips: tooltips);
    });

    return tooltips;
  }

  void markTooltipAsShown(OnboardingTooltip tooltip) {
    final tooltips = {...state.shownTooltips};
    tooltips.add(tooltip);
    state = state.copyWith(shownTooltips: tooltips);
    ref.read(userServiceProvider.notifier).setOnboardingTooltipShown(tooltip);
  }

  void setTooltipsEnabled(bool enabled) {
    state = state.copyWith(enableTooltips: enabled);
  }
}

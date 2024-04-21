import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/build.dart';
import 'package:plastic_punk/screens/game/overlay/research.dart';
import 'package:plastic_punk/screens/game/overlay/settings.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/resource.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/education_center_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/platform.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/onboarding_tooltip.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';
import 'package:plastic_punk/utils/widgets/tooltip.dart';

class Hud extends StatelessWidget {
  static const String overlayId = 'hud';

  final FlameGame game;

  const Hud({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          Positioned(left: 0, right: 0, top: 0, child: HudTop(size: size, game: game, showActions: false)),
          Positioned(bottom: 0, right: 0, child: HudActions(size: size, game: game, direction: Axis.horizontal)),
          // Positioned(left: 0, right: 0, bottom: 0, child: HudBottom(size: size)),
        ],
      ),
    );
  }
}

class HudTop extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;
  final bool showActions;

  const HudTop({required this.size, required this.game, required this.showActions, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            HudResources(size: size),
            if (showActions) Expanded(child: HudActions(size: size, game: game, direction: Axis.horizontal)),
          ],
        ),
      ),
    );
  }
}

class HudActions extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;
  final Axis direction;

  const HudActions({required this.size, required this.game, required this.direction, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canResearch =
        ref.watch(gameStateProvider.select((e) => e.objects.any((e) => e is ResearchCentreTile && e.constructed)));
    final canDoDiplomacy = ref.watch(gameStateProvider
        .select((e) => e.objects.any((e) => e is EducationCentreTile && e.constructed && e.canExecuteDiplomacy)));

    final constructionImage = Image.asset(
      'assets/images/app_assets/icons/construction_icon.png',
      fit: BoxFit.contain,
      width: AppSizes.hudSymbol(size),
      height: AppSizes.hudSymbol(size),
    );

    Widget researchImage = Image.asset(
      'assets/images/app_assets/icons/research_icon.png',
      fit: BoxFit.contain,
      width: AppSizes.hudSymbol(size),
      height: AppSizes.hudSymbol(size),
    );
    if (!canResearch) researchImage = Grayscale(child: researchImage);

    Widget diplomacyImage = Image.asset(
      'assets/images/app_assets/icons/diplomacy_icon.png',
      fit: BoxFit.contain,
      width: AppSizes.hudSymbol(size),
      height: AppSizes.hudSymbol(size),
    );
    if (!canDoDiplomacy) diplomacyImage = Grayscale(child: diplomacyImage);

    final settingsImage = Image.asset(
      'assets/images/app_assets/icons/settings_icon.png',
      fit: BoxFit.contain,
      width: AppSizes.hudSymbol(size),
      height: AppSizes.hudSymbol(size),
    );

    void onConstruction() {
      if (game.overlays.activeOverlays.length > 1) return;
      game.overlays.add(BuildOverlay.overlayId);
    }

    void onResearch() {
      if (game.overlays.activeOverlays.length > 1) return;
      if (!canResearch) {
        ref.read(gameStateProvider.notifier).showMessage(Messages.researchUnavailable);
        return;
      }
      game.overlays.add(ResearchOverlay.overlayId);
    }

    void onDiplomacy() {
      if (game.overlays.activeOverlays.length > 1) return;
      if (!canDoDiplomacy) {
        ref.read(gameStateProvider.notifier).showMessage(Messages.diplomacyUnavailable);
        return;
      }
      ref.read(gameStateProvider.notifier).initiateDiplomacy();
    }

    void onSettings() {
      if (game.overlays.activeOverlays.length > 1) return;
      game.overlays.add(SettingsOverlay.overlayId);
    }

    Widget researchButton = IconButton(
      onPressed: onResearch,
      padding: const EdgeInsets.all(8),
      icon: researchImage,
    );
    if (canResearch) {
      researchButton = OnboardingTooltipWidget(
        size: size,
        message: 'Here you can select new research to start',
        type: OnboardingTooltip.research,
        child: researchButton,
      );
    }

    Widget diplomacyButton = IconButton(
      onPressed: onDiplomacy,
      padding: const EdgeInsets.all(8),
      icon: diplomacyImage,
    );
    if (canDoDiplomacy) {
      diplomacyButton = OnboardingTooltipWidget(
        size: size,
        message: 'Here you can start diplomacy with other communities',
        type: OnboardingTooltip.diplomacy,
        child: diplomacyButton,
      );
    }

    final items = [
      AppTooltip(
        size: size,
        message: 'Here you can select new buildings to construct',
        child: OnboardingTooltipWidget(
          size: size,
          message: 'Here you can select new buildings to construct',
          type: OnboardingTooltip.construction,
          child: IconButton(
            onPressed: onConstruction,
            padding: const EdgeInsets.all(8),
            icon: constructionImage,
          ),
        ),
      ),
      AppTooltip(
        size: size,
        message: 'Here you can select new research to start',
        child: researchButton,
      ),
      AppTooltip(
        size: size,
        message: 'Here you can start diplomacy with other communities',
        child: diplomacyButton,
      ),
      AppTooltip(
        size: size,
        message: 'Here you can select game settings',
        child: IconButton(
          onPressed: onSettings,
          padding: const EdgeInsets.all(8),
          icon: settingsImage,
        ),
      ),
    ];

    if (direction == Axis.horizontal) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.hudBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: SafeArea(
          top: false,
          left: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: SafeArea(
        bottom: false,
        left: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  static double width(SizeLayout size, double scale) {
    return 4 * (AppSizes.hudSymbol(size) + 16);
  }
}

class HudResources extends ConsumerWidget {
  final SizeLayout size;

  const HudResources({required this.size, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(gameStateProvider.select((e) => e.resources));
    final availableResources = ref.watch(gameStateProvider.select((e) => e.availableResources));

    return Row(
      children: ResourceType.values
          .map(
            (type) => _buildResource(
              type,
              ref,
              size,
              ResourceType.onlyAvailableAmount.contains(type)
                  ? availableResources[type]?.amount ?? 0
                  : resources[type]?.amount ?? 0,
              ResourceType.noAvailableAmount.contains(type) ? null : availableResources[type]?.amount,
              false,
            ),
          )
          .toList(),
    );
  }

  Widget _buildResource(
      ResourceType type, WidgetRef ref, SizeLayout size, int amount, int? availableAmount, bool last) {
    final content = Padding(
      padding: EdgeInsets.only(right: last ? 0 : 32),
      child: ResourceWidget(
        size: size,
        type: type,
        amount: amount,
        availableAmount: availableAmount,
      ),
    );

    String message = '${type.description}\n\n';
    if (availableAmount != null) {
      message += 'Available: $availableAmount\n';
    }
    message += 'Total: $amount';

    if (isMobile) {
      return InkWell(
        onTap: () {
          ref.read(gameStateProvider.notifier).showMessage(Message(title: type.label, message: message));
        },
        child: content,
      );
    }

    return AppTooltip(
      size: size,
      message: message,
      child: content,
    );
  }

  static double width(SizeLayout size, double scale) {
    return ResourceType.values.length * (ResourceWidget.width(size, scale) + 32);
  }
}

class HudBottom extends ConsumerWidget {
  final SizeLayout size;

  const HudBottom({required this.size, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      color: AppColors.hudBackground,
    );
  }
}

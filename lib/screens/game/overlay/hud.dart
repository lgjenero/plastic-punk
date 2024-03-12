import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/build.dart';
import 'package:plastic_punk/screens/game/overlay/research.dart';
import 'package:plastic_punk/screens/game/overlay/settings.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/resource.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/education_center_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class Hud extends StatelessWidget {
  static const String overlayId = 'hud';

  final FlameGame game;

  const Hud({required this.game, Key? key}) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HudTop(size: size, game: game),
          const Spacer(),
          // HudBottom(size: size),
        ],
      ),
    );
  }
}

class HudTop extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;
  const HudTop({required this.size, required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(gameStateProvider.select((e) => e.resources));

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
            ...ResourceType.values
                .map((type) => ResourceWidget(size: size, type: type, amount: resources[type]?.amount ?? 0)),
            const Spacer(),
            _buildActions(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(WidgetRef ref) {
    final canResearch =
        ref.watch(gameStateProvider.select((e) => e.objects.any((e) => e is ResearchCentreTile && e.constructed)));
    final canDoDiplomacy =
        ref.watch(gameStateProvider.select((e) => e.objects.any((e) => e is EducationCentreTile && e.constructed)));

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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            if (game.overlays.activeOverlays.length > 1) return;
            game.overlays.add(BuildOverlay.overlayId);
          },
          icon: Image.asset(
            'assets/images/app_assets/icons/construction_icon.png',
            fit: BoxFit.contain,
            width: AppSizes.hudSymbol(size),
            height: AppSizes.hudSymbol(size),
          ),
        ),
        IconButton(
            onPressed: () {
              if (game.overlays.activeOverlays.length > 1) return;
              if (!canResearch) {
                ref.read(gameStateProvider.notifier).showMessage(Messages.researchUnavailable);
                return;
              }
              game.overlays.add(ResearchOverlay.overlayId);
            },
            icon: researchImage),
        IconButton(
          onPressed: () {
            if (game.overlays.activeOverlays.length > 1) return;
            if (!canDoDiplomacy) {
              ref.read(gameStateProvider.notifier).showMessage(Messages.diplomacyUnavailable);
              return;
            }
            ref.read(gameStateProvider.notifier).initiateDiplomacy();
          },
          icon: diplomacyImage,
        ),
        IconButton(
          onPressed: () {
            if (game.overlays.activeOverlays.length > 1) return;
            game.overlays.add(SettingsOverlay.overlayId);
          },
          icon: Image.asset(
            'assets/images/app_assets/icons/settings_icon.png',
            fit: BoxFit.contain,
            width: AppSizes.hudSymbol(size),
            height: AppSizes.hudSymbol(size),
          ),
        ),
      ],
    );
  }
}

class HudBottom extends ConsumerWidget {
  final SizeLayout size;
  const HudBottom({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      color: AppColors.hudBackground,
    );
  }
}

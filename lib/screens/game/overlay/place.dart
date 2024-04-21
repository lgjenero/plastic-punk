import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class PlaceOverlay extends StatelessWidget {
  static const String overlayId = 'place';

  final FlameGame game;

  const PlaceOverlay({required this.game, super.key});

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
      child: Align(
        alignment: Alignment.bottomLeft,
        child: PlaceOverlayContent(size: size, game: game),
      ),
    );
  }
}

class PlaceOverlayContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const PlaceOverlayContent({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final building = ref.watch(gameStateProvider.select((e) => e.buildingToBuild));
    if (building == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        top: false,
        right: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppSizes.hudBuilding(size),
              height: AppSizes.hudBuilding(size),
              child: Column(
                children: [
                  Expanded(child: Image.asset(building.imageAsset)),
                  const SizedBox(height: 4),
                  Text(
                    building.name,
                    style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.hudForeground,
                foregroundColor: AppColors.hudBackground,
                padding: const EdgeInsets.all(8),
              ),
              onPressed: () {
                ref.read(gameStateProvider.notifier).cancelBuilding();
              },
              child: Text('Cancel', style: AppFonts.hud(size)),
            ),
          ],
        ),
      ),
    );
  }
}

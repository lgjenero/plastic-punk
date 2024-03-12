import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class DiplomacyOverlay extends StatelessWidget {
  static const String overlayId = 'diplomacy';

  final FlameGame game;

  const DiplomacyOverlay({required this.game, Key? key}) : super(key: key);

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
        alignment: Alignment.bottomRight,
        child: DiplmacyOverlayContent(size: size, game: game),
      ),
    );
  }
}

class DiplmacyOverlayContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const DiplmacyOverlayContent({required this.size, required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
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
        left: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppSizes.hudBuilding(size),
              height: AppSizes.hudBuilding(size),
              child: Column(
                children: [
                  Expanded(child: Image.asset('assets/images/app_assets/diplomatic_mission.png')),
                  const SizedBox(height: 4),
                  Text(
                    'Diplomatic Mission',
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
                ref.read(gameStateProvider.notifier).cancelDiplomacy();
              },
              child: Text('Cancel', style: AppFonts.hud(size)),
            ),
          ],
        ),
      ),
    );
  }
}

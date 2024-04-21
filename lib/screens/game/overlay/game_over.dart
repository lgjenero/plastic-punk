import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/data/game_state_data.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class GameOver extends StatelessWidget {
  static const String overlayId = 'game_over';

  final FlameGame game;

  const GameOver({required this.game, super.key});

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
      child: GameOverContent(size: size, game: game),
    );
  }
}

class GameOverContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const GameOverContent({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.read(gameStateProvider).score == GameScore.lost ? 'Game Over' : 'You Won!';
    final body = ref.read(gameStateProvider).score == GameScore.lost
        ? 'Despite your valiant efforts, the tide of plastic pollution has proven too overwhelming. The once-beautiful landscapes of our world remain shrouded in waste, and the communities\' hopes for a sustainable future dim with each passing day. But do not lose heart—every great challenge invites us to rise again with renewed determination. "PlasticPunk" is more than a game; it\'s a reflection of the real-world battle against environmental neglect. Take what you\'ve learned, strategize anew, and return with the resilience to inspire change. The fight for our planet is never truly lost, for every attempt brings us closer to awakening the world to action. Your journey doesn\'t end here. The world still needs its hero.'
        : 'Congratulations, Champion of Sustainability! Through your tireless efforts, innovative strategies, and compassionate leadership, you\'ve transformed a world choked by plastic pollution into a thriving, sustainable utopia. Your journey from clearing the smallest piece of plastic to pioneering global environmental practices has inspired a revolution. The once gloomy landscapes are now vibrant ecosystems, and communities once resigned to despair are bustling with hope and green innovation. You\'ve proven that change is possible with determination and collective action. Thank you for leading the way in "PlasticPunk"—for the planet, for the future, for us all. Your legacy will echo through the ages as a beacon of hope and restoration. The world is forever grateful.';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: () => _next(message, ref),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.hudBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              constraints: BoxConstraints.tight(AppSizes.message(size)),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(body, style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonForeground,
                      foregroundColor: AppColors.buttonBackground,
                      textStyle: AppFonts.button(size),
                    ),
                    onPressed: () => _back(ref),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _back(WidgetRef ref) {
    ref.read(gameStateProvider.notifier).gameOver();
  }
}

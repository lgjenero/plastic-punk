import 'package:collection/collection.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/message.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/resource.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/math/math.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';
import 'package:plastic_punk/utils/widgets/tooltip.dart';

class BuildingInfoOverlay extends ConsumerWidget {
  static const String overlayId = 'building_info';

  final FlameGame game;

  const BuildingInfoOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: BuildingInfoContent(size: size, game: game),
    );
  }
}

class BuildingInfoContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const BuildingInfoContent({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final building = ref.read(gameStateProvider).selectedBuilding;
    if (building == null) return const SizedBox();

    final node = BuildingTree.nodes.firstWhereOrNull((e) => e.id == building.buildingId);
    if (node == null) return const SizedBox();

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
              constraints: BoxConstraints.tight(AppSizes.buildingInfo(size)),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(node.name, style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                  if (node.resourcesProvided.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Provides:   ', style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground)),
                        ...node.resourcesProvided.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ResourceWidget(size: size, type: e.type, amount: e.amount),
                          );
                        }),
                      ],
                    ),
                  ],
                  if (node.resourcesProduced.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Produces (every cycle):   ',
                            style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground)),
                        ...node.resourcesProduced.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ResourceWidget(size: size, type: e.resource.type, amount: e.resource.amount),
                          );
                        }),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: RichText(
                        text: TextSpan(
                          style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
                          children: node.infoMessage.body(size),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _DeconstructButton(size: size, building: building, onPressed: () => _deconstruct(building, ref)),
                      const Spacer(),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.buttonForeground,
                          foregroundColor: AppColors.buttonBackground,
                          textStyle: AppFonts.button(size),
                        ),
                        onPressed: () => _close(ref),
                        child: const Text('Close'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _deconstruct(BuildingTile building, WidgetRef ref) {
    ref.read(gameStateProvider.notifier).deselectBuilding();
    ref.read(gameStateProvider.notifier).deconstructBuilding(building);
  }

  void _close(WidgetRef ref) {
    ref.read(gameStateProvider.notifier).deselectBuilding();
  }
}

class _DeconstructButton extends ConsumerWidget {
  final SizeLayout size;
  final BuildingTile building;
  final VoidCallback? onPressed;

  const _DeconstructButton({required this.size, required this.building, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canDeconstruct = true;

    if (building.addResources == false) {
      canDeconstruct = false;
    } else if (AppTiles.transportationTiles.contains(building.buildingId)) {
      final mapComponent = ref.read(gameStateProvider.notifier).mapComponent;
      final neighbours = AppMath.getNeighbouringTiles(building.tilePosition, AppLayers.terrain, mapComponent);
      final buildings = ref.read(gameStateProvider).objects.whereType<BuildingTile>();

      for (final neighbour in neighbours) {
        final neighbourBuilding = buildings.firstWhereOrNull((e) => e.tilePosition == neighbour.position);
        if (neighbourBuilding != null) {
          final neighbourBuildingNeighbours =
              AppMath.getNeighbouringTiles(neighbourBuilding.tilePosition, AppLayers.terrain, mapComponent);

          final neighbourHasOtherTrack = neighbourBuildingNeighbours
              .any((e) => AppTiles.transportationTiles.contains(e.data.tile) && e.position != building.tilePosition);
          if (!neighbourHasOtherTrack) {
            canDeconstruct = false;
            break;
          }
        }
      }
    }

    final button = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.buttonForeground,
        foregroundColor: AppColors.buttonBackground,
        textStyle: AppFonts.button(size),
      ),
      onPressed: onPressed,
      child: const Text('Deconstruct'),
    );

    if (!canDeconstruct) {
      return AppTooltip(
        size: size,
        message: 'Cannot deconstruct this track, it connects other buildings.',
        child: IgnorePointer(ignoring: true, child: Grayscale(child: button)),
      );
    }

    return button;
  }
}

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/resource.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class BuildOverlay extends StatelessWidget {
  static const String overlayId = 'build';

  final FlameGame game;

  const BuildOverlay({required this.game, super.key});

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
          const Spacer(),
          BuildingList(size: size, game: game),
        ],
      ),
    );
  }
}

class BuildingList extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const BuildingList({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.read(gameStateProvider.notifier).level;
    final buildings = BuildingTree.nodes.where((e) => level.enabledBuildings.contains(e.id)).toList();
    final existingBuildings = ref
        .watch(gameStateProvider.select((e) => e.objects))
        .whereType<BuildingTile>()
        .where((e) => e.constructed)
        .map((e) => e.buildingId)
        .toSet();
    final buildingsBeingConstructed = ref
        .watch(gameStateProvider.select((e) => e.objects))
        .whereType<BuildingTile>()
        .where((e) => !e.constructed)
        .map((e) => e.buildingId)
        .toSet();
    final resources = ref.watch(gameStateProvider.select((e) => e.availableResources));
    final technology = ref.watch(gameStateProvider.select((e) => e.technologies));
    final canBuild = _calculateAvailableBuildings(
      buildings,
      existingBuildings,
      buildingsBeingConstructed,
      resources,
      technology,
    );

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SizedBox(
          height: AppSizes.hudBuilding(size),
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: buildings.length,
                  itemExtent: AppSizes.hudBuilding(size),
                  itemBuilder: (context, index) {
                    final building = buildings.elementAt(index);
                    return _buildBuilding(building, canBuild.contains(building.id), ref);
                  },
                ),
              ),
              Positioned(
                top: 6,
                right: 0,
                child: SafeArea(
                  top: false,
                  left: false,
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.hudForeground,
                        foregroundColor: AppColors.hudBackground,
                        padding: const EdgeInsets.all(0),
                        fixedSize: const Size(40, 40),
                      ),
                      onPressed: () => game.overlays.remove(BuildOverlay.overlayId),
                      child: Icon(Icons.close_rounded, size: AppSizes.hudSymbol(size), color: AppColors.hudBackground),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuilding(BuildingNode building, bool canBuild, WidgetRef ref) {
    Widget image = Image.asset(building.imageAsset);
    if (!canBuild) {
      image = Grayscale(child: image);
    }

    return InkWell(
      onTap: () {
        if (!canBuild) {
          return;
        }

        game.overlays.remove(BuildOverlay.overlayId);
        ref.read(gameStateProvider.notifier).placeBuilding(building);
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (building.resourcesRequired.isNotEmpty || building.resourcesConsumed.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Costs: ', style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground)),
                          ...building.resourcesRequired.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ResourceWidget(size: size, type: e.type, amount: e.amount, scale: 0.6),
                            );
                          }),
                          ...building.resourcesConsumed.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ResourceWidget(size: size, type: e.type, amount: e.amount, scale: 0.6),
                            );
                          }),
                        ],
                      ),
                    ),
                  const SizedBox(height: 4),
                  if (building.resourcesProvided.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Provides: ', style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground)),
                          ...building.resourcesProvided.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ResourceWidget(size: size, type: e.type, amount: e.amount, scale: 0.6),
                            );
                          }),
                        ],
                      ),
                    ),
                  Expanded(child: image),
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
            Positioned(
              bottom: 30,
              right: 0,
              child: InkWell(
                onTap: () {
                  ref.read(gameStateProvider.notifier).showMessage(building.infoMessage);
                },
                child: Icon(
                  Icons.info_rounded,
                  size: AppSizes.hudSymbol(size),
                  color: AppColors.hudForeground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<int> _calculateAvailableBuildings(
    List<BuildingNode> buildings,
    Set<int> existingBuildings,
    Set<int> buildingsBeingConstructed,
    Map<ResourceType, Resource> resources,
    Set<TechnologyType> technologies,
  ) {
    final availableBuildings = <int>{};

    for (final building in buildings) {
      final requiredBuildingsOk = building.buildingsRequired.every(existingBuildings.contains);
      if (!requiredBuildingsOk) continue;

      final blockingBuildingsOk = building.buildingsBlocking
          .every((e) => !existingBuildings.contains(e) && !buildingsBeingConstructed.contains(e));

      if (!blockingBuildingsOk) continue;

      final requiredTechnologiesOk = building.technologiesRequired.every(technologies.contains);
      if (!requiredTechnologiesOk) continue;

      bool requiredResourcesOk = true;
      for (final resource in building.resourcesRequired) {
        final availableResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
        if (availableResource.amount < resource.amount) {
          requiredResourcesOk = false;
          break;
        }
      }
      for (final resource in building.resourcesConsumed) {
        final availableResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
        if (availableResource.amount < resource.amount) {
          requiredResourcesOk = false;
          break;
        }
      }
      if (!requiredResourcesOk) continue;

      availableBuildings.add(building.id);
    }

    return availableBuildings;
  }
}

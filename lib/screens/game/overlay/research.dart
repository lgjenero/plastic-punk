import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/resource.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/grayscale.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class ResearchOverlay extends StatelessWidget {
  static const String overlayId = 'research';

  final FlameGame game;

  const ResearchOverlay({required this.game, super.key});

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
          ResearchList(size: size, game: game),
        ],
      ),
    );
  }
}

class ResearchList extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const ResearchList({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.read(gameStateProvider.notifier).level;
    final technology = TechnologyTree.nodes.where((e) => level.enabledTechnologies.contains(e.type)).toList();
    final buildings =
        ref.watch(gameStateProvider.select((e) => e.objects)).whereType<BuildingTile>().where((e) => e.constructed);

    final resources = ref.watch(gameStateProvider.select((e) => e.availableResources));
    final existingTechnology = ref.watch(gameStateProvider.select((e) => e.technologies));
    final researching =
        buildings.whereType<ResearchCentreTile>().map((e) => e.researching).whereType<TechnologyType>().toSet();
    final canResearch = _calculateAvailableTechnologies(
      technology,
      buildings.map((e) => e.buildingId).toSet(),
      resources,
      existingTechnology,
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
          height: AppSizes.hudTechnology(size),
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: technology.length,
                  itemExtent: AppSizes.hudTechnology(size),
                  itemBuilder: (context, index) {
                    final tech = technology.elementAt(index);
                    return _buildTech(
                      tech,
                      canResearch.contains(tech.type),
                      researching.contains(tech.type),
                      existingTechnology.contains(tech.type),
                      ref,
                    );
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
                      onPressed: () => game.overlays.remove(ResearchOverlay.overlayId),
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

  Widget _buildTech(TechnologyNode tech, bool canResearch, bool isResearching, bool alreadyResearched, WidgetRef ref) {
    Widget image = Image.asset(tech.imageAsset);
    if (!canResearch && !alreadyResearched) {
      image = Grayscale(child: image);
    }

    return InkWell(
      onTap: () {
        if (!canResearch) {
          // some feedback
          return;
        }

        if (isResearching) {
          // some feedback
          return;
        }

        if (alreadyResearched) {
          // some feedback
          return;
        }

        game.overlays.remove(ResearchOverlay.overlayId);
        ref.read(gameStateProvider.notifier).researchTechnology(tech);
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...tech.resourcesRequired.map((e) {
                          return ResourceWidget(size: size, type: e.type, amount: e.amount, scale: 0.6);
                        }),
                        ...tech.resourcesConsumed.map((e) {
                          return ResourceWidget(size: size, type: e.type, amount: e.amount, scale: 0.6);
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      Positioned.fill(child: image),
                      if (isResearching)
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.hudBackground,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            child: Text(
                              'Researching...',
                              style: AppFonts.hud(size).copyWith(color: AppColors.hudForeground),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      if (alreadyResearched)
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.hudBackground,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.check_rounded,
                              size: AppSizes.hudSymbol(size),
                              color: AppColors.hudForeground,
                            ),
                          ),
                        ),
                    ],
                  )),
                  const SizedBox(height: 4),
                  Text(
                    tech.name,
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
                  ref.read(gameStateProvider.notifier).showMessage(tech.infoMessage);
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

  Set<TechnologyType> _calculateAvailableTechnologies(
    List<TechnologyNode> technology,
    Set<int> buildings,
    Map<ResourceType, Resource> resources,
    Set<TechnologyType> existingTechnology,
  ) {
    final availableTechnologies = <TechnologyType>{};

    for (final tech in technology) {
      // if (existingTechnology.contains(tech.type)) continue;

      final requiredBuildingsOk = tech.buildingsRequired.every(buildings.contains);
      if (!requiredBuildingsOk) continue;

      final requiredTechnologiesOk = tech.technologiesRequired.every(existingTechnology.contains);
      if (!requiredTechnologiesOk) continue;

      bool requiredResourcesOk = true;
      for (final resource in tech.resourcesRequired) {
        final availableResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
        if (availableResource.amount < resource.amount) {
          requiredResourcesOk = false;
          break;
        }
      }
      for (final resource in tech.resourcesConsumed) {
        final availableResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
        if (availableResource.amount < resource.amount) {
          requiredResourcesOk = false;
          break;
        }
      }
      if (!requiredResourcesOk) continue;

      availableTechnologies.add(tech.type);
    }

    return availableTechnologies;
  }
}

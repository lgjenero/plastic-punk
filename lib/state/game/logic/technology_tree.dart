import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class TechnologyNode {
  final TechnologyType type;
  final String name;
  final String imageAsset;
  final List<int> buildingsRequired;
  final List<TechnologyType> technologiesRequired;
  final List<Resource> resourcesRequired;
  final List<Resource> resourcesConsumed;
  final List<Resource> resourcesProduced;
  final Message infoMessage;

  TechnologyNode({
    required this.type,
    required this.name,
    required this.imageAsset,
    required this.buildingsRequired,
    required this.technologiesRequired,
    required this.resourcesRequired,
    required this.resourcesConsumed,
    required this.resourcesProduced,
    required this.infoMessage,
  });
}

enum TechnologyType {
  plasticsReduce,
  plasticsReuse,
  plasticsRecycle,
  waterTreatment,
  waterCleanup,
  microplasticsFilter,
  microplasticsCleanup,
}

class TechnologyTree {
  // static
  static List<TechnologyNode> nodes = [
    // plastics usage reduction
    TechnologyNode(
      type: TechnologyType.plasticsReduce,
      name: 'Plastics usage reduction',
      imageAsset: 'assets/images/app_assets/tech/plastics_reduce.png',
      buildingsRequired: [AppTiles.researchCentre],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 5)],
      resourcesProduced: [const Resource(type: ResourceType.impact, amount: 10)],
      infoMessage: Messages.plasticsReduceInfoMessage,
    ),

    // plastics reuse
    TechnologyNode(
      type: TechnologyType.plasticsReuse,
      name: 'Plastics reuse',
      imageAsset: 'assets/images/app_assets/tech/plastics_reuse.png',
      buildingsRequired: [AppTiles.researchCentre],
      technologiesRequired: [TechnologyType.plasticsReduce],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 5)],
      resourcesProduced: [],
      infoMessage: Messages.plasticsReuseInfoMessage,
    ),

    // plastics recycling
    TechnologyNode(
      type: TechnologyType.plasticsRecycle,
      name: 'Plastics recycling',
      imageAsset: 'assets/images/app_assets/tech/plastics_recycle.png',
      buildingsRequired: [AppTiles.plasticsEnergy],
      technologiesRequired: [TechnologyType.plasticsReuse],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 5)],
      resourcesProduced: [],
      infoMessage: Messages.plasticsRecycleInfoMessage,
    ),

    // water treatment
    TechnologyNode(
      type: TechnologyType.waterTreatment,
      name: 'Water treatment',
      imageAsset: 'assets/images/app_assets/tech/water_treatment.png',
      buildingsRequired: [AppTiles.plasticRecycling],
      technologiesRequired: [TechnologyType.plasticsRecycle],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 5)],
      resourcesProduced: [],
      infoMessage: Messages.waterTreatmentTechInfoMessage,
    ),

    // water cleanup
    TechnologyNode(
      type: TechnologyType.waterCleanup,
      name: 'Water cleanup',
      imageAsset: 'assets/images/app_assets/tech/water_cleanup.png',
      buildingsRequired: [AppTiles.waterTreatment],
      technologiesRequired: [TechnologyType.waterTreatment],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 5)],
      resourcesProduced: [],
      infoMessage: Messages.waterCleanupTechInfoMessage,
    ),
  ];
}

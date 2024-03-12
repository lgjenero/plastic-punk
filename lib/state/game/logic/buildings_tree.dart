import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/education_center_tile.dart';
import 'package:plastic_punk/state/game/objects/garden_tile.dart';
import 'package:plastic_punk/state/game/objects/house_tile.dart';
import 'package:plastic_punk/state/game/objects/park_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_energy_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_recycling_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/objects/solar_panels_tile.dart';
import 'package:plastic_punk/state/game/objects/town_hall.dart';
import 'package:plastic_punk/state/game/objects/water_cleanup_tile.dart';
import 'package:plastic_punk/state/game/objects/water_treatment_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';

class BuildingNode {
  final int id;
  final String name;
  final String imageAsset;
  final List<int> buildingsRequired;
  final List<int> buildingsBlocking;
  final List<TechnologyType> technologiesRequired;
  final List<Resource> resourcesRequired;
  final List<Resource> resourcesConsumed;
  final BuildingTile Function(TilePosition position) placementConstructor;
  final BuildingTile Function(TilePosition position) constructor;
  final Message infoMessage;
  final bool isOnWater;

  BuildingNode({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.buildingsRequired,
    required this.buildingsBlocking,
    required this.technologiesRequired,
    required this.resourcesRequired,
    required this.resourcesConsumed,
    required this.placementConstructor,
    required this.constructor,
    required this.infoMessage,
    this.isOnWater = false,
  });
}

class BuildingTree {
  // town hall - no requirements

  static final List<BuildingNode> nodes = [
    // town hall - no requirements
    BuildingNode(
      id: AppTiles.townHall,
      name: 'Town hall',
      imageAsset: 'assets/images/Tiles/town_hall.png',
      buildingsRequired: [],
      buildingsBlocking: [AppTiles.townHall],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [],
      placementConstructor: (position) => TownHallTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => TownHallTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.townHallInfoMessage,
    ),

    // food production - requires town hall
    BuildingNode(
      id: AppTiles.garden,
      name: 'Garden',
      imageAsset: 'assets/images/Tiles/garden.png',
      buildingsRequired: [AppTiles.townHall],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [Resource(type: ResourceType.water, amount: 5)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) => GardenTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => GardenTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.gardenInfoMessage,
    ),

    // house - requires town hall and food production
    BuildingNode(
      id: AppTiles.house,
      name: 'Housing',
      imageAsset: 'assets/images/Tiles/house.png',
      buildingsRequired: [AppTiles.garden],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [Resource(type: ResourceType.water, amount: 5), Resource(type: ResourceType.food, amount: 5)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) => HouseTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => HouseTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.houseInfoMessage,
    ),

    // research lab - requires town hall, more people, electricity
    BuildingNode(
      id: AppTiles.researchCentre,
      name: 'Research centre',
      imageAsset: 'assets/images/Tiles/research_centre.png',
      buildingsRequired: [AppTiles.townHall, AppTiles.garden, AppTiles.house],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [
        Resource(type: ResourceType.population, amount: 10),
        Resource(type: ResourceType.electricity, amount: 5),
      ],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          ResearchCentreTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => ResearchCentreTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.researchCentreInfoMessage,
    ),

    // plastics recycling facility - requires research centre
    BuildingNode(
      id: AppTiles.plasticRecycling,
      name: 'Plastics recycling facility',
      imageAsset: 'assets/images/Tiles/plastics_recycling.png',
      buildingsRequired: [AppTiles.researchCentre],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.plasticsRecycle],
      resourcesRequired: [],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          PlasticsRecyclingTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => PlasticsRecyclingTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.plasticsRecyclingInfoMessage,
    ),

    // plastics energy facility - requires research centre, plastics recycling
    BuildingNode(
      id: AppTiles.plasticsEnergy,
      name: 'Plastics energy facility',
      imageAsset: 'assets/images/Tiles/plastics_energy.png',
      buildingsRequired: [AppTiles.plasticRecycling],
      buildingsBlocking: [AppTiles.solarPanels],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          PlasticsEnergyTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => PlasticsEnergyTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.plasticsEnergyInfoMessage,
    ),

    // water treatment plant - requires research centre
    BuildingNode(
      id: AppTiles.waterTreatment,
      name: 'Water treatment plant',
      imageAsset: 'assets/images/Tiles/water_treatment.png',
      buildingsRequired: [AppTiles.researchCentre],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.waterTreatment],
      resourcesRequired: [Resource(type: ResourceType.electricity, amount: 5)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          WaterTreatmentTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => WaterTreatmentTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.waterTreatmentInfoMessage,
    ),

    // park - requires research centre
    BuildingNode(
      id: AppTiles.park,
      name: 'Park',
      imageAsset: 'assets/images/Tiles/park.png',
      buildingsRequired: [AppTiles.waterTreatment],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [Resource(type: ResourceType.population, amount: 20)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) => ParkTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => ParkTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.parkInfoMessage,
    ),

    // solar panel - requires research centre
    BuildingNode(
      id: AppTiles.solarPanels,
      name: 'Solar panels',
      imageAsset: 'assets/images/Tiles/solar_panels.png',
      buildingsRequired: [AppTiles.park],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [Resource(type: ResourceType.population, amount: 20)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 30)],
      placementConstructor: (position) =>
          SolarPanelsTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => SolarPanelsTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.solarPanelsInfoMessage,
    ),

    // water cleanup plant - requires research centre, water treatment
    BuildingNode(
      id: AppTiles.waterCleanup,
      name: 'Water Cleanup Facility',
      imageAsset: 'assets/images/Tiles/water_cleanup.png',
      buildingsRequired: [AppTiles.park],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.waterTreatment],
      resourcesRequired: [Resource(type: ResourceType.electricity, amount: 20)],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          WaterCleanupTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => WaterCleanupTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.waterCleanupInfoMessage,
      isOnWater: true,
    ),

    // education centre
    BuildingNode(
      id: AppTiles.educationCentre,
      name: 'Education Centre',
      imageAsset: 'assets/images/Tiles/education_centre.png',
      buildingsRequired: [AppTiles.waterCleanup],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [
        Resource(type: ResourceType.electricity, amount: 20),
        Resource(type: ResourceType.population, amount: 10),
      ],
      resourcesConsumed: [Resource(type: ResourceType.material, amount: 20)],
      placementConstructor: (position) =>
          EducationCentreTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position) => EducationCentreTile(tilePosition: position, isPaused: false),
      infoMessage: Messages.educationCentreInfoMessage,
    ),
  ];
}

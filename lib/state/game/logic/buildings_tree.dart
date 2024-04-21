import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/bad_housing_tile.dart';
import 'package:plastic_punk/state/game/objects/bad_town_hall.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/education_center_tile.dart';
import 'package:plastic_punk/state/game/objects/garden_tile.dart';
import 'package:plastic_punk/state/game/objects/house_tile.dart';
import 'package:plastic_punk/state/game/objects/park_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_energy_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_factory_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_recycling_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/objects/road_tile.dart';
import 'package:plastic_punk/state/game/objects/solar_panels_tile.dart';
import 'package:plastic_punk/state/game/objects/town_hall.dart';
import 'package:plastic_punk/state/game/objects/tracks_tile.dart';
import 'package:plastic_punk/state/game/objects/water_cleanup_tile.dart';
import 'package:plastic_punk/state/game/objects/water_treatment_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/amounts.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';

class BuildingNode {
  final int id;
  final String name;
  final String imageAsset;
  final List<int> buildingsRequired;
  final List<int> buildingsBlocking;
  final List<TechnologyType> technologiesRequired;
  final List<Resource> resourcesRequired;
  final List<Resource> resourcesConsumed;
  final List<Resource> resourcesProvided;
  final List<ResourceProduction> resourcesProduced;
  final BuildingTile Function(TilePosition position) placementConstructor;
  final BuildingTile Function(TilePosition position, bool startsConstructed, bool addResources) constructor;
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
    required this.resourcesProvided,
    required this.resourcesProduced,
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
      resourcesProvided: [
        const Resource(type: ResourceType.water, amount: AppAmmounts.townHallWaterAmount),
        const Resource(type: ResourceType.population, amount: AppAmmounts.townHallPopulationAmount),
        const Resource(type: ResourceType.electricity, amount: AppAmmounts.townHallElectricityAmount),
      ],
      resourcesProduced: [
        ResourceProduction(
          resource: const Resource(type: ResourceType.material, amount: AppAmmounts.townHallMaterialProductionAmount),
          productionTime: AppTimes.townHallProductionDuration,
        )
      ],
      placementConstructor: (position) => TownHallTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, addResources) => TownHallTile(
          tilePosition: position, isPaused: false, startsConstructed: startsConstructed, addResources: addResources),
      infoMessage: Messages.townHallInfoMessage,
    ),

    // transportation - requires town hall
    BuildingNode(
      id: AppTiles.transportationMin,
      name: 'Transportation',
      imageAsset: 'assets/images/Tiles/transport_1.png',
      buildingsRequired: [AppTiles.townHall],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 10)],
      resourcesProvided: [const Resource(type: ResourceType.impact, amount: -2)],
      resourcesProduced: [],
      placementConstructor: (position) => TracksTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, addResources) => TracksTile(
          tilePosition: position, isPaused: false, startsConstructed: startsConstructed, addResources: addResources),
      infoMessage: Messages.transportationInfoMessage,
    ),

    // food production - requires town hall
    BuildingNode(
      id: AppTiles.garden,
      name: 'Garden',
      imageAsset: 'assets/images/Tiles/garden.png',
      buildingsRequired: [AppTiles.townHall],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [const Resource(type: ResourceType.water, amount: 5)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [const Resource(type: ResourceType.food, amount: AppAmmounts.gardenFoodAmount)],
      resourcesProduced: [],
      placementConstructor: (position) => GardenTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, addResources) =>
          GardenTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
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
      resourcesRequired: [
        const Resource(type: ResourceType.water, amount: 5),
        const Resource(type: ResourceType.food, amount: 5)
      ],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [
        const Resource(type: ResourceType.population, amount: AppAmmounts.housePopulationAmount),
        const Resource(type: ResourceType.impact, amount: -5),
      ],
      resourcesProduced: [],
      placementConstructor: (position) => HouseTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, addResources) => HouseTile(
          tilePosition: position, isPaused: false, startsConstructed: startsConstructed, addResources: addResources),
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
        const Resource(type: ResourceType.population, amount: 10),
        const Resource(type: ResourceType.electricity, amount: 5),
      ],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProduced: [],
      resourcesProvided: [],
      placementConstructor: (position) =>
          ResearchCentreTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          ResearchCentreTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.researchCentreInfoMessage,
    ),

    // plastics energy facility - requires research centre, plastics recycling
    BuildingNode(
      id: AppTiles.plasticsEnergy,
      name: 'Plastics energy facility',
      imageAsset: 'assets/images/Tiles/plastics_energy.png',
      buildingsRequired: [AppTiles.researchCentre],
      buildingsBlocking: [AppTiles.solarPanels],
      technologiesRequired: [TechnologyType.plasticsReuse],
      resourcesRequired: [],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [
        const Resource(type: ResourceType.electricity, amount: AppAmmounts.plasticsBurningElectricityAmount),
        const Resource(type: ResourceType.impact, amount: AppAmmounts.plasticsBurningImpactAmount),
      ],
      resourcesProduced: [],
      placementConstructor: (position) =>
          PlasticsEnergyTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          PlasticsEnergyTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.plasticsEnergyInfoMessage,
    ),

    // plastics recycling facility - requires research centre
    BuildingNode(
      id: AppTiles.plasticRecycling,
      name: 'Plastics recycling facility',
      imageAsset: 'assets/images/Tiles/plastics_recycling.png',
      buildingsRequired: [AppTiles.researchCentre],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.plasticsRecycle],
      resourcesRequired: [const Resource(type: ResourceType.electricity, amount: 20)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [const Resource(type: ResourceType.impact, amount: 10)],
      resourcesProduced: [
        ResourceProduction(
          resource: const Resource(type: ResourceType.material, amount: AppAmmounts.plasticRecyclingMaterialAmount),
          productionTime: AppTimes.plasticsRecyclingDuration,
        )
      ],
      placementConstructor: (position) =>
          PlasticsRecyclingTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          PlasticsRecyclingTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.plasticsRecyclingInfoMessage,
    ),

    // water treatment plant - requires research centre
    BuildingNode(
      id: AppTiles.waterTreatment,
      name: 'Water treatment plant',
      imageAsset: 'assets/images/Tiles/water_treatment.png',
      buildingsRequired: [AppTiles.researchCentre],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.waterTreatment],
      resourcesRequired: [const Resource(type: ResourceType.electricity, amount: 20)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [const Resource(type: ResourceType.water, amount: AppAmmounts.waterTreatmentWaterAmount)],
      resourcesProduced: [],
      placementConstructor: (position) =>
          WaterTreatmentTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          WaterTreatmentTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
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
      resourcesRequired: [const Resource(type: ResourceType.population, amount: 10)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [const Resource(type: ResourceType.impact, amount: 20)],
      resourcesProduced: [],
      placementConstructor: (position) => ParkTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          ParkTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.parkInfoMessage,
    ),

    // solar panel - requires research centre
    BuildingNode(
      id: AppTiles.solarPanels,
      name: 'Solar panels',
      imageAsset: 'assets/images/Tiles/solar_panels.png',
      buildingsRequired: [AppTiles.waterTreatment],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [const Resource(type: ResourceType.population, amount: 10)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 60)],
      resourcesProvided: [
        const Resource(type: ResourceType.electricity, amount: AppAmmounts.solarPanelsElectricityAmount),
        const Resource(type: ResourceType.impact, amount: 10),
      ],
      resourcesProduced: [],
      placementConstructor: (position) =>
          SolarPanelsTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          SolarPanelsTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.solarPanelsInfoMessage,
    ),

    // water cleanup plant - requires research centre, water treatment
    BuildingNode(
      id: AppTiles.waterCleanup,
      name: 'Water Cleanup Facility',
      imageAsset: 'assets/images/Tiles/water_cleanup.png',
      buildingsRequired: [AppTiles.solarPanels],
      buildingsBlocking: [],
      technologiesRequired: [TechnologyType.waterCleanup],
      resourcesRequired: [const Resource(type: ResourceType.electricity, amount: 20)],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 20)],
      resourcesProvided: [const Resource(type: ResourceType.impact, amount: 10)],
      resourcesProduced: [],
      placementConstructor: (position) =>
          WaterCleanupTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          WaterCleanupTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
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
        const Resource(type: ResourceType.electricity, amount: 20),
        const Resource(type: ResourceType.population, amount: 10),
      ],
      resourcesConsumed: [const Resource(type: ResourceType.material, amount: 60)],
      resourcesProvided: [],
      resourcesProduced: [],
      placementConstructor: (position) =>
          EducationCentreTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          EducationCentreTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.educationCentreInfoMessage,
    ),

    // --- Enemy buildings ---

    // bad housing
    BuildingNode(
      id: AppTiles.badHousing,
      name: 'Bad Housing',
      imageAsset: 'assets/images/Tiles/bad_housing.png',
      buildingsRequired: [],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [],
      resourcesProvided: [],
      resourcesProduced: [],
      placementConstructor: (position) =>
          BadHousingTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          BadHousingTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.badHousingInfoMessage,
    ),

    // plastics factory
    BuildingNode(
      id: AppTiles.plasticsFactory,
      name: 'Plastics Factory',
      imageAsset: 'assets/images/Tiles/plastics_factory.png',
      buildingsRequired: [],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [],
      resourcesProvided: [],
      resourcesProduced: [],
      placementConstructor: (position) =>
          PlasticsFactoryTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          PlasticsFactoryTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.plasticsFactoryInfoMessage,
    ),

    // bad transportation
    BuildingNode(
      id: AppTiles.pollutedTransportationMin,
      name: 'Bad transportation',
      imageAsset: 'assets/images/Tiles/polluted_trasnport_1.png',
      buildingsRequired: [],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [],
      resourcesProvided: [],
      resourcesProduced: [],
      placementConstructor: (position) => RoadTile(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          RoadTile(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.roadInfoMessage,
    ),

    // bad town hall
    BuildingNode(
      id: AppTiles.badTownHall,
      name: 'Bad town hall',
      imageAsset: 'assets/images/Tiles/bad_town_hall.png',
      buildingsRequired: [],
      buildingsBlocking: [],
      technologiesRequired: [],
      resourcesRequired: [],
      resourcesConsumed: [],
      resourcesProvided: [],
      resourcesProduced: [],
      placementConstructor: (position) => BadTownHall(tilePosition: position, isPaused: true, startsConstructed: true),
      constructor: (position, startsConstructed, _) =>
          BadTownHall(tilePosition: position, isPaused: false, startsConstructed: startsConstructed),
      infoMessage: Messages.badTownHallInfoMessage,
    ),
  ];
}

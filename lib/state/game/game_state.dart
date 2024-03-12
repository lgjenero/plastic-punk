import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plastic_punk/screens/game/overlay/diplomacy.dart';
import 'package:plastic_punk/screens/game/overlay/game_over.dart';
import 'package:plastic_punk/screens/game/overlay/message.dart';
import 'package:plastic_punk/screens/game/overlay/place.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/logic/tile_data.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/bad_housing_tile.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/objects/diplomacy_placement_tile.dart';
import 'package:plastic_punk/state/game/objects/diplomatic_mission_tile.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/objects/placement_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_energy_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_factory_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/objects/selected_tile.dart';
import 'package:plastic_punk/state/game/objects/town_hall.dart';
import 'package:plastic_punk/state/game/objects/water_cleanup_tile.dart';
import 'package:plastic_punk/state/game/objects/water_placement_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/objects.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/math.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state.g.dart';
part 'game_state_building.dart';
part 'game_state_cleanup.dart';
part 'game_state_data.dart';
part 'game_state_diplomacy.dart';
part 'game_state_message.dart';
part 'game_state_object.dart';
part 'game_state_pollution.dart';
part 'game_state_resource.dart';
part 'game_state_score.dart';
part 'game_state_settings.dart';
part 'game_state_technology.dart';

class GameStateData {
  final List<GameObject> objects;
  final Map<ResourceType, Resource> resources;
  final Map<ResourceType, Resource> availableResources;
  final Set<TechnologyType> technologies;
  final BuildingNode? buildingToBuild;
  final Set<TilePosition> tilesToClean;
  final Message? message;
  final GameScore score;
  final double gameSpeed;
  final bool useAutomaticCleanup;

  GameStateData({
    required this.objects,
    required this.resources,
    required this.availableResources,
    required this.technologies,
    this.buildingToBuild,
    required this.tilesToClean,
    this.message,
    required this.score,
    this.gameSpeed = 1,
    this.useAutomaticCleanup = false,
  });

  GameStateData copyWith({
    List<GameObject>? objects,
    Map<ResourceType, Resource>? resources,
    Map<ResourceType, Resource>? availableResources,
    Set<TechnologyType>? technologies,
    BuildingNode? buildingToBuild,
    bool resetBuildingToBuild = false,
    Set<TilePosition>? tilesToClean,
    Message? message,
    bool resetMessage = false,
    GameScore? score,
    double? gameSpeed,
    bool? useAutomaticCleanup,
  }) {
    return GameStateData(
      objects: objects ?? this.objects,
      resources: resources ?? this.resources,
      availableResources: availableResources ?? this.availableResources,
      technologies: technologies ?? this.technologies,
      buildingToBuild: resetBuildingToBuild ? null : buildingToBuild ?? this.buildingToBuild,
      tilesToClean: tilesToClean ?? this.tilesToClean,
      message: resetMessage ? null : message ?? this.message,
      score: score ?? this.score,
      gameSpeed: gameSpeed ?? this.gameSpeed,
      useAutomaticCleanup: useAutomaticCleanup ?? this.useAutomaticCleanup,
    );
  }
}

@Riverpod(keepAlive: true)
class GameState extends _$GameState {
  late TiledComponent _mapComponent;
  late FlameGame _game;
  late TilePosition _start;

  TiledComponent get mapComponent => _mapComponent;
  List<GameObject> get objects => state.objects;
  Map<ResourceType, Resource> get resources => state.resources;
  Set<TechnologyType> get technologies => state.technologies;

  @override
  GameStateData build() {
    return GameStateData(
      objects: [],
      resources: {},
      availableResources: {},
      technologies: {},
      tilesToClean: {},
      score: GameScore.notStarted,
    );
  }

  void initialize(FlameGame game, TiledComponent mapComponent) {
    _mapComponent = mapComponent;
    _game = game;
    state = state.copyWith(
      objects: [],
      resources: {},
      availableResources: {},
      technologies: {},
      gameSpeed: 1,
      useAutomaticCleanup: false,
    );
    AppTimes.gameSpeed = state.gameSpeed;

    _initObjects();

    // show welcome message
    Future.delayed(const Duration(seconds: 1), () {
      showMessage(Messages.welcomeMessage);
    });
  }

  void update(double dt) {
    for (final object in state.objects) {
      object.update(dt, this);
    }
    _checkScore();
  }

  void onTap(TapUpEvent event) {
    event.handled = false;
    event.continuePropagation = true;

    final globalPos = event.canvasPosition;
    final localPos = _game.camera.globalToLocal(globalPos);
    final tilePos = AppMath.positionToTile(
      localPos,
      mapComponent.tileMap.destTileSize,
      mapComponent.tileMap.map.width,
      mapComponent.tileMap.map.height,
    );

    // try to process cleaning tap
    final isCleanupTap = _tapCleanup(tilePos);
    if (isCleanupTap) {
      event.handled = true;
      event.continuePropagation = false;
    }
  }
}

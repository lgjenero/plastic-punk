import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart' as components;
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/screens/game/overlay/achievement.dart';
import 'package:plastic_punk/screens/game/overlay/building_info.dart';
import 'package:plastic_punk/screens/game/overlay/diplomacy.dart';
import 'package:plastic_punk/screens/game/overlay/game_over.dart';
import 'package:plastic_punk/screens/game/overlay/hud.dart';
import 'package:plastic_punk/screens/game/overlay/loading.dart';
import 'package:plastic_punk/screens/game/overlay/message.dart';
import 'package:plastic_punk/screens/game/overlay/place.dart';
import 'package:plastic_punk/services/firebase/firestore_service.dart';
import 'package:plastic_punk/services/onboarding/onboarding_tooltips.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/components/tile_animation_component.dart';
import 'package:plastic_punk/state/game/components/tile_position.dart';
import 'package:plastic_punk/state/game/data/game_state_data.dart';
import 'package:plastic_punk/state/game/data/game_state_saved_data.dart';
import 'package:plastic_punk/state/game/events/event.dart';
import 'package:plastic_punk/state/game/events/events.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/state/game/logic/achievement_tree.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/logic/tile_data.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/state/game/messages/messages.dart';
import 'package:plastic_punk/state/game/objects/bad_town_hall.dart';
import 'package:plastic_punk/state/game/objects/building_cleaning_tile.dart';
import 'package:plastic_punk/state/game/objects/building_polluting_tile.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';
import 'package:plastic_punk/state/game/objects/cleanup_tile.dart';
import 'package:plastic_punk/state/game/objects/diplomacy_placement_tile.dart';
import 'package:plastic_punk/state/game/objects/diplomatic_mission_tile.dart';
import 'package:plastic_punk/state/game/objects/education_center_tile.dart';
import 'package:plastic_punk/state/game/objects/game_object.dart';
import 'package:plastic_punk/state/game/objects/house_tile.dart';
import 'package:plastic_punk/state/game/objects/onboarding_tutorial_tile.dart';
import 'package:plastic_punk/state/game/objects/placement_tile.dart';
import 'package:plastic_punk/state/game/objects/plastics_recycling_tile.dart';
import 'package:plastic_punk/state/game/objects/research_centre_tile.dart';
import 'package:plastic_punk/state/game/objects/selected_tile.dart';
import 'package:plastic_punk/state/game/objects/town_hall.dart';
import 'package:plastic_punk/state/game/objects/tracks_tile.dart';
import 'package:plastic_punk/state/game/objects/water_placement_tile.dart';
import 'package:plastic_punk/state/game/resources/resource.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/state/game/snackbars/snackbar.dart';
import 'package:plastic_punk/state/game/snackbars/snackbar_state.dart';
import 'package:plastic_punk/state/game/snackbars/snackbars.dart';
import 'package:plastic_punk/utils/constants/layers.dart';
import 'package:plastic_punk/utils/constants/objects.dart';
import 'package:plastic_punk/utils/constants/priorities.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/constants/tiles.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/math/flood_fill.dart';
import 'package:plastic_punk/utils/math/math.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state.g.dart';
part 'game_state_achievement.dart';
part 'game_state_animations.dart';
part 'game_state_building.dart';
part 'game_state_camera.dart';
part 'game_state_cleanup.dart';
part 'game_state_data_access.dart';
part 'game_state_diplomacy.dart';
part 'game_state_event.dart';
part 'game_state_message.dart';
part 'game_state_object.dart';
part 'game_state_pollution.dart';
part 'game_state_resource.dart';
part 'game_state_save.dart';
part 'game_state_score.dart';
part 'game_state_settings.dart';
part 'game_state_snackbar.dart';
part 'game_state_technology.dart';
part 'game_state_tooltips.dart';
part 'game_state_transport.dart';

@riverpod
class GameState extends _$GameState {
  late TiledComponent _mapComponent;
  late FlameGame _game;
  late Locale _locale;
  late String _flagCode;
  late Level _level;
  late TilePosition _start;
  double _startZoom = GameStateCamera._minZoom;

  Locale get locale => _locale;
  String get flagCode => _flagCode;
  Level get level => _level;
  TiledComponent get mapComponent => _mapComponent;
  CameraComponent get camera => _game.camera;
  List<GameObject> get objects => state.objects;
  Map<ResourceType, Resource> get resources => state.resources;
  Set<TechnologyType> get technologies => state.technologies;
  int get transportsState => state.transportsState;
  final _initialised = Completer<void>();

  @override
  GameStateData build() {
    return const GameStateData(
      initialised: false,
      objects: [],
      resources: {},
      availableResources: {},
      technologies: {},
      tilesToClean: {},
      score: GameScore.notStarted,
      transportsState: 0,
      gameSpeed: 1,
      useAutomaticCleanup: false,
    );
  }

  void initialize(FlameGame game, TiledComponent mapComponent, Locale locale, String flagCode, Level level) {
    Sfx.setup();
    Sfx.playBackground();

    _mapComponent = mapComponent;
    _game = game;
    _locale = locale;
    _flagCode = flagCode;
    _level = level;
    state = state.copyWith(
      objects: [],
      resources: {},
      availableResources: {},
      technologies: {},
      useAutomaticCleanup: false,
      buildingToBuild: null,
      tilesToClean: {},
      transportsState: 0,
      score: GameScore.notStarted,
    );
    updateGameSpeed(1);
    updateGameSpeedMultiplier(1);

    _initObjects();

    _initTechnologies();

    // disable tooltips
    ref.read(onboardingTooltipsProvider.notifier).setTooltipsEnabled(false);

    // show welcome message
    showMessage(level.introMessage);

    state = state.copyWith(initialised: true);
    if (!_initialised.isCompleted) _initialised.complete();
  }

  void dispose() {
    scheduleMicrotask(() {
      Sfx.stopBackground();
      Sfx.stopAllEffects();
      removeAllSnackbars();
    });
  }

  void refresh() {
    state = state.copyWith();
  }

  void update(double dt) {
    Sfx.resetEffects();
    for (final object in state.objects) {
      object.update(dt, this);
    }
    Sfx.playEffects();
    _checkTooltips();
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

    // try to open building info
    final isBuildingTap = _tapBuilding(tilePos);
    if (isBuildingTap) {
      event.handled = true;
      event.continuePropagation = false;
    }
  }
}

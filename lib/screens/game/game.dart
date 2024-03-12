import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/build.dart';
import 'package:plastic_punk/screens/game/overlay/diplomacy.dart';
import 'package:plastic_punk/screens/game/overlay/game_over.dart';
import 'package:plastic_punk/screens/game/overlay/hud.dart';
import 'package:plastic_punk/screens/game/overlay/message.dart';
import 'package:plastic_punk/screens/game/overlay/place.dart';
import 'package:plastic_punk/screens/game/overlay/research.dart';
import 'package:plastic_punk/screens/game/overlay/settings.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/math/math.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateProvider.notifier);

    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: GameWidget(
        game: TiledGame(state),
        overlayBuilderMap: {
          Hud.overlayId: (BuildContext context, TiledGame game) {
            return Hud(game: game);
          },
          BuildOverlay.overlayId: (BuildContext context, TiledGame game) {
            return BuildOverlay(game: game);
          },
          PlaceOverlay.overlayId: (BuildContext context, TiledGame game) {
            return PlaceOverlay(game: game);
          },
          ResearchOverlay.overlayId: (BuildContext context, TiledGame game) {
            return ResearchOverlay(game: game);
          },
          MessageOverlay.overlayId: (BuildContext context, TiledGame game) {
            return MessageOverlay(game: game);
          },
          DiplomacyOverlay.overlayId: (BuildContext context, TiledGame game) {
            return DiplomacyOverlay(game: game);
          },
          SettingsOverlay.overlayId: (BuildContext context, TiledGame game) {
            return SettingsOverlay(game: game);
          },
          GameOver.overlayId: (BuildContext context, TiledGame game) {
            return GameOver(game: game);
          },
        },
        initialActiveOverlays: const [Hud.overlayId],
      ),
    );
  }
}

class TiledGame extends FlameGame with ScaleDetector, ScrollDetector, TapCallbacks {
  late TiledComponent mapComponent;
  final GameState state;

  TiledGame(this.state) : super();

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(resolution: AppMath.viewportSize(canvasSize));
    camera.viewfinder
      ..zoom = 1
      ..anchor = Anchor.center
      ..position = Vector2(30 * AppSizes.tile.width, 15 * AppSizes.tile.height);

    mapComponent = await TiledComponent.load(
      'map_empty.tmx',
      Vector2(AppSizes.tile.width, AppSizes.tile.height),
      prefix: 'assets/tiles/custom/',
    );
    world.add(mapComponent);

    state.initialize(this, mapComponent);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (hasLayout) camera.viewport = FixedResolutionViewport(resolution: AppMath.viewportSize(canvasSize));
  }

  @override
  void update(double dt) {
    state.update(dt);
    super.update(dt);
  }

  // -- Tap logic --

  @override
  void onTapDown(
    TapDownEvent event,
  ) {
    event.continuePropagation = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    state.onTap(event);
  }

  // -- Zoom and drag logic --

  static const double _minZoom = 0.1;
  static const double _maxZoom = 2.0;

  double _startZoom = _minZoom;

  static const double _zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    camera.viewfinder.zoom += info.scrollDelta.global.y.sign * _zoomPerScrollUnit;
    _checkScaleBorders();
    _checkDragBorders();
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    if (currentScale.isIdentity()) {
      _processDrag(info);
    } else {
      _processScale(info, currentScale);
    }
  }

  void _processDrag(ScaleUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 / _startZoom;
    final currentPosition = camera.viewfinder.position;
    final worldRect = camera.visibleWorldRect;
    final mapSize = Offset(mapComponent.width, mapComponent.height);

    Vector2 newCameraPosition = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );

    double xTranslate = 0.0;
    double yTranslate = 0.0;

    (xTranslate, yTranslate) = _translateDragBorders(worldRect, mapSize);

    if (xTranslate != 0.0 || yTranslate != 0.0) {
      newCameraPosition = newCameraPosition.translated(xTranslate, yTranslate);
    }

    camera.viewfinder.position = newCameraPosition;
    _checkScaleBorders();
    _checkDragBorders();
  }

  void _processScale(ScaleUpdateInfo info, Vector2 currentScale) {
    final newZoom = _startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
    _checkScaleBorders();
    _checkDragBorders();
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _checkScaleBorders();
    _checkDragBorders();
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;

    final currentPosition = camera.viewfinder.position;

    final mapSize = Offset(mapComponent.width, mapComponent.height);

    double xTranslate = 0.0;
    double yTranslate = 0.0;

    (xTranslate, yTranslate) = _translateDragBorders(worldRect, mapSize);

    if (xTranslate == 0.0 && yTranslate == 0.0) return;

    camera.viewfinder.position = currentPosition.translated(xTranslate, yTranslate);
  }

  (double, double) _translateDragBorders(final Rect worldRect, final Offset mapSize) {
    double xTranslate = 0.0;
    double yTranslate = 0.0;

    if (worldRect.topLeft.dx < -AppSizes.tile.width * 2.0) {
      xTranslate = -worldRect.topLeft.dx - AppSizes.tile.width * 2.0;
    } else if (worldRect.bottomRight.dx > mapSize.dx + AppSizes.tile.width * 2.0) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx + AppSizes.tile.width * 2.0;
    }

    if (worldRect.topLeft.dy < -AppSizes.tile.height * 2.0) {
      yTranslate = -worldRect.topLeft.dy - AppSizes.tile.height * 2.0;
    } else if (worldRect.bottomRight.dy > mapSize.dy + AppSizes.tile.height * 2.0) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy + AppSizes.tile.height * 2.0;
    }

    return (xTranslate, yTranslate);
  }
}

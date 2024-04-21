import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/achievement.dart';
import 'package:plastic_punk/screens/game/overlay/build.dart';
import 'package:plastic_punk/screens/game/overlay/building_info.dart';
import 'package:plastic_punk/screens/game/overlay/diplomacy.dart';
import 'package:plastic_punk/screens/game/overlay/game_over.dart';
import 'package:plastic_punk/screens/game/overlay/hud.dart';
import 'package:plastic_punk/screens/game/overlay/loading.dart';
import 'package:plastic_punk/screens/game/overlay/message.dart';
import 'package:plastic_punk/screens/game/overlay/place.dart';
import 'package:plastic_punk/screens/game/overlay/research.dart';
import 'package:plastic_punk/screens/game/overlay/settings.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/loading_widget.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/state/game/sfx/sfx.dart';
import 'package:plastic_punk/state/game/snackbars/snackbar_wrapper.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/math/math.dart';

class GameScreen extends ConsumerStatefulWidget {
  final Level level;
  final String? loadSlot;

  const GameScreen({super.key, required this.level, this.loadSlot});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.loadSlot != null) {
        ref.read(gameStateProvider.notifier).loadGame(widget.loadSlot!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameStateProvider.notifier);
    final flagCode = ref.read(userServiceProvider).userData.flag;

    return Scaffold(
      body: GameSnackbarWrapper(
        child: SafeArea(
          top: false,
          bottom: false,
          left: false,
          right: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: GameWidget(
                  game: TiledGame(state, Localizations.localeOf(context), widget.level, flagCode),
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
                    BuildingInfoOverlay.overlayId: (BuildContext context, TiledGame game) {
                      return BuildingInfoOverlay(game: game);
                    },
                    LoadingOverlay.overlayId: (BuildContext context, TiledGame game) {
                      return LoadingOverlay(game: game);
                    },
                    AchievementOverlay.overlayId: (BuildContext context, TiledGame game) {
                      return AchievementOverlay(game: game);
                    },
                  },
                  initialActiveOverlays: const [Hud.overlayId],
                ),
              ),
              Positioned.fill(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(gameStateProvider);
                    if (!state.initialised) return Center(child: child);
                    return const IgnorePointer();
                  },
                  child: const LoadingWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TiledGame extends FlameGame with ScaleDetector, ScrollDetector, TapCallbacks {
  late TiledComponent mapComponent;
  final GameState state;
  final Locale locale;
  final String flag;
  final Level level;

  TiledGame(this.state, this.locale, this.level, this.flag) : super();

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAllFromPattern(
      RegExp(
        // r'\.(png|jpg|jpeg|svg|gif|webp|bmp|wbmp)$',
        r'^(?!.*flags).*\.(png|jpg|jpeg|svg|gif|webp|bmp|wbmp)$',
        caseSensitive: false,
      ),
    );

    final flagFilename = 'flags/${flag.substring(0, 2).toUpperCase()}.png';
    await Flame.images.load(flagFilename);

    await FlameAudio.audioCache.loadAll(['background.mp3', ...SfxLoop.values.map((e) => e.path)]);

    mapComponent = await TiledComponent.load(
      level.map,
      Vector2(AppSizes.tile.width, AppSizes.tile.height),
      prefix: 'assets/tiles/custom/',
    );

    camera.viewport = FixedResolutionViewport(resolution: AppMath.viewportSize(canvasSize));
    camera.viewfinder
      ..zoom = 1
      ..anchor = Anchor.center
      ..position = Vector2(
        mapComponent.tileMap.map.width / 2 * AppSizes.tile.width,
        mapComponent.tileMap.map.height / 2 * AppSizes.tile.height,
      );

    world.add(mapComponent);

    state.initialize(this, mapComponent, locale, flag, level);
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

  @override
  void onDispose() {
    state.dispose();
    super.onDispose();
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

  @override
  void onScroll(PointerScrollInfo info) {
    state.onScroll(info);
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    state.onScaleStart(info);
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    state.onScaleUpdate(info);
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    state.onScaleEnd(info);
  }
}

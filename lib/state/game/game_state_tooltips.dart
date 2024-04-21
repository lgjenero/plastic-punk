// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateTooltips on GameState {
  void _checkTooltips() {
    final enabledTooltips = ref.read(onboardingTooltipsProvider).enableTooltips;
    if (!enabledTooltips) return;

    final tryShowGroundCleanup =
        !ref.read(userServiceProvider).userData.onboardingTooltipsShown.contains(OnboardingTooltip.groundCleanup);
    if (tryShowGroundCleanup) {
      scheduleMicrotask(() {
        final alreadyShown =
            objects.whereType<OnboardingTutorialTile>().any((e) => e.tooltip == OnboardingTooltip.groundCleanup);
        if (alreadyShown) return;

        final tilePosition = objects
            .whereType<BuildingCleaningTile>()
            .where((e) => e.constructed && !e.cleansWater)
            .firstOrNull
            ?.tilePosition;
        if (tilePosition == null) return;

        final tile = FloodFiller(
          _mapComponent,
          AppLayers.terrain,
          AppTiles.groundPollutedTiles,
          {...AppTiles.grassTiles, ...AppTiles.forestTiles, ...AppTiles.buildingTiles},
          state.objects.whereType<CleanupTile>().map((e) => e.tilePosition).toSet(),
        ).getNextPoint(tilePosition);

        if (tile == null) return;

        final tooltipTile = OnboardingTutorialTile(
          tooltip: OnboardingTooltip.groundCleanup,
          tilePosition: tile,
          isPaused: false,
        );

        add(tooltipTile);
      });
      return;
    }

    final tryShowWaterCleanup =
        !ref.read(userServiceProvider).userData.onboardingTooltipsShown.contains(OnboardingTooltip.waterCleanup);
    if (tryShowWaterCleanup) {
      scheduleMicrotask(() {
        final alreadyShown =
            objects.whereType<OnboardingTutorialTile>().any((e) => e.tooltip == OnboardingTooltip.waterCleanup);
        if (alreadyShown) return;

        final tilePosition = objects
            .whereType<BuildingCleaningTile>()
            .where((e) => e.constructed && e.cleansWater)
            .firstOrNull
            ?.tilePosition;
        if (tilePosition == null) return;

        final tile = FloodFiller(
          _mapComponent,
          AppLayers.terrain,
          AppTiles.waterPollutedTiles,
          {...AppTiles.waterTiles, AppTiles.waterCleanup},
          state.objects.whereType<CleanupTile>().map((e) => e.tilePosition).toSet(),
        ).getNextPoint(tilePosition);

        if (tile == null) return;

        final tooltipTile = OnboardingTutorialTile(
          tooltip: OnboardingTooltip.waterCleanup,
          tilePosition: tile,
          isPaused: false,
        );

        add(tooltipTile);
      });
      return;
    }
  }

  void removeTooltips(OnboardingTooltip tooltip) {
    final tooltipTiles = objects.whereType<OnboardingTutorialTile>();
    for (final tooltipTile in [...tooltipTiles]) {
      final tile = mapComponent.tileMap.getTileData(
        layerId: AppLayers.template,
        x: tooltipTile.tilePosition.x,
        y: tooltipTile.tilePosition.y,
      );
      final isWater = AppTiles.waterTiles.contains(tile?.tile);

      if (tooltip == OnboardingTooltip.groundCleanup && !isWater) {
        tooltipTile.remove(this);
      } else if (tooltip == OnboardingTooltip.waterCleanup && isWater) {
        tooltipTile.remove(this);
      }
    }
    ref.read(userServiceProvider.notifier).setOnboardingTooltipShown(tooltip);
  }
}

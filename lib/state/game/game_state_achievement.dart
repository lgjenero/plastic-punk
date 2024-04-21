// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateAchievement on GameState {
  void showAchievement(AchievementNode achievement) {
    final alreadyAchieved = ref.read(userServiceProvider).userData.achievements.contains(achievement.id);
    if (alreadyAchieved) return;

    state = state.copyWith(achievement: achievement);
    _game.overlays.add(AchievementOverlay.overlayId);
    ref.read(userServiceProvider.notifier).addAchievement(achievement.id);
  }

  void hideAchievement() {
    state = state.copyWith(achievement: null);
    _game.overlays.remove(AchievementOverlay.overlayId);
  }
}

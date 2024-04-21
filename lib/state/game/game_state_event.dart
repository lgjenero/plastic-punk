// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateEvent on GameState {
  void onEvent(Event event) {
    if (event.tag == EventTag.buildingBuilt) _checkPlacementTiles();

    final eventData = Events.list.firstWhereOrNull((e) => e == event);
    if (eventData == null) return;

    final achievement = eventData.achievement;
    if (achievement != null) showAchievement(achievement);

    final message = eventData.message;
    if (message != null) showMessage(message);
  }
}

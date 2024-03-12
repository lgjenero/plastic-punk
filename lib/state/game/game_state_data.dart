// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateDataAccess on GameState {
  List<GameObject> get objects => state.objects;
  Map<ResourceType, Resource> get resources => state.resources;
  Map<ResourceType, Resource> get availableResources => state.availableResources;
  Set<TechnologyType> get technologies => state.technologies;
  BuildingNode? get buildingToBuild => state.buildingToBuild;
  Set<TilePosition> get tilesToClean => state.tilesToClean;
  Message? get message => state.message;
}

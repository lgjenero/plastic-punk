// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateResource on GameState {
  void addResource(Resource resource) {
    final resources = {...state.resources};
    final availableResources = {...state.availableResources};
    final existingResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
    final existingAvailableResource = availableResources[resource.type] ?? Resource(type: resource.type, amount: 0);
    final updatedResource = existingResource + resource;
    final updatedAvailableResource = existingAvailableResource + resource;
    resources[resource.type] = updatedResource;
    availableResources[resource.type] = updatedAvailableResource;
    state = state.copyWith(resources: resources, availableResources: availableResources);
  }

  void removeResource(Resource resource) {
    final resources = {...state.resources};
    final availableResources = {...state.availableResources};
    final existingResource = resources[resource.type] ?? Resource(type: resource.type, amount: 0);
    final existingAvailableResource = availableResources[resource.type] ?? Resource(type: resource.type, amount: 0);
    final updatedResource = existingResource - resource;
    final updatedAvailableResource = existingAvailableResource - resource;

    if (updatedResource.amount < 0) {
      // TODO: thisnk about what to do here? Game over? Population decline?
      // throw Exception('Resource amount cannot be negative');
    }

    if (updatedAvailableResource.amount < 0) {
      // TODO: thisnk about what to do here? Game over? Population decline?
      // throw Exception('Resource amount cannot be negative');
    }

    resources[resource.type] = updatedResource;
    availableResources[resource.type] = updatedAvailableResource;
    state = state.copyWith(resources: resources, availableResources: availableResources);
  }
}

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateTechnology on GameState {
  void addTechnology(TechnologyType technology) {
    final technologies = {...state.technologies};
    technologies.add(technology);
    state = state.copyWith(technologies: technologies);
  }

  bool hasTechnology(TechnologyType technology) {
    return technologies.contains(technology);
  }

  void removeTechnology(TechnologyType technology) {
    final technologies = {...state.technologies};
    technologies.remove(technology);
    state = state.copyWith(technologies: technologies);
  }

  void researchTechnology(TechnologyNode technologyNode) {
    final technology = technologyNode.type;
    if (hasTechnology(technology)) {
      throw Exception('Technology already researched');
    }

    final researchCentres = objects.whereType<ResearchCentreTile>();
    final researchCentre = researchCentres.firstWhereOrNull((e) => !e.isResearching);
    if (researchCentre == null) {
      throw Exception('No research centre to research technology');
    }

    researchCentre.startResearch(technology);
  }
}

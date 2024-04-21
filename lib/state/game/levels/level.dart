import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/messages/message.dart';

class Level {
  final int level;
  final String name;
  final String description;
  final String map;
  final Message introMessage;

  final List<int> enabledBuildings;
  final List<TechnologyType> enabledTechnologies;

  final List<int> requiredBuildings;
  final List<TechnologyType> requiredTechnologies;
  final bool requiredCleanup;
  final List<TechnologyType> existingTechnologies;

  const Level({
    required this.level,
    required this.name,
    required this.description,
    required this.map,
    required this.introMessage,
    required this.enabledBuildings,
    required this.enabledTechnologies,
    required this.requiredBuildings,
    required this.requiredTechnologies,
    required this.requiredCleanup,
    required this.existingTechnologies,
  });
}

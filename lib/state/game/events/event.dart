import 'package:flutter/foundation.dart';
import 'package:plastic_punk/state/game/logic/achievement_tree.dart';
import 'package:plastic_punk/state/game/messages/message.dart';

enum EventTag {
  buildingBuilt,
  technologyResearched,
  groundTilesCleaned,
  waterTilesCleaned,
  diplomacyExecuted,
  levelCompleted,
}

class Event {
  final EventTag tag;
  final Map<String, dynamic> data;

  final Message? message;
  final AchievementNode? achievement;

  Event({
    required this.tag,
    required this.data,
    this.message,
    this.achievement,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event && other.tag == tag && mapEquals(other.data, data);
  }

  @override
  int get hashCode => tag.hashCode ^ data.hashCode;
}

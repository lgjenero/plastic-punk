import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';
part 'resource.g.dart';

enum ResourceType {
  material('assets/images/app_assets/icons/material_icon.png', 'Materials',
      'These are the materials you have gathered. You need them to build structures.'),
  water('assets/images/app_assets/icons/water_icon.png', 'Water',
      'This is yourwater supply. It is for your population and food production.'),
  food('assets/images/app_assets/icons/food_icon.png', 'Food',
      'This is your food supply. It is required to maintain your population.'),
  population('assets/images/app_assets/icons/population_icon.png', 'Population',
      'This is your population. It is required to sustain facilites.'),
  electricity('assets/images/app_assets/icons/electricity_icon.png', 'Electricity',
      'This is your electricity supply. It is required to power your structures.'),
  impact('assets/images/app_assets/icons/impact_icon.png', 'Ecologial Impact',
      'This is your ecologial imapct. The lower it is the more pollution your community is producing and all activities take more time.'),
  ;

  final String icon;
  final String label;
  final String description;
  const ResourceType(this.icon, this.label, this.description);

  static const onlyAvailableAmount = [
    material,
  ];

  static const noAvailableAmount = [
    material,
    impact,
  ];
}

@freezed
class Resource with _$Resource {
  const factory Resource({
    required ResourceType type,
    required int amount,
  }) = _Resource;

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
}

extension ResourceExtension on Resource {
  Resource operator +(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot add resources of different types');
    }
    return Resource(type: type, amount: amount + other.amount);
  }

  Resource operator -(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot subtract resources of different types');
    }
    return Resource(type: type, amount: amount - other.amount);
  }

  bool operator >(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot compare resources of different types');
    }
    return amount > other.amount;
  }

  bool operator <(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot compare resources of different types');
    }
    return amount < other.amount;
  }

  bool operator >=(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot compare resources of different types');
    }
    return amount >= other.amount;
  }

  bool operator <=(Resource other) {
    if (type != other.type) {
      throw ArgumentError('Cannot compare resources of different types');
    }
    return amount <= other.amount;
  }
}

class ResourceProduction {
  final Resource resource;
  final double productionTime;

  ResourceProduction({required this.resource, required this.productionTime});
}

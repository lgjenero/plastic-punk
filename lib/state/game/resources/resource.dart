enum ResourceType {
  material('assets/images/app_assets/icons/material_icon.png'),
  water('assets/images/app_assets/icons/water_icon.png'),
  food('assets/images/app_assets/icons/food_icon.png'),
  population('assets/images/app_assets/icons/population_icon.png'),
  electricity('assets/images/app_assets/icons/electricity_icon.png');

  final String icon;
  const ResourceType(this.icon);
}

class Resource {
  final ResourceType type;
  final int amount;

  Resource({required this.type, required this.amount});

  Resource copyWith({ResourceType? type, int? amount}) {
    return Resource(
      type: type ?? this.type,
      amount: amount ?? this.amount,
    );
  }

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

  @override
  String toString() {
    return 'Resource{type: $type, amount: $amount}';
  }
}

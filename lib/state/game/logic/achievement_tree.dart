class AchievementNode {
  final String id;
  final String name;
  final String imagePath;
  final String description;

  AchievementNode({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
  });
}

class AchievementTree {
  static List<AchievementNode> nodes = [
    AchievementNode(
      id: '1',
      name: 'Establish leadership',
      imagePath: 'assets/images/app_assets/achievements/town_hall.png',
      description:
          'Government policies have a big impact on enviromental protection so if you care about the environment you should participate in the poilitical process.',
    ),
    AchievementNode(
      id: '2',
      name: 'Sustainable food production',
      imagePath: 'assets/images/app_assets/achievements/food.png',
      description:
          'Producing food in a sustainable way and organic way is not just good for the enviroment but for everyonw involved in the process.',
    ),
    AchievementNode(
      id: '3',
      name: 'Sustainable housing',
      imagePath: 'assets/images/app_assets/achievements/housing.png',
      description:
          'Sustainable housing reduces the impact on the enviroment and health, but can save you money in the long run.',
    ),
    AchievementNode(
      id: '4',
      name: 'Research',
      imagePath: 'assets/images/app_assets/achievements/research.png',
      description:
          'Research is key to solving the enviromental problems we face today. It is important to invest in research and development.',
    ),
    AchievementNode(
      id: '5',
      name: 'Reduce, reuse, recycle',
      imagePath: 'assets/images/app_assets/achievements/recycle.png',
      description: 'We need to reduce the amount of waste we produce, reuse what we can, and recycle what we can\'t.',
    ),
    AchievementNode(
      id: '6',
      name: 'Ensure clean drinking water',
      imagePath: 'assets/images/app_assets/achievements/water_treatment.png',
      description:
          'Clean drinking water is essential for life. Right now, millions of people do not have access to clean drinking water.',
    ),
    AchievementNode(
      id: '7',
      name: 'Clean our oceans',
      imagePath: 'assets/images/app_assets/achievements/water_cleanup.png',
      description:
          'Our oceans are in trouble. We need to clean up the pollution and protect the marine life that lives in the oceans.',
    ),
    AchievementNode(
      id: '8',
      name: 'Change minds',
      imagePath: 'assets/images/app_assets/achievements/diplomacy.png',
      description:
          'We need to change the way we think about the enviroment. We need to change our habits and our way of life to protect the enviroment for future generations.',
    ),
    AchievementNode(
      id: '9',
      name: 'Clean the workd',
      imagePath: 'assets/images/app_assets/achievements/finish.png',
      description:
          'We need to work together to clean up the enviroment. We need to take action now to protect the enviroment for future generations.',
    ),
  ];
}

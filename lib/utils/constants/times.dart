class AppTimes {
  // game speed
  static double gameSpeed = 1;

  // intro
  static const int introSlideDurationMs = 7000;
  static const int introSlideTransitionDurationMs = 1000;

  // general
  static double get cleanupDuration => 5 / gameSpeed;
  static double get buildingConstruction => 10 / gameSpeed;

  // town hall
  static double get townHallProductionDuration => 10 / gameSpeed;
  static double get townHallCleanupDuration => 6 / gameSpeed;

  // plastics recycling
  static double get plasticsRecyclingDuration => 10 / gameSpeed;
  static double get plasticsRecyclingCleanupDuration => 6 / gameSpeed;

  // plastics burning
  static double get plasticsBurningCleanupDuration => 6 / gameSpeed;

  // research centre
  static double get researchCentreResearchDuration => 10 / gameSpeed;

  // water cleanup
  static double get waterCleanupDuration => 6 / gameSpeed;

  // plastics factory
  static double get plasticsFactoryProductionTime => 6 / gameSpeed;

  // diplomacy
  static double get diplomacyDuration => 6 / gameSpeed;
}

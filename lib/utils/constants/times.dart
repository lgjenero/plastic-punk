class AppTimes {
  // game speed
  static double gameSpeed = 1;

  // game speed mutliplier
  static double gameSpeedMultiplier = 1;

  // game speed with multiplier
  static double get _gameSpeedWithMultiplier => gameSpeed * gameSpeedMultiplier;

  // intro
  static const int introSlideDurationMs = 7000;
  static const int introSlideTransitionDurationMs = 1000;

  // general
  static double get cleanupDuration => 5 / _gameSpeedWithMultiplier;
  static double get buildingConstruction => 10 / _gameSpeedWithMultiplier;

  // town hall
  static double get townHallProductionDuration => 10 / _gameSpeedWithMultiplier;
  static double get townHallCleanupDuration => 6 / _gameSpeedWithMultiplier;

  // plastics recycling
  static double get plasticsRecyclingDuration => 10 / _gameSpeedWithMultiplier;
  static double get plasticsRecyclingCleanupDuration => 6 / _gameSpeedWithMultiplier;

  // plastics burning
  static double get plasticsBurningCleanupDuration => 6 / _gameSpeedWithMultiplier;

  // research centre
  static double get researchCentreResearchDuration => 10 / _gameSpeedWithMultiplier;

  // water cleanup
  static double get waterCleanupDuration => 6 / _gameSpeedWithMultiplier;

  // plastics factory
  static double get plasticsFactoryProductionTime => 6 / gameSpeed;

  // bad housing
  static double get badHousingProductionTime => 8 / gameSpeed;

  // bad housing
  static double get roadProductionTime => 16 / gameSpeed;

  // bad town hall
  static double get badTownHallProductionTime => 10 / gameSpeed;

  // diplomacy
  static double get diplomacyDuration => 128 / _gameSpeedWithMultiplier;
}

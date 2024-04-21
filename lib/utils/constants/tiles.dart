class AppTiles {
  // none
  static const int none = -1;

  // grass
  static const int grassMin = 2;
  static const int grassSquareMax = 5;
  static const int grassMax = 17;

  static final Set<int> grassTiles = {for (var i = grassMin; i <= grassMax; i++) i};
  static final Set<int> grassSquareTiles = {for (var i = grassMin; i <= grassSquareMax; i++) i};
  static final Set<int> grassShoreTiles = {for (var i = grassSquareMax + 1; i <= grassMax; i++) i};

  // forest
  static const int forestMin = 101;
  static const int forestMax = 103;
  static final Set<int> forestTiles = {for (var i = forestMin; i <= forestMax; i++) i};

  // ground
  static final Set<int> groundTiles = {...grassTiles, ...forestTiles};

  // water
  static const int waterTile = 202;
  static final Set<int> waterTiles = {waterTile};

  // buildings
  static const int buildingsMin = 301;
  static const int educationCentre = 301;
  static const int house = 302;
  static const int park = 303;
  static const int plasticRecycling = 304;
  static const int plasticsEnergy = 305;
  static const int researchCentre = 306;
  static const int solarPanels = 307;
  static const int waterCleanup = 308;
  static const int waterTreatment = 309;
  static const int townHall = 310;
  static const int garden = 311;
  static const int badHousing = 312;
  static const int plasticsFactory = 313;
  static const int badTownHall = 314;
  static const int buildingGround = 399;
  static const int buildingsMax = 399;
  static final Set<int> buildingTiles = {
    ...{for (var i = educationCentre; i <= plasticsFactory; i++) i},
    buildingGround,
    ...transportationTiles,
    ...pollutedTransportationTiles,
  };
  static final Set<int> playerBuildingTiles = buildingTiles.where((e) => !enemyBuildingTiles.contains(e)).toSet();
  static final Set<int> enemyBuildingTiles = {badHousing, plasticsFactory, badTownHall, ...pollutedTransportationTiles};

  // pollution
  static const int pollutionMin = 401;
  static const int pollutionMax = 417;
  static const int groundPolluted = 401;
  static const int waterPolluted = 404;
  static final Set<int> groundPollutedTiles = {groundPolluted, ...List.generate(12, (index) => 406 + index).toSet()};
  static final Set<int> waterPollutedTiles = {waterPolluted};
  static final Set<int> pollutionTiles = {...groundPollutedTiles, ...waterPollutedTiles};
  static tileToPollution(int tileId) {
    if (grassSquareTiles.contains(tileId)) return groundPolluted;
    if (forestTiles.contains(tileId)) return groundPolluted;
    if (waterTiles.contains(tileId)) return waterPolluted;
    if (grassShoreTiles.contains(tileId)) return 400 + tileId;

    throw Exception('Tile $tileId cannot be converted to pollution tile.');
  }

  // building placement
  static const int buildingPlacement = 501;
  static const int buildingPlacementInvalid = 502;

  // transportation
  static const int transportationMin = 601;
  static const int transportationMax = 611;
  static final Set<int> transportationTiles = {for (var i = transportationMin; i <= transportationMax; i++) i};

  static const int tracksUpDown = 602;
  static const int tracksLeftRight = 601;
  static const int tracksUpRight = 605;
  static const int tracksUpLeft = 606;
  static const int tracksDownRight = 604;
  static const int tracksDownLeft = 607;
  static const int tracksLeftUpRight = 611;
  static const int tracksDownLeftUp = 608;
  static const int tracksRightDownLeft = 609;
  static const int tracksDownRightUp = 610;
  static const int tracksCross = 603;

  // polluted transportation
  static const int pollutedTransportationMin = 701;
  static const int pollutedTransportationMax = 711;
  static final Set<int> pollutedTransportationTiles = {
    for (var i = pollutedTransportationMin; i <= pollutedTransportationMax; i++) i
  };

  static const int roadUpDown = 702;
  static const int roadLeftRight = 701;
  static const int roadUpRight = 705;
  static const int roadUpLeft = 706;
  static const int roadDownRight = 704;
  static const int roadDownLeft = 707;
  static const int roadLeftUpRight = 711;
  static const int roadDownLeftUp = 708;
  static const int roadRightDownLeft = 709;
  static const int roadDownRightUp = 710;
  static const int roadCross = 703;
}

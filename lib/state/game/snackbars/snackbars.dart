import 'package:collection/collection.dart';
import 'package:plastic_punk/state/game/logic/buildings_tree.dart';
import 'package:plastic_punk/state/game/logic/technology_tree.dart';
import 'package:plastic_punk/state/game/snackbars/snackbar.dart';

abstract class GameSnackbars {
  static GameSnackbar buildingCompleted(int buildingId, {void Function()? onPressed}) {
    final node = BuildingTree.nodes.firstWhereOrNull((node) => node.id == buildingId);
    if (node == null) throw Exception('Building not found');

    return GameSnackbar(
      message: '${node.name} completed',
      icon: node.imageAsset,
      onPressed: onPressed,
    );
  }

  static GameSnackbar researchCompleted(TechnologyType technologyType) {
    final node = TechnologyTree.nodes.firstWhereOrNull((node) => node.type == technologyType);
    if (node == null) throw Exception('Technology not found');

    return GameSnackbar(
      message: '${node.name} research completed',
      icon: node.imageAsset,
    );
  }

  static GameSnackbar gameSaved() {
    return const GameSnackbar(
      message: 'Game saved',
      icon: 'assets/images/app_assets/icons/check.png',
    );
  }

  static GameSnackbar errorSavingGame() {
    return const GameSnackbar(
      message: 'Game not saved. Error occured',
      icon: 'assets/images/app_assets/icons/cross.png',
    );
  }

  static GameSnackbar gameLoaded() {
    return const GameSnackbar(
      message: 'Game loaded',
      icon: 'assets/images/app_assets/icons/check.png',
    );
  }

  static GameSnackbar errorLoadingGame() {
    return const GameSnackbar(
      message: 'Game not loaded. Error occured',
      icon: 'assets/images/app_assets/icons/cross.png',
    );
  }
}

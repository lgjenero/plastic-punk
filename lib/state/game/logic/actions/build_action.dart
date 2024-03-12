import 'package:plastic_punk/state/game/logic/actions/action.dart';
import 'package:plastic_punk/state/game/objects/building_tile.dart';

class BuildAction extends Action {
  final BuildingTile building;

  BuildAction({required this.building, required super.duration, required super.isRepeatable})
      : super(gameObject: building);

  @override
  // TODO: implement isCompleted
  bool get isCompleted => throw UnimplementedError();
}

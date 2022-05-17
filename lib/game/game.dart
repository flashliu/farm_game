import 'package:farm/game/components/floor_manager.dart';
import 'package:farm/game/components/game_map.dart';
import 'package:flame/game.dart';

class FarmGame extends FlameGame
    with HasDraggables, HasHoverables, HasCollisionDetection {
  late Vector2 startPositon;
  late GameMap gameMap;
  late FloorManager floorManager;
  @override
  Future<void>? onLoad() async {
    gameMap = GameMap();
    floorManager = FloorManager();
    await addAll([
      gameMap,
      floorManager,
    ]);
    camera.snapTo(Vector2(580, 380));
  }

  // @override
  // bool get debugMode => true;

  @override
  void onDragStart(pointerId, info) {
    startPositon = info.eventPosition.viewport..add(camera.position);
    super.onDragStart(pointerId, info);
  }

  @override
  void onDragUpdate(pointerId, info) {
    final value = info.eventPosition.viewport.clone()..sub(startPositon);
    final leftLimit = value.x + gameMap.position.x >= 0;
    final topLimit = value.y + gameMap.position.y >= 0;
    final rightLimit =
        gameMap.size.x + gameMap.position.x - size.x + value.x <= 0;
    final bottomLimit =
        gameMap.size.y + gameMap.position.y - size.y + value.y <= 0;

    if (leftLimit || topLimit || rightLimit || bottomLimit) {
      startPositon = info.eventPosition.viewport..add(camera.position);
      return;
    }
    camera.snapTo(-value);

    super.onDragUpdate(pointerId, info);
  }
}

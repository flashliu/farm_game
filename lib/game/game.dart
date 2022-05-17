import 'dart:io';

import 'package:farm/game/components/floor_manager.dart';
import 'package:farm/game/components/game_map.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class FarmGame extends FlameGame
    with HasDraggables, HasHoverables, HasCollisionDetection {
  late Vector2 startPositon;
  late GameMap gameMap;
  late FloorManager floorManager;
  @override
  Future<void>? onLoad() async {
    await Flame.images.load('sprites.png');
    gameMap = GameMap();
    floorManager = FloorManager();
    await addAll([
      gameMap,
      floorManager,
    ]);
    initialCamara();
  }

  initialCamara() {
    if (Platform.isIOS || Platform.isAndroid) {
      camera.zoom = 0.7;
      camera.snapTo(Vector2(450, 340));
    } else {
      camera.snapTo(Vector2(520, 260));
    }
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

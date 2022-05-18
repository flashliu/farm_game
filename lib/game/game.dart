import 'dart:io';

import 'package:farm/game/components/floor_manager.dart';
import 'package:farm/game/components/game_map.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class FarmGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection {
  late Vector2 startPositon;
  late GameMap gameMap;
  late FloorManager floorManager;
  @override
  Future<void>? onLoad() async {
    await Flame.images.load('floors.png');
    await Flame.images.load('btns.png');
    gameMap = GameMap();
    floorManager = FloorManager();
    await addAll([
      gameMap,
      floorManager,
    ]);
    initialCamara();
  }

  initialCamara() {
    camera.speed = 500;
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
    startPositon = info.eventPosition.viewport + camera.position;
    super.onDragStart(pointerId, info);
  }

  @override
  void onDragUpdate(pointerId, info) {
    final value = startPositon - info.eventPosition.viewport;
    final min = Vector2.zero();
    final max = gameMap.size - canvasSize;
    value.clamp(min, max);
    if (value.x == min.x ||
        value.x == max.x ||
        value.y == min.y ||
        value.y == max.y) {
      startPositon = info.eventPosition.viewport + camera.position;
      return;
    }
    camera.snapTo(value);

    super.onDragUpdate(pointerId, info);
  }

  @override
  onTapUp(pointerId, info) {
    floorManager.stopEffect();
    super.onTapUp(pointerId, info);
  }
}

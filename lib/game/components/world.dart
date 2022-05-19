import 'package:farm/global.dart';
import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef, Tappable {
  late Vector2 startPositon;
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('background.jpg');
    size = sprite!.srcSize;
    position = Vector2.zero();
    return super.onLoad();
  }

  @override
  onTapUp(info) {
    Global.game.floorManager.resetCurrentFloor();
    Global.closeBootomSheet();
    return true;
  }
}

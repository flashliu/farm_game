import 'package:farm/game/components/floor_manager.dart';
import 'package:flame/components.dart';

class GameMap extends SpriteComponent with HasGameRef, Tappable {
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
    for (var element in parent!.children) {
      if (element is FloorManager) {
        element.stopColorEffect();
        element.resetSeedToast();
      }
    }
    return true;
  }
}

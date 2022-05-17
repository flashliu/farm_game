import 'package:flame/components.dart';

class GameMap extends SpriteComponent with HasGameRef, Draggable {
  late Vector2 startPositon;
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('background.jpg');
    size = sprite!.originalSize;
    position = Vector2.zero();
    return super.onLoad();
  }
}

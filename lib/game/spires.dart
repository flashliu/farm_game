import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';

class Sprites {
  static Sprite getSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('sprites.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }

  static final floorSize = Vector2(176, 94);

  static get disableFloor => Sprites.getSprite(179, 193, 176, 94);
  static get nomalFloor => Sprites.getSprite(357, 289, 176, 94);
}

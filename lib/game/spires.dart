import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';

class Sprites {
  static Sprite getSprite({
    required String assets,
    required double x,
    required double y,
    required double width,
    required double height,
  }) {
    return Sprite(
      Flame.images.fromCache(assets),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }

  static final floorSize = Vector2(176, 94);

  static Sprite getFloor(double x, double y) {
    return getSprite(
      assets: "floors.png",
      x: x,
      y: y,
      width: floorSize.x,
      height: floorSize.y,
    );
  }

  static Sprite getBtns(
    double x,
    double y,
    double width,
    double height,
  ) {
    return getSprite(
      assets: "btns.png",
      x: x,
      y: y,
      width: floorSize.x,
      height: floorSize.y,
    );
  }

  static Sprite get disableFloor => getFloor(179, 193);

  static Sprite get nomalFloor => getFloor(1, 366);

  static Sprite get shopBtn => getBtns(1, 237, 82, 89);

  static Sprite get expandIcon => getSprite(
        assets: "floors.png",
        x: 923,
        y: 599,
        width: 93,
        height: 92,
      );
}

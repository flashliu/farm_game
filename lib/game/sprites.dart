import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';

class Sprites {
  static Sprite getSprite(
    String assets, {
    required double x,
    required double y,
    required double w,
    required double h,
  }) {
    return Sprite(
      Flame.images.fromCache(assets),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(w, h),
    );
  }

  static final floorSize = Vector2(176, 94);

  static Sprite getFloor(double x, double y) {
    return getSprite(
      "floors.png",
      x: x,
      y: y,
      w: floorSize.x,
      h: floorSize.y,
    );
  }

  static Sprite get disableFloor => getFloor(179, 193);

  static Sprite get nomalFloor => getFloor(1, 366);

  static Sprite get shopBtn {
    return getSprite("btns.png", x: 1, y: 237, w: 82, h: 89);
  }

  static Sprite get expandIcon {
    return getSprite("floors.png", x: 923, y: 599, w: 93, h: 92);
  }

  static Sprite get seedTip {
    return getSprite("btns.png", x: 687, y: 338, w: 66, h: 73);
  }

  static Sprite get shop {
    return getSprite("btns.png", x: 1, y: 237, w: 82, h: 89);
  }

  static Sprite get store {
    return getSprite("btns.png", x: 437, y: 183, w: 83, h: 84);
  }

  static Sprite get seedRadish {
    return getSprite("seeds.png", x: 827, y: 996, w: 40, h: 23);
  }

  static Sprite get seed {
    return getSprite("floors.png", x: 0, y: 1029, w: 104, h: 50);
  }
}

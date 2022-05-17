import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum FloorState {
  hovered,
  nomal,
}

class Floor extends SpriteGroupComponent with Hoverable, GestureHitboxes {
  Floor({
    required Map<FloorState, Sprite>? sprites,
    required Vector2 position,
    required Vector2 size,
  }) : super(sprites: sprites, position: position, size: size);

  @override
  Future<void> onLoad() async {
    current = FloorState.nomal;
    final hitBox = PolygonHitbox([
      Vector2(0, size.y / 2),
      Vector2(size.x / 2, size.y),
      Vector2(size.x, size.y / 2),
      Vector2(size.x / 2, 0),
    ]);
    add(hitBox);
    return super.onLoad();
  }

  @override
  onHoverEnter(info) {
    current = FloorState.hovered;
    return true;
  }

  @override
  onHoverLeave(info) {
    current = FloorState.nomal;
    return true;
  }
}

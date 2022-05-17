import 'package:farm/game/spires.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum FloorState {
  nomal,
  disable,
}

class Floor extends SpriteGroupComponent with Hoverable, GestureHitboxes {
  bool hovered = false;

  Floor({
    FloorState current = FloorState.disable,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, current: current);

  @override
  Future<void> onLoad() async {
    sprites = {
      FloorState.nomal: Sprites.nomalFloor,
      FloorState.disable: Sprites.disableFloor,
    };
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
    hovered = true;
    return true;
  }

  @override
  onHoverLeave(info) {
    hovered = false;
    return true;
  }
}

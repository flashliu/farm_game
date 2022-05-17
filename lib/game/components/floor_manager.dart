import 'package:farm/game/components/floor.dart';
import 'package:flame/components.dart';

class FloorManager extends PositionComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    final normalFloor = await gameRef.loadSprite('floor.png');
    final hoverdFloor = await gameRef.loadSprite('floor_hover.png');
    final size = normalFloor.originalSize;
    const rows = 5;
    gameRef.camera.snapTo(Vector2(590, 300));
    addAll(
      List.generate(15, (i) {
        final curRow = (i / rows).floor();
        final curPosition = Vector2(
          i * size.x / 2 - curRow * size.x * 2 + curRow * 14,
          i * size.y / 2 - curRow * size.y * 3 - curRow * 7,
        );
        return Floor(
          sprites: {
            FloorState.nomal: normalFloor,
            FloorState.hovered: hoverdFloor
          },
          size: size,
          position: curPosition,
        );
      }),
    );
    position = gameRef.camera.position + Vector2(22, 220);
    angle = 0.002;
    return super.onLoad();
  }
}

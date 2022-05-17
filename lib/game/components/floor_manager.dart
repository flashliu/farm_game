import 'package:farm/game/components/floor.dart';
import 'package:farm/game/spires.dart';
import 'package:flame/components.dart';

class FloorManager extends PositionComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    final size = Sprites.floorSize / 1.12;
    const rows = 5;
    addAll(
      List.generate(15, (i) {
        final curRow = (i / rows).floor();
        final curCol = (i % rows).floor();

        final curPosition = Vector2(
          curRow * (size.x / 2 + 10) + curCol * (size.x / 2 + 10),
          curCol * (size.y / 2 + 5) - curRow * (size.y / 2 + 5),
        );
        return Floor(
          current: curRow != 0 ? FloorState.nomal : FloorState.disable,
          size: size,
          position: curPosition,
        );
      }),
    );
    angle = 0.003;
    position = gameRef.camera.position + Vector2(625, 520);
    return super.onLoad();
  }
}

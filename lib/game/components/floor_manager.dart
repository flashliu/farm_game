import 'package:farm/game/components/floor.dart';
import 'package:farm/game/spires.dart';
import 'package:flame/components.dart';

class FloorManager extends PositionComponent with HasGameRef, Tappable {
  void stopColorEffect() {
    for (var element in children) {
      if (element is Floor && element.colorEffect.isPaused == false) {
        element.stopColorEffect();
      }
    }
  }

  void resetSeedToast() {
    for (var element in children) {
      if (element is Floor &&
          element.current == FloorState.nomal &&
          element.colorEffect.isPaused) {
        element.resetSeedToast();
      }
    }
  }

  @override
  Future<void>? onLoad() async {
    final size = Sprites.floorSize / 1.4;
    const rows = 6;
    addAll(
      List.generate(24, (i) {
        final curRow = (i % rows).floor();
        final curCol = (i / rows).floor();

        final curPosition = Vector2(
          curRow * (size.x / 2 + 10) - curCol * (size.x / 2 + 10),
          curCol * (size.y / 2 + 5) + curRow * (size.y / 2 + 5),
        );
        return Floor(
          current: i <= 2 ? FloorState.nomal : FloorState.disable,
          size: size,
          position: curPosition,
          canExpand: i == 3,
          onTap: (floor) {
            stopColorEffect();
            if (floor.current == FloorState.nomal) {
              floor.startColorEffect();
              floor.removeSeedToast();
            }
            resetSeedToast();
          },
        );
      }),
    );
    position = gameRef.camera.position + Vector2(840, 416);
    return super.onLoad();
  }
}

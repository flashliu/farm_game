import 'package:farm/game/components/floor.dart';
import 'package:farm/game/spires.dart';
import 'package:flame/components.dart';

class FloorManager extends PositionComponent with HasGameRef, Tappable {
  Floor? currentFloor;
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
          current: i < 20 ? FloorType.nomal : FloorType.disable,
          size: size,
          position: curPosition,
          state: i == 20 ? FloorState.canExpand : FloorState.waitExpand,
          onTap: (floor) {
            if (floor.current == FloorType.nomal) {
              currentFloor = floor;
              if (currentFloor != null && currentFloor!.colorEffect.isPaused) {
                stopColorEffect();
                currentFloor?.startColorEffect();
                removeFloorTip();
              }
            }
          },
        );
      }),
    );
    position = gameRef.camera.position + Vector2(840, 416);
    return super.onLoad();
  }

  void stopColorEffect() {
    for (var element in children) {
      if (element is Floor && element.colorEffect.isPaused == false) {
        element.stopColorEffect();
      }
    }
  }

  void removeFloorTip() {
    for (var element in children) {
      if (element is Floor && element.current == FloorType.nomal) {
        element.removeFloorTip();
      }
    }
  }

  void addFloorTip() {
    for (var element in children) {
      if (element is Floor && element.current == FloorType.nomal) {
        element.addFloorTip();
      }
    }
  }
}

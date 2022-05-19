import 'package:farm/game/components/floor.dart';
import 'package:farm/game/sprites.dart';
import 'package:farm/global.dart';
import 'package:flame/components.dart';

class FloorManager extends PositionComponent with HasGameRef, Tappable {
  late List<Floor> floorList;
  Floor? _currentFloor;
  set currentFloor(Floor? v) {
    if (_currentFloor != null) {
      _currentFloor!.removeCheckedTip();
    }
    _currentFloor = v;
  }

  Floor? get currentFloor => _currentFloor;

  @override
  Future<void>? onLoad() async {
    final size = Sprites.floorSize / 1.4;
    const rows = 6;
    floorList = List.generate(24, (i) {
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
        state: i == 20 ? FloorState.canExpand : FloorState.canSeed,
        onTap: (floor) => currentFloor = floor,
      );
    });
    addAll(floorList);
    position = gameRef.camera.position + Vector2(840, 416);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (currentFloor != null) {
      currentFloor!.addCheckedTip();
      hideAllFloorTip();
      Global.showSeedList();
    } else {
      showAllFloorTip();
    }
    super.update(dt);
  }

  void hideAllFloorTip() {
    for (var element in children) {
      if (element is Floor) {
        element.showFloorTip = false;
      }
    }
  }

  void showAllFloorTip() {
    for (var element in children) {
      if (element is Floor) {
        element.showFloorTip = true;
      }
    }
  }

  void resetCurrentFloor() {
    if (currentFloor == null) return;
    currentFloor!.removeCheckedTip();
    currentFloor = null;
  }
}

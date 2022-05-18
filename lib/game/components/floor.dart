import 'package:farm/game/components/floor_manager.dart';
import 'package:farm/game/spires.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

enum FloorState {
  nomal,
  disable,
}

class Floor extends SpriteGroupComponent
    with Tappable, GestureHitboxes, HasGameRef {
  final effect = ColorEffect(
    const Color.fromARGB(255, 255, 225, 197),
    const Offset(0, 0.4),
    EffectController(
      duration: 1,
      reverseDuration: 1,
      infinite: true,
    ),
  );

  final bool canExpand;

  Floor({
    FloorState current = FloorState.disable,
    required Vector2 position,
    required Vector2 size,
    this.canExpand = false,
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
    add(effect);
    if (canExpand) {
      final expandIconSize = Sprites.expandIcon.srcSize / 1.8;
      add(
        SpriteComponent(
          sprite: Sprites.expandIcon,
          position: Vector2(
            size.x / 2 - expandIconSize.x / 2,
            size.y - expandIconSize.y - 15,
          ),
          size: expandIconSize,
        ),
      );
    }
    effect.pause();
    return super.onLoad();
  }

  void stopEffect() {
    effect.reset();
    effect.pause();
  }

  void startEffect() {
    effect.reset();
    effect.resume();
  }

  @override
  onTapUp(info) {
    final p = findParent<FloorManager>();
    p!.stopEffect();
    if (current == FloorState.nomal) {
      startEffect();
    }
    return true;
  }
}

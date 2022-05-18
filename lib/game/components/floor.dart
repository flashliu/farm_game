import 'package:farm/game/components/floor_tip.dart';
import 'package:farm/game/spires.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

enum FloorType {
  nomal,
  disable,
}

enum FloorState {
  waitExpand,
  canExpand,
  canHarvest,
}

class Floor extends SpriteGroupComponent
    with Tappable, GestureHitboxes, HasGameRef {
  final FloorState state;
  final Function(Floor)? onTap;
  final ColorEffect colorEffect = ColorEffect(
    const Color.fromARGB(255, 255, 225, 197),
    const Offset(0, 0.4),
    EffectController(
      duration: 0.8,
      reverseDuration: 0.8,
      infinite: true,
    ),
  );
  FloorTip? floorTip;

  Floor({
    FloorType current = FloorType.disable,
    required Vector2 position,
    required Vector2 size,
    this.state = FloorState.waitExpand,
    this.onTap,
  }) : super(position: position, size: size, current: current);

  @override
  Future<void> onLoad() async {
    sprites = {
      FloorType.nomal: Sprites.nomalFloor,
      FloorType.disable: Sprites.disableFloor,
    };
    final hitBox = PolygonHitbox([
      Vector2(0, size.y / 2),
      Vector2(size.x / 2, size.y),
      Vector2(size.x, size.y / 2),
      Vector2(size.x / 2, 0),
    ]);
    add(hitBox);
    add(colorEffect);
    if (state == FloorState.canExpand) {
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

    if (current == FloorType.nomal) {
      addFloorTip();
    }

    colorEffect.pause();
    return super.onLoad();
  }

  void addFloorTip() {
    final seedTipSize = Sprites.seedTip.srcSize / 1.6;
    if (floorTip != null) return;
    floorTip = FloorTip(
      sprite: Sprites.seedTip,
      position: Vector2(
        size.x / 2 - seedTipSize.x / 2,
        seedTipSize.y - size.y,
      ),
      size: seedTipSize,
    );
    add(floorTip!);
  }

  void removeFloorTip() {
    if (floorTip != null && floorTip!.isMounted) {
      remove(floorTip!);
      floorTip = null;
    }
  }

  void stopColorEffect() {
    colorEffect.reset();
    colorEffect.pause();
  }

  void startColorEffect() {
    colorEffect.reset();
    colorEffect.resume();
  }

  @override
  onTapUp(info) {
    if (onTap != null) {
      onTap!(this);
    }
    super.onTapUp(info);
    return false;
  }
}

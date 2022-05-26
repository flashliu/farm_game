import 'package:farm/game/components/floor_tip.dart';
import 'package:farm/game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

enum FloorType {
  nomal, // 普通土地
  disable, // 未扩建土地
}

enum FloorState {
  waitExpand, // 等待扩建
  canExpand, // 可以扩建
  canSeed, // 可播种
  hasSeed, // 已播种
  canHarvest, // 可收获
  canWeed // 可除草
}

class Floor extends SpriteGroupComponent
    with Tappable, GestureHitboxes, HasGameRef {
  FloorState? state;
  ColorEffect? checkedTip;
  FloorTip? floorTip;
  SpriteComponent? expandTip;
  SpriteComponent? seed;
  bool showFloorTip = true;
  final Function(Floor)? onTap;

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
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!showFloorTip) removeFloorTip();

    //显示可扩建提示
    if (state == FloorState.canExpand) {
      addExpandTip();
    }

    //显示提示
    if (state == FloorState.canSeed) {
      addFloorTip();
    }

    //显示种子
    if (state == FloorState.hasSeed) {
      addSeed();
    }
    super.update(dt);
  }

  void addSeed() {
    if (seed != null) return;
    if (current == FloorType.disable) return;
    seed = SpriteComponent(
      sprite: Sprites.seed,
      size: Sprites.seed.srcSize / 2.5,
      position: Vector2(40, 18),
    );
    add(seed!);
  }

  void addExpandTip() {
    if (expandTip != null) return;
    final expandIconSize = Sprites.expandIcon.srcSize / 1.8;
    expandTip = SpriteComponent(
      sprite: Sprites.expandIcon,
      position: Vector2(
        size.x / 2 - expandIconSize.x / 2,
        size.y - expandIconSize.y - 15,
      ),
      size: expandIconSize,
    );
    add(expandTip!);
  }

  void addFloorTip() {
    if (floorTip != null) return;
    if (current == FloorType.disable) return;
    if (!showFloorTip) return;
    final seedTipSize = Sprites.seedTip.srcSize / 1.6;
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

  void addCheckedTip() {
    if (checkedTip != null) return;
    if (current == FloorType.disable) return;
    checkedTip = ColorEffect(
      const Color.fromARGB(255, 255, 225, 197),
      const Offset(0, 0.4),
      EffectController(
        duration: 0.8,
        reverseDuration: 0.8,
        infinite: true,
      ),
    );
    add(checkedTip!);
  }

  void removeSeed() {
    if (seed == null) return;
    remove(seed!);
    seed = null;
  }

  void removeExpandTip() {
    if (expandTip == null) return;
    remove(checkedTip!);
    expandTip = null;
  }

  void removeFloorTip() {
    if (floorTip == null) return;
    remove(floorTip!);
    floorTip = null;
  }

  void hideFloorTip() {
    if (floorTip == null || floorTip!.paint.color.opacity == 0) return;
    floorTip!.setAlpha(0);
  }

  void visibleFloorTip() {
    if (floorTip == null || floorTip!.paint.color.opacity == 1) return;
    floorTip!.setAlpha(255);
  }

  void removeCheckedTip() {
    if (checkedTip == null) return;
    checkedTip!.reset();
    remove(checkedTip!);
    checkedTip = null;
  }

  @override
  onTapUp(info) {
    if (current == FloorType.disable) return true;
    if (state == FloorState.hasSeed) return true;
    if (onTap != null) {
      onTap!(this);
    }
    return false;
  }
}

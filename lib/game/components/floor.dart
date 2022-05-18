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
  final ColorEffect colorEffect = ColorEffect(
    const Color.fromARGB(255, 255, 225, 197),
    const Offset(0, 0.4),
    EffectController(
      duration: 0.8,
      reverseDuration: 0.8,
      infinite: true,
    ),
  );

  SpriteComponent? seedToast;

  final bool canExpand;
  final Function(Floor)? onTap;

  Floor({
    FloorState current = FloorState.disable,
    required Vector2 position,
    required Vector2 size,
    this.canExpand = false,
    this.onTap,
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
    add(colorEffect);
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

    if (current == FloorState.nomal) {
      addSeedToast();
    }

    colorEffect.pause();
    return super.onLoad();
  }

  void addSeedToast() {
    final seedToastSize = Sprites.seedToast.srcSize / 1.6;
    if (seedToast != null) return;
    seedToast = SpriteComponent(
      sprite: Sprites.seedToast,
      position: Vector2(
        size.x / 2 - seedToastSize.x / 2,
        seedToastSize.y - size.y,
      ),
      size: seedToastSize,
    );
    seedToast!.add(MoveByEffect(
      Vector2(0, 15),
      EffectController(
        duration: 0.6,
        reverseDuration: 0.6,
        infinite: true,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeInBack,
      ),
    ));
    add(seedToast!);
  }

  void resetSeedToast() {
    removeSeedToast();
    addSeedToast();
  }

  void removeSeedToast() {
    if (seedToast != null && seedToast!.isMounted) {
      remove(seedToast!);
      seedToast = null;
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

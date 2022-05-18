import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class FloorTip extends SpriteComponent {
  FloorTip({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
  }) : super(size: size, position: position, sprite: sprite);

  @override
  Future<void>? onLoad() {
    add(MoveByEffect(
      Vector2(0, 15),
      EffectController(
        duration: 0.6,
        reverseDuration: 0.6,
        infinite: true,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeInBack,
      ),
    ));
    return super.onLoad();
  }
}

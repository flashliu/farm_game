import 'package:farm/game/sprites.dart';
import 'package:farm/widgets/action_btn.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class ActionPanel extends StatefulWidget {
  const ActionPanel({Key? key}) : super(key: key);

  @override
  State<ActionPanel> createState() => _ActionPanelState();
}

class _ActionPanelState extends State<ActionPanel> {
  Widget buildBtn(Sprite sprite, {VoidCallback? onTap}) {
    return ActionBtn(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 60,
          height: 60,
          child: SpriteWidget(sprite: sprite, anchor: Anchor.center),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF9f5a00),
        border: Border.all(
          color: const Color(0xFFD6B375),
          width: 2,
        ),
      ),
      child: IntrinsicWidth(
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBtn(Sprites.shop),
            buildBtn(Sprites.store),
          ],
        ),
      ),
    );
  }
}

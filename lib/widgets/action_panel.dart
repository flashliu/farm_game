import 'package:farm/widgets/action_btn.dart';
import 'package:flutter/material.dart';

class ActionPanel extends StatefulWidget {
  const ActionPanel({Key? key}) : super(key: key);

  @override
  State<ActionPanel> createState() => _ActionPanelState();
}

class _ActionPanelState extends State<ActionPanel> {
  Widget buildBtn(String icon) {
    return ActionBtn(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(
          icon,
          width: 60,
          height: 60,
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
            buildBtn("assets/images/shop.png"),
            buildBtn("assets/images/shop.png"),
            buildBtn("assets/images/shop.png"),
            buildBtn("assets/images/shop.png"),
            buildBtn("assets/images/shop.png"),
          ],
        ),
      ),
    );
  }
}

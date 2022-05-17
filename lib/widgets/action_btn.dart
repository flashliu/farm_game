import 'package:flutter/material.dart';

class ActionBtn extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const ActionBtn({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  State<ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<ActionBtn> {
  double offsetY = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          offsetY = 4;
        });
      },
      onTap: widget.onTap,
      onTapUp: (_) {
        setState(() {
          offsetY = 0;
        });
      },
      child: Transform.translate(
        offset: Offset(0, offsetY),
        child: widget.child,
      ),
    );
  }
}

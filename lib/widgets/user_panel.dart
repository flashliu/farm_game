import 'package:farm/global.dart';
import 'package:flutter/material.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  Widget renderBox({
    Widget? child,
    double? width,
    double? height,
    EdgeInsets? padding,
    DecorationImage? image,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF9f5a00),
        border: Border.all(
          color: const Color(0xFFD6B375),
          width: 2,
        ),
        image: image,
      ),
      padding: padding,
      width: width,
      height: height,
      child: child,
    );
  }

  Widget renderTextBox(String text, {Widget? icon}) {
    renderIcon() {
      if (icon == null) return Container();
      return Container(
        width: 18,
        height: 18,
        margin: const EdgeInsets.only(right: 4),
        child: icon,
      );
    }

    return renderBox(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          renderIcon(),
          Expanded(
            child: SizedBox(
              child: Text(
                text,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderProgressBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        renderBox(
          child: Container(
            width: 100,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              Image.asset(
                "assets/images/level.png",
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 4),
              const Text(
                "20级",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 100,
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderBox(
            width: 100,
            image: const DecorationImage(
              image: NetworkImage(
                "https://img.zfn9.com/08/3c/11370b8deb40788e69ae84a98d15e7db.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: Column(
              children: [
                Expanded(child: renderTextBox("晚风吹啊吹晚风吹啊吹")),
                const SizedBox(height: 4),
                Expanded(child: renderProgressBar()),
                const SizedBox(height: 4),
                Expanded(
                  child: renderTextBox(
                    Global.formatNumber(12980000),
                    icon: Image.asset(
                      "assets/images/money.png",
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

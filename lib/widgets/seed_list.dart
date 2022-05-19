import 'package:farm/game/components/floor.dart';
import 'package:farm/game/sprites.dart';
import 'package:farm/global.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SeedItem extends StatelessWidget {
  const SeedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Global.game.floorManager.currentFloor!.state = FloorState.hasSeed;
        final nextFloor = Global.game.floorManager.floorList.firstWhereOrNull(
          (element) {
            if (element.state != FloorState.canSeed) return false;
            if (element.current == FloorType.disable) return false;
            return true;
          },
        );
        Global.game.floorManager.resetCurrentFloor();
        if (nextFloor == null) {
          Global.closeBootomSheet();
        } else {
          Global.game.floorManager.currentFloor = nextFloor;
        }
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFD6B375),
            width: 4,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              "萝卜",
              style: TextStyle(
                color: Color(0xFF9f5a00),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 40,
                height: 40,
                child: SpriteWidget(
                  sprite: Sprites.seedRadish,
                  anchor: Anchor.center,
                ),
              ),
            ),
            const Text(
              "等级：20",
              style: TextStyle(
                color: Color(0xFF9f5a00),
                fontSize: 12,
              ),
            ),
            const Text(
              "数量：1",
              style: TextStyle(
                color: Color(0xFF9f5a00),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class SeedList extends StatefulWidget {
  const SeedList({Key? key}) : super(key: key);

  @override
  State<SeedList> createState() => _SeedListState();
}

class _SeedListState extends State<SeedList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFD6B375),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF9f5a00),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            const Text(
              "播种",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, i) => const SeedItem(),
                separatorBuilder: (_, i) => const SizedBox(width: 8),
              ),
            )
          ],
        ),
      ),
    );
  }
}

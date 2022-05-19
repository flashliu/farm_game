import 'package:farm/widgets/seed_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'game/farm_game.dart';

enum JudgeType {
  and,
  or,
}

class Global {
  static FarmGame game = FarmGame();
  static PersistentBottomSheetController? curBottomSheet;
  static formatNumber(int value) {
    final fmt = NumberFormat("0,000");
    return fmt.format(value);
  }

  static showSeedList() {
    if (curBottomSheet != null) return;
    curBottomSheet = showBottomSheet(
      enableDrag: false,
      constraints: const BoxConstraints(
        maxHeight: 180,
        minHeight: 180,
        maxWidth: 500,
        minWidth: 500,
      ),
      backgroundColor: Colors.transparent,
      context: game.buildContext!,
      builder: (_) {
        return const SeedList();
      },
    );
  }

  static closeBootomSheet() {
    curBottomSheet?.close();
    curBottomSheet = null;
  }
}

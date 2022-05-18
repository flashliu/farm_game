import 'package:intl/intl.dart';

import 'game/game.dart';

class Global {
  static FarmGame game = FarmGame();

  static formatNumber(int value) {
    final fmt = NumberFormat("0,000");
    return fmt.format(value);
  }
}

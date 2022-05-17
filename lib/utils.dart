import 'package:intl/intl.dart';

class Utils {
  static formatNumber(int value) {
    final fmt = NumberFormat("0,000");
    return fmt.format(value);
  }
}

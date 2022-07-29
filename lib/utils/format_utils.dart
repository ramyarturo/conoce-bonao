import 'package:intl/intl.dart';

abstract class FormatUtils {
  static final _currencyFormat = NumberFormat.currency(symbol: "\$RD ");

  static String formatCurrency(number) {
    return _currencyFormat.format(number);
  }
}

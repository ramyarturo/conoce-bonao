import 'package:intl/intl.dart';

abstract class FormatUtils {
 
  static String formatCurrency(number, {String symbol = "\$RD "}) {
    return NumberFormat.currency(symbol: symbol).format(number);
  }
}

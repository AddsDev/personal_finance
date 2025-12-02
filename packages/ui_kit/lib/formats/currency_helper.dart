import 'package:intl/intl.dart';

class CurrencyHelper {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
    customPattern: '\u00A4#,##0.00',
  );

  static String format(double amount) {
    return _currencyFormat.format(amount);
  }

  static String formatWithSign(double amount, {bool isExpense = false}) {
    final formatted = _currencyFormat.format(amount.abs());
    if (isExpense && amount > 0) return '-$formatted';
    if (!isExpense && amount > 0) return '+$formatted';
    return formatted;
  }
}

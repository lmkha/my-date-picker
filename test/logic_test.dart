import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('Days in month logic test', () {
    DateTime dec = DateTime(2025, 12, 15);

    int days = DateTime(dec.year, dec.month + 1, 0).day;

    expect(days, 31);
  });

  test('Test week day', () {
    DateTime date = DateTime(2025, 11, 23);

    expect(date.weekday, 7);
  });

  test('Test locale weekdays', () {
    final String localeCode = 'vi';
    final symbols = DateFormat.E(localeCode).dateSymbols;
    expect(symbols.FIRSTDAYOFWEEK, 7);
  });
}

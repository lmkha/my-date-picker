import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  final DateTime date = DateTime(2025, 0, 1);
  // print(getDaysInMonth(date));
  print(date);
}

int getDaysInMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0).day;
}

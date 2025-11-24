import 'package:intl/intl.dart';

class MyDateUtils {
  MyDateUtils._();

  static const String format = 'dd/MM/yyyy';

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  static DateTime? tryParse(String input) {
    try {
      return DateFormat(format).parseStrict(input);
    } catch (e) {
      return null;
    }
  }
}

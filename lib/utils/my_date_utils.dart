class MyDateUtils {
  MyDateUtils._();

  // DateFormat('dd/MM/yyyy').parse('03/11/2025');
  static const String defaultFormat = 'dd/MM/yyyy';

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String formatTitle(DateTime date) {
    return "${date.month} / ${date.year}";
  }

  /// Calculates the number of days in a specific month.
  ///
  /// It creates a DateTime for the "0th" day of the next month,
  /// which Dart interprets as the last day of the current month.
  ///
  /// Returns an integer between 28 and 31.
  static int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}

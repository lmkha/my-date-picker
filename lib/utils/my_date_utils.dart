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
}

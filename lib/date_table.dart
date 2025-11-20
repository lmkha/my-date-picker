import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateTableType { startDate, endDate }

class DateTable extends StatefulWidget {
  const DateTable({super.key, required this.type, this.selectedDateString});

  final String? selectedDateString;
  final DateTableType type;

  @override
  State<StatefulWidget> createState() => _DateTableState();
}

class _DateTableState extends State<DateTable> {
  /// Calculates the number of days in a specific month.
  ///
  /// It creates a DateTime for the "0th" day of the next month,
  /// which Dart interprets as the last day of the current month.
  ///
  /// Returns an integer between 28 and 31.
  int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dayOfWeek = List.of([
      'Mon',
      'Tue',
      'Web',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ]);

    final startDateString = widget.selectedDateString;
    final startDate = startDateString != null
        ? DateFormat('dd/MM/yyyy').parse(startDateString)
        : DateTime.now();
    final firstDateOfMonth = DateTime(startDate.year, startDate.month, 1);
    int indexOfFirstDate = firstDateOfMonth.weekday - 1;
    final totalDateOfMonth = getDaysInMonth(startDate);
    final indextOfLastDate = indexOfFirstDate + totalDateOfMonth - 1;
    final String title = DateFormat('MMM yyyy').format(startDate);

    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsetsGeometry.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 5,
          children: [
            // Header
            SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: widget.type == DateTableType.startDate
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        widget.type == DateTableType.startDate
                            ? Icons.arrow_back
                            : Icons.arrow_forward,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),

            // Day of week
            Row(
              spacing: 2,
              children: List.generate(dayOfWeek.length, (index) {
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      dayOfWeek[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Content
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(42, (index) {
                  String result = '';
                  if (index >= indexOfFirstDate && index <= indextOfLastDate) {
                    result = (index - indexOfFirstDate + 1).toString();
                  }

                  return ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(5),
                    child: Container(
                      alignment: Alignment.center,
                      color: result.isNotEmpty
                          ? Colors.blue[400]
                          : Colors.white,
                      child: Text(
                        result,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_date_picker/date_table/date_table_item.dart';
import 'package:my_date_picker/state/date_picker_model.dart';
import 'package:my_date_picker/utils/my_date_utils.dart';
import 'package:provider/provider.dart';

enum DateTableType { startDate, endDate }

class DateTable extends StatefulWidget {
  const DateTable({super.key, required this.type, this.selectedDate});

  final DateTime? selectedDate;
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
    final DatePickerModel datePickerModel = context.watch<DatePickerModel>();

    List<String> weekdays = DateFormat().dateSymbols.SHORTWEEKDAYS;
    weekdays = [...weekdays.sublist(1), weekdays.first];
    final firstDateOfMonth = widget.type == DateTableType.startDate
        ? datePickerModel.firstDateOfMonthStartChoosing
        : datePickerModel.firstDateOfMonthEndChoosing;
    int indexOfFirstDate = firstDateOfMonth.weekday - 1;
    final totalDateOfMonth = getDaysInMonth(firstDateOfMonth);
    final indextOfLastDate = indexOfFirstDate + totalDateOfMonth - 1;
    final String title = DateFormat('MMM yyyy').format(firstDateOfMonth);

    return Container(
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
            children: List.generate(weekdays.length, (index) {
              return Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    weekdays[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                String? result;
                int day = index - indexOfFirstDate + 1;
                if (index >= indexOfFirstDate && index <= indextOfLastDate) {
                  result = day.toString();
                }

                bool isSelected = false;

                if (widget.type == DateTableType.startDate &&
                    datePickerModel.selectedStartDate != null) {
                  isSelected = MyDateUtils.isSameDay(
                    datePickerModel.selectedStartDate,
                    DateTime(
                      datePickerModel.firstDateOfMonthStartChoosing.year,
                      datePickerModel.firstDateOfMonthStartChoosing.month,
                      day,
                    ),
                  );
                }

                if (widget.type == DateTableType.endDate &&
                    datePickerModel.selectedEndDate != null) {
                  isSelected = MyDateUtils.isSameDay(
                    datePickerModel.selectedEndDate,
                    DateTime(
                      datePickerModel.firstDateOfMonthEndChoosing.year,
                      datePickerModel.firstDateOfMonthEndChoosing.month,
                      day,
                    ),
                  );
                }

                return DateTableItem(text: result, isSelected: isSelected);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

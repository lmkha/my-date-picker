import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_date_picker/date_table/item_position.dart';
import 'package:my_date_picker/my_date_picker/date_picker_controller.dart';
import 'package:my_date_picker/date_table/date_table_item.dart';
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
  @override
  Widget build(BuildContext context) {
    final DatePickerController datePickerController = context
        .watch<DatePickerController>();
    List<String> weekdays = DateFormat().dateSymbols.SHORTWEEKDAYS;
    weekdays = [...weekdays.sublist(1), weekdays.first];
    final firstDateOfMonth = widget.type == DateTableType.startDate
        ? datePickerController.firstDateOfMonthStartChoosing
        : datePickerController.firstDateOfMonthEndChoosing;
    int indexOfFirstDate = firstDateOfMonth.weekday - 1;
    final totalDateOfMonth = MyDateUtils.getDaysInMonth(firstDateOfMonth);
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
                    onPressed: widget.type == DateTableType.startDate
                        ? datePickerController.swipePreviousMonth
                        : datePickerController.swipeNextMonth,
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
                String? text;
                int day = index - indexOfFirstDate + 1;
                if (index >= indexOfFirstDate && index <= indextOfLastDate) {
                  text = day.toString();
                }

                DateTime? date;
                if (widget.type == DateTableType.startDate) {
                  date = DateUtils.dateOnly(
                    DateTime(
                      datePickerController.firstDateOfMonthStartChoosing.year,
                      datePickerController.firstDateOfMonthStartChoosing.month,
                      day,
                    ),
                  );
                } else {
                  date = DateUtils.dateOnly(
                    DateTime(
                      datePickerController.firstDateOfMonthEndChoosing.year,
                      datePickerController.firstDateOfMonthEndChoosing.month,
                      day,
                    ),
                  );
                }

                ItemPosition position = ItemPosition.outside;
                if (datePickerController.selectedStartDate != null &&
                    MyDateUtils.isSameDay(
                      date,
                      datePickerController.selectedStartDate!,
                    )) {
                  position = ItemPosition.at;
                }

                if (datePickerController.selectedEndDate != null &&
                    MyDateUtils.isSameDay(
                      date,
                      datePickerController.selectedEndDate!,
                    )) {
                  position = ItemPosition.at;
                }

                if (datePickerController.selectedStartDate != null &&
                    datePickerController.selectedEndDate != null &&
                    date.isAfter(datePickerController.selectedStartDate!) &&
                    date.isBefore(datePickerController.selectedEndDate!)) {
                  position = ItemPosition.between;
                }

                if (MyDateUtils.isSameDay(
                  date,
                  DateUtils.dateOnly(DateTime.now()),
                )) {
                  position = ItemPosition.today;
                }

                return DateTableItem(
                  text: text,
                  position: position,
                  onClick: () {
                    if (date != null) {
                      datePickerController.updateSelectedDate(date);
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

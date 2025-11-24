import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_date_picker/date_table/item_position.dart';
import 'package:my_date_picker/my_date_picker/date_picker_controller.dart';
import 'package:my_date_picker/date_table/date_table_item.dart';
import 'package:my_date_picker/utils/my_date_utils.dart';
import 'package:provider/provider.dart';

enum DateTableType { startDate, endDate }

class DateTable extends StatefulWidget {
  const DateTable({super.key, required this.type});
  final DateTableType type;

  @override
  State<StatefulWidget> createState() => _DateTableState();
}

class _DateTableState extends State<DateTable> {
  DateTime _getItemDate(int day, DatePickerController controller) {
    DateTime date;
    if (widget.type == DateTableType.startDate) {
      date = DateUtils.dateOnly(DateTime(controller.firstDateMonthStart.year, controller.firstDateMonthStart.month, day));
    } else {
      date = DateUtils.dateOnly(DateTime(controller.firstDateOfMonthEnd.year, controller.firstDateOfMonthEnd.month, day));
    }
    return date;
  }

  ItemPosition _getItemPosition(DateTime date, DatePickerController controller) {
    ItemPosition position = ItemPosition.outside;
    if (controller.startDate != null && MyDateUtils.isSameDay(date, controller.startDate!)) {
      position = ItemPosition.at;
    }

    if (controller.endDate != null && MyDateUtils.isSameDay(date, controller.endDate!)) {
      position = ItemPosition.at;
    }

    if (controller.startDate != null && controller.endDate != null && date.isAfter(controller.startDate!) && date.isBefore(controller.endDate!)) {
      position = ItemPosition.between;
    }

    if (MyDateUtils.isSameDay(date, DateUtils.dateOnly(DateTime.now()))) {
      position = ItemPosition.today;
    }
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final DatePickerController datePickerController = context.watch<DatePickerController>();
    List<String> weekdays = DateFormat().dateSymbols.SHORTWEEKDAYS;
    weekdays = [...weekdays.sublist(1), weekdays.first];
    final firstDateOfMonth = widget.type == DateTableType.startDate
        ? datePickerController.firstDateMonthStart
        : datePickerController.firstDateOfMonthEnd;
    int indexOfFirstDate = firstDateOfMonth.weekday - DateTime.monday;
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
                  alignment: widget.type == DateTableType.startDate ? Alignment.centerLeft : Alignment.centerRight,
                  child: IconButton(
                    onPressed: widget.type == DateTableType.startDate ? datePickerController.swipePreviousMonth : datePickerController.swipeNextMonth,
                    icon: Icon(widget.type == DateTableType.startDate ? Icons.arrow_back : Icons.arrow_forward),
                  ),
                ),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                  child: Text(weekdays[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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

                DateTime date = _getItemDate(day, datePickerController);
                ItemPosition position = _getItemPosition(date, datePickerController);

                return DateTableItem(text: text, position: position, onClick: () => datePickerController.pickDate(date));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

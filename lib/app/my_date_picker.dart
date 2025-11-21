import 'package:flutter/material.dart';
import 'package:my_date_picker/date_input/date_input.dart';
import 'package:my_date_picker/state/date_picker_model.dart';
import 'package:my_date_picker/date_table/date_table.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick_panel.dart';
import 'package:provider/provider.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  State<StatefulWidget> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    final DatePickerModel datePickerModel = context.watch<DatePickerModel>();

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: SizedBox(
        height: 500,
        width: 850,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: QuickPickPanel()),
            SizedBox(
              width: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top section
                  SizedBox(
                    height: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTable(
                            selectedDate: datePickerModel.selectedStartDate,
                            type: DateTableType.startDate,
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          width: 1,
                          color: Colors.black,
                          indent: 50,
                        ),
                        Expanded(
                          child: DateTable(
                            selectedDate: datePickerModel.selectedEndDate,
                            type: DateTableType.endDate,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(thickness: 1, height: 1, color: Colors.black),

                  // Bottom section
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsetsGeometry.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              DateInput(
                                text: 'Start date',
                                selectedDate: datePickerModel.selectedStartDate,
                              ),
                              SizedBox(
                                width: 10,
                                child: Divider(
                                  thickness: 2,
                                  height: 2,
                                  color: Colors.black,
                                ),
                              ),
                              DateInput(
                                text: 'End date',
                                selectedDate: datePickerModel.selectedEndDate,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.blue,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Apply',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

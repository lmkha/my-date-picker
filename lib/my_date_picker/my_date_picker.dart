import 'package:flutter/material.dart';
import 'package:my_date_picker/date_input/date_input.dart';
import 'package:my_date_picker/date_table/date_table.dart';
import 'package:my_date_picker/my_date_picker/date_picker_controller.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker_result.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick_panel.dart';
import 'package:provider/provider.dart';

class MyDatePicker extends StatelessWidget {
  final void Function(MyDatePickerResult)? onSelected;

  const MyDatePicker({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatePickerController(),
      child: Consumer<DatePickerController>(
        builder: (context, controller, child) {
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
                                  selectedDate: controller.selectedStartDate,
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
                                  selectedDate: controller.selectedEndDate,
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
                                      selectedDate:
                                          controller.selectedStartDate,
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
                                      selectedDate: controller.selectedEndDate,
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: controller.result != null
                                          ? () => onSelected?.call(
                                              controller.result!,
                                            )
                                          : null,
                                      child: Text('Apply'),
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
        },
      ),
    );
  }
}

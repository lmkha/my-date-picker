import 'package:flutter/material.dart';
import 'package:my_date_picker/date_table.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  State<StatefulWidget> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: SizedBox(
        height: 500,
        width: 900,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Container(color: Colors.blue[200])),
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
                        DateTable(
                          selectedDateString: '04/02/2025',
                          type: DateTableType.startDate,
                        ),
                        VerticalDivider(
                          thickness: 1,
                          width: 1,
                          color: Colors.black,
                          indent: 50,
                        ),
                        DateTable(
                          selectedDateString: '27/12/2025',
                          type: DateTableType.endDate,
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
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  decoration: InputDecoration(
                                    label: Text('Start date'),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                                child: Divider(
                                  thickness: 2,
                                  height: 2,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  decoration: InputDecoration(
                                    label: Text('End date'),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
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

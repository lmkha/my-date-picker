import 'package:flutter/material.dart';
import 'package:my_date_picker/app/date_picker_controller.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick.dart';
import 'package:provider/provider.dart';

class QuickPickPanel extends StatelessWidget {
  final List<QuickPick> quickPickOptions;

  const QuickPickPanel({super.key, required this.quickPickOptions});

  @override
  Widget build(BuildContext context) {
    final DatePickerController datePickerModel = context
        .watch<DatePickerController>();

    return Container(
      color: Colors.blue[300],
      padding: EdgeInsetsGeometry.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2,
        children: List.generate(quickPickOptions.length, (index) {
          final quickPick = quickPickOptions[index];
          return Expanded(
            child: TextButton(
              onPressed: quickPick.onClick,
              style: ButtonStyle(
                backgroundColor: datePickerModel.currentQuickOption == quickPick
                    ? WidgetStateProperty.all(Colors.white)
                    : null,
                overlayColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              child: Text(
                quickPick.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

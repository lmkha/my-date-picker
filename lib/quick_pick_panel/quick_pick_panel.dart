import 'package:flutter/material.dart';
import 'package:my_date_picker/my_date_picker/date_picker_controller.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick.dart';
import 'package:provider/provider.dart';

class QuickPickPanel extends StatelessWidget {
  const QuickPickPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final DatePickerController datePickerModel = context.watch<DatePickerController>();
    final List<QuickPick> quickPickOptions = datePickerModel.quickPickList;

    return Container(
      color: Colors.blue[300],
      padding: EdgeInsetsGeometry.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2,
        children: List.generate(quickPickOptions.length, (index) {
          final QuickPick quickPick = quickPickOptions[index];
          return Expanded(
            child: TextButton(
              onPressed: quickPick.onClick,
              style: ButtonStyle(
                backgroundColor: datePickerModel.currentQuickPick == quickPick ? WidgetStateProperty.all(Colors.white) : null,
                overlayColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  ),
                ),
              ),
              child: Text(
                quickPick.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
              ),
            ),
          );
        }),
      ),
    );
  }
}

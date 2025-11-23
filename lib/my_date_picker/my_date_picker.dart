import 'package:flutter/material.dart';
import 'package:my_date_picker/my_date_picker/date_picker_controller.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker_result.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker_wrapper.dart';
import 'package:provider/provider.dart';

class MyDatePicker extends StatelessWidget {
  final void Function(MyDatePickerResult)? onSelected;

  const MyDatePicker({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatePickerController(),
      child: MyDatePickerWrapper(onSelected: onSelected),
    );
  }
}

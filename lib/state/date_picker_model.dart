import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerModel extends ChangeNotifier {
  final now = DateTime.now();
  late DateTime? _selectedStartDate = now;
  late DateTime? _selectedEndDate = now;
  late DateTime _firstDateOfMonthStartChoosing = DateTime(
    now.year,
    now.month - 1,
    1,
  );
  late DateTime _firstDateOfMonthEndChoosing = DateTime(now.year, now.month, 1);

  DateTime? get selectedStartDate {
    return _selectedStartDate;
  }

  set selectedStartDate(DateTime? newSelectedStartDate) {
    _selectedStartDate = newSelectedStartDate;
    notifyListeners();
  }

  DateTime? get selectedEndDate {
    return _selectedEndDate;
  }

  set selectedEndDate(DateTime? newSelectedEndDate) {
    _selectedEndDate = newSelectedEndDate;
    notifyListeners();
  }

  DateTime get firstDateOfMonthStartChoosing {
    return _firstDateOfMonthStartChoosing;
  }

  set firstDateOfMonthStartChoosing(DateTime newFirstDateOfMonthStartChoosing) {
    _firstDateOfMonthStartChoosing = newFirstDateOfMonthStartChoosing;
    notifyListeners();
  }

  DateTime get firstDateOfMonthEndChoosing {
    return _firstDateOfMonthEndChoosing;
  }

  set firstDateOfMonthEndChoosing(DateTime newFirstDateOfMonthEndChoosing) {
    _firstDateOfMonthEndChoosing = newFirstDateOfMonthEndChoosing;
    notifyListeners();
  }
}

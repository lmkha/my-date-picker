import 'package:flutter/material.dart';

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

  DateTime? get selectedEndDate {
    return _selectedEndDate;
  }

  DateTime get firstDateOfMonthStartChoosing {
    return _firstDateOfMonthStartChoosing;
  }

  DateTime get firstDateOfMonthEndChoosing {
    return _firstDateOfMonthEndChoosing;
  }

  void updateSelectedDate(DateTime selectedDate) {
    if (_selectedStartDate != null && _selectedEndDate != null) {
      _selectedStartDate = selectedDate;
      _selectedEndDate = null;
      notifyListeners();
      return;
    }

    if (_selectedStartDate == null ||
        selectedDate.isBefore(_selectedStartDate!)) {
      _selectedStartDate = selectedDate;
      notifyListeners();
      return;
    }
    _selectedEndDate = selectedDate;
    notifyListeners();
  }

  void swipePreviousMonth() {
    _firstDateOfMonthStartChoosing = DateTime(
      _firstDateOfMonthStartChoosing.year,
      _firstDateOfMonthStartChoosing.month - 1,
      1,
    );
    _firstDateOfMonthEndChoosing = DateTime(
      _firstDateOfMonthEndChoosing.year,
      _firstDateOfMonthEndChoosing.month - 1,
      1,
    );
    notifyListeners();
  }

  void swipeNextMonth() {
    _firstDateOfMonthStartChoosing = DateTime(
      _firstDateOfMonthStartChoosing.year,
      _firstDateOfMonthStartChoosing.month + 1,
      1,
    );
    _firstDateOfMonthEndChoosing = DateTime(
      _firstDateOfMonthEndChoosing.year,
      _firstDateOfMonthEndChoosing.month + 1,
      1,
    );
    notifyListeners();
  }
}

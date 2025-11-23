import 'package:flutter/material.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker_result.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick_option.dart';
import 'package:my_date_picker/utils/my_date_utils.dart';

class DatePickerController extends ChangeNotifier {
  final now = DateUtils.dateOnly(DateTime.now());
  late DateTime? _selectedStartDate = now;
  late DateTime? _selectedEndDate = now;
  late DateTime _firstDateOfMonthStartChoosing = DateTime(
    now.year,
    now.month - 1,
    1,
  );
  late DateTime _firstDateOfMonthEndChoosing = DateTime(now.year, now.month, 1);
  late final Map<QuickPickOption, QuickPick> _quickPicksMap = {
    QuickPickOption.today: QuickPick(
      title: 'Today',
      onClick: _hanleQuickPickToday,
    ),
    QuickPickOption.yesaterday: QuickPick(
      title: 'Yesterday',
      onClick: _hanleQuickPickYesaterday,
    ),
    QuickPickOption.thisWeek: QuickPick(
      title: 'This week',
      onClick: _hanleQuickPickThisWeek,
    ),
    QuickPickOption.lastWeek: QuickPick(
      title: 'Last week',
      onClick: _hanleQuickPickLastWeek,
    ),
    QuickPickOption.thisMonth: QuickPick(
      title: 'This month',
      onClick: _hanleQuickPickThisMonth,
    ),
    QuickPickOption.last7Days: QuickPick(
      title: 'Last 7 days',
      onClick: _hanleQuickPickLast7Days,
    ),
    QuickPickOption.last30Days: QuickPick(
      title: 'Last 30 days',
      onClick: _hanleQuickPickLast30Days,
    ),
    QuickPickOption.custom: QuickPick(
      title: 'Custom',
      onClick: _hanleQuickPickCustom,
    ),
  };

  late QuickPick? _currentQuickPick = _quickPicksMap[QuickPickOption.today];

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

  List<QuickPick> get quickPickOption {
    return _quickPicksMap.values.toList();
  }

  QuickPick? get currentQuickOption {
    return _currentQuickPick;
  }

  MyDatePickerResult? get result {
    if (_selectedStartDate == null) return null;
    if (_selectedEndDate == null) return null;
    return MyDatePickerResult(
      startDate: _selectedStartDate!,
      endDate: _selectedEndDate!,
    );
  }

  void updateSelectedDate(DateTime selectedDate) {
    _currentQuickPick = null;

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

  void _refreshFirstDayOfMonthChoosing() {
    if (_selectedStartDate == null || _selectedEndDate == null) return;

    _firstDateOfMonthEndChoosing = DateTime(
      _selectedEndDate!.year,
      _selectedEndDate!.month,
      1,
    );

    if (_selectedStartDate!.year == _selectedEndDate!.year &&
        _selectedStartDate!.month == _selectedEndDate!.month) {
      _firstDateOfMonthStartChoosing = DateTime(
        _firstDateOfMonthEndChoosing.year,
        _firstDateOfMonthEndChoosing.month - 1,
        1,
      );
    } else {
      _firstDateOfMonthStartChoosing = DateTime(
        _selectedStartDate!.year,
        _selectedStartDate!.month,
        1,
      );
    }
  }

  void _hanleQuickPickToday() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.today];
    _selectedStartDate = DateUtils.dateOnly(DateTime.now());
    _selectedEndDate = _selectedStartDate;
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickYesaterday() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.yesaterday];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final date = DateTime(today.year, today.month, today.day - 1);
    _selectedStartDate = date;
    _selectedEndDate = date;
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickThisWeek() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.thisWeek];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final weekday = today.weekday;
    final noDayToMonday = weekday - DateTime.monday;
    final noDayToSunday = DateTime.sunday - weekday;
    _selectedStartDate = DateTime(
      today.year,
      today.month,
      today.day - noDayToMonday,
    );
    _selectedEndDate = DateTime(
      today.year,
      today.month,
      today.day + noDayToSunday,
    );
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickLastWeek() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.lastWeek];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final weekday = today.weekday;
    final noDayToMonday = weekday - DateTime.monday;
    _selectedEndDate = DateTime(
      today.year,
      today.month,
      today.day - noDayToMonday - 1, // The Sunday of previous week
    );
    _selectedStartDate = DateTime(
      today.year,
      today.month,
      today.day -
          noDayToMonday -
          DateTime.daysPerWeek, // The Monday of prevous week
    );
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickThisMonth() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.thisMonth];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _selectedStartDate = DateTime(today.year, today.month, 1);
    _selectedEndDate = DateTime(
      today.year,
      today.month,
      MyDateUtils.getDaysInMonth(today),
    );
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickLast7Days() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.last7Days];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _selectedStartDate = DateTime(today.year, today.month, today.day - 7);
    _selectedEndDate = today;
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickLast30Days() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.last30Days];
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _selectedEndDate = today;
    _selectedStartDate = DateTime(today.year, today.month, today.day - 30);
    _refreshFirstDayOfMonthChoosing();
    notifyListeners();
  }

  void _hanleQuickPickCustom() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.custom];
    notifyListeners();
  }
}

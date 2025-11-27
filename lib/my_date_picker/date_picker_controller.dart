import 'package:flutter/material.dart';
import 'package:my_date_picker/my_date_picker/my_date_picker_result.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick.dart';
import 'package:my_date_picker/quick_pick_panel/quick_pick_option.dart';
import 'package:my_date_picker/utils/my_date_utils.dart';

/// Manages the state of the Date Picker by tracking the selected range and the visual calendar.
///
/// This controller is built around 4 key values:
/// * **Selection State**: `startDate` and `endDate` store what the user has actually picked.
/// * **Navigation State**: `firstDateMonthStart` and `firstDateOfMonthEnd` track which
///   months are currently visible to the user, allowing independent scrolling of the two tables.
class DatePickerController extends ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;
  late DateTime _firstDateOfMonth;
  late final Map<QuickPickOption, QuickPick> _quickPicksMap;
  late QuickPick? _currentQuickPick = _quickPicksMap[QuickPickOption.today];
  final FocusNode _startDateFocus = FocusNode();
  final FocusNode _endDateFocus = FocusNode();

  DatePickerController() {
    _init();
  }

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateTime get firstDateMonthStart => DateTime(_firstDateOfMonth.year, _firstDateOfMonth.month - 1, 1);
  DateTime get firstDateOfMonthEnd => _firstDateOfMonth;
  List<QuickPick> get quickPickList => _quickPicksMap.values.toList();
  QuickPick? get currentQuickPick => _currentQuickPick;
  FocusNode get startDateFocus => _startDateFocus;
  FocusNode get endDateFocus => _endDateFocus;
  MyDatePickerResult? get result {
    if (_startDate == null) return null;
    if (_endDate == null) return null;
    return MyDatePickerResult(startDate: _startDate!, endDate: _endDate!);
  }

  void pickDate(DateTime selectedDate) {
    _currentQuickPick = null;

    if (_startDate != null && _endDate != null) {
      _startDate = selectedDate;
      _endDate = null;
      notifyListeners();
      return;
    }

    if (_startDate == null || selectedDate.isBefore(_startDate!)) {
      _startDate = selectedDate;
      notifyListeners();
      return;
    }
    _endDate = selectedDate;
    notifyListeners();
  }

  void inputStartDate(DateTime date) {
    if (_endDate == null || DateUtils.dateOnly(date).isBefore(DateUtils.dateOnly(_endDate!))) {
      _startDate = date;

      _endDateFocus.requestFocus();

      bool isInCurrentTableView = true;
      if (date.year != _firstDateOfMonth.year) isInCurrentTableView = false;
      if (date.month != _firstDateOfMonth.month && date.month != _firstDateOfMonth.month - 1) isInCurrentTableView = false;

      if (isInCurrentTableView == false) {
        _firstDateOfMonth = date.copyWith(month: date.month + 1, day: 1);
      }
    }
    notifyListeners();
  }

  void inputEndDate(DateTime date) {
    if (_startDate == null || DateUtils.dateOnly(date).isAfter(DateUtils.dateOnly(_startDate!))) {
      _endDate = date;

      bool isInCurrentTableView = true;
      if (date.year != _firstDateOfMonth.year) isInCurrentTableView = false;
      if (date.month != _firstDateOfMonth.month && date.month != _firstDateOfMonth.month - 1) isInCurrentTableView = false;

      if (isInCurrentTableView == false) {
        _firstDateOfMonth = date.copyWith(day: 1);
      }
    }
    notifyListeners();
  }

  void swipePreviousMonth() {
    _firstDateOfMonth = DateTime(_firstDateOfMonth.year, _firstDateOfMonth.month - 1, 1);
    notifyListeners();
  }

  void swipeNextMonth() {
    _firstDateOfMonth = DateTime(_firstDateOfMonth.year, _firstDateOfMonth.month + 1, 1);
    notifyListeners();
  }

  void reset() {
    final today = DateUtils.dateOnly(DateTime.now());
    _startDate = null;
    _endDate = null;
    _firstDateOfMonth = today.copyWith(day: 1);
    notifyListeners();
  }

  void _init() {
    final today = DateUtils.dateOnly(DateTime.now());
    _startDate = today;
    _endDate = today;
    _firstDateOfMonth = today.copyWith(day: 1);
    _quickPicksMap = {
      QuickPickOption.today: QuickPick(title: 'Today', onClick: _hanleQuickPickToday),
      QuickPickOption.yesaterday: QuickPick(title: 'Yesterday', onClick: _hanleQuickPickYesaterday),
      QuickPickOption.thisWeek: QuickPick(title: 'This week', onClick: _hanleQuickPickThisWeek),
      QuickPickOption.lastWeek: QuickPick(title: 'Last week', onClick: _hanleQuickPickLastWeek),
      QuickPickOption.thisMonth: QuickPick(title: 'This month', onClick: _hanleQuickPickThisMonth),
      QuickPickOption.last7Days: QuickPick(title: 'Last 7 days', onClick: _hanleQuickPickLast7Days),
      QuickPickOption.last30Days: QuickPick(title: 'Last 30 days', onClick: _hanleQuickPickLast30Days),
      QuickPickOption.custom: QuickPick(title: 'Custom', onClick: _hanleQuickPickCustom),
    };
  }

  void _hanleQuickPickToday() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.today];

    _startDate = DateUtils.dateOnly(DateTime.now());
    _endDate = _startDate;

    _refreshFirstDateOfMonth();

    notifyListeners();
  }

  void _hanleQuickPickYesaterday() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.yesaterday];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final date = today.copyWith(day: today.day - 1);
    _startDate = date;
    _endDate = date;

    _refreshFirstDateOfMonth();

    notifyListeners();
  }

  void _hanleQuickPickThisWeek() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.thisWeek];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final daysSinceThisMonday = today.weekday - DateTime.monday;
    final daysToThisSunday = DateTime.sunday - today.weekday;
    _startDate = today.copyWith(day: today.day - daysSinceThisMonday);
    _endDate = today.copyWith(day: today.day + daysToThisSunday);

    _refreshFirstDateOfMonth();
    notifyListeners();
  }

  void _hanleQuickPickLastWeek() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.lastWeek];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final daysSinceLastSunday = today.weekday - DateTime.monday + 1;
    final daysSinceLastMonday = daysSinceLastSunday + DateTime.daysPerWeek - 1;
    _endDate = today.copyWith(day: today.day - daysSinceLastSunday);
    _startDate = today.copyWith(day: today.day - daysSinceLastMonday);

    _refreshFirstDateOfMonth();
    notifyListeners();
  }

  void _hanleQuickPickThisMonth() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.thisMonth];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _startDate = today.copyWith(day: 1);
    _endDate = today.copyWith(day: MyDateUtils.getDaysInMonth(today));

    _refreshFirstDateOfMonth();
    notifyListeners();
  }

  void _hanleQuickPickLast7Days() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.last7Days];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _startDate = today.copyWith(day: today.day - 7);
    _endDate = today;

    _refreshFirstDateOfMonth();
    notifyListeners();
  }

  void _hanleQuickPickLast30Days() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.last30Days];

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    _endDate = today;
    _startDate = today.copyWith(day: today.day - 30);

    _refreshFirstDateOfMonth();
    notifyListeners();
  }

  void _hanleQuickPickCustom() {
    _currentQuickPick = _quickPicksMap[QuickPickOption.custom];
    _startDateFocus.requestFocus();
    reset();
  }

  void _refreshFirstDateOfMonth() {
    if (_startDate == null || _endDate == null) return;
    _firstDateOfMonth = DateTime(_endDate!.year, _endDate!.month, 1);
  }
}

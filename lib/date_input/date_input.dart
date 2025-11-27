import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_date_picker/utils/my_date_utils.dart';

class DateInput extends StatefulWidget {
  final String text;
  final DateTime? selectedDate;
  final void Function(DateTime)? onCompleted;
  final FocusNode? focusNode;

  const DateInput({super.key, required this.text, this.selectedDate, this.onCompleted, this.focusNode});

  @override
  State<StatefulWidget> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late TextEditingController _controller;
  late FocusNode _effectiveFocusNode;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _updateText();
  }

  @override
  void didUpdateWidget(DateInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateText();
  }

  void _updateText() {
    if (widget.selectedDate != null) {
      String formatted = DateFormat(MyDateUtils.format).format(widget.selectedDate!);
      _controller.text = formatted;
    } else {
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.focusNode == null) {
      _effectiveFocusNode.dispose();
    }
    super.dispose();
  }

  void _validateDate(String value) {
    if (value.isEmpty) {
      setState(() => _isError = false);
      return;
    }

    if (value.length < 10) {
      setState(() => _isError = false);
      return;
    }

    if (value.length == 10) {
      DateTime? date = MyDateUtils.tryParse(value);
      if (date != null) {
        widget.onCompleted?.call(date);
      }
      setState(() {
        _isError = (date == null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: TextField(
        controller: _controller,
        focusNode: _effectiveFocusNode,
        readOnly: false,
        keyboardType: TextInputType.datetime,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')), LengthLimitingTextInputFormatter(10), _AutoSlashFormatter()],
        onChanged: (value) => _validateDate(value),
        decoration: InputDecoration(
          label: Text(widget.text),
          suffixIcon: const Icon(Icons.calendar_today, size: 16),
          hintText: MyDateUtils.format,
          hintStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _isError ? Colors.red : Colors.grey, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _isError ? Colors.red : Theme.of(context).primaryColor, width: 2.0)),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _AutoSlashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    if (newValue.text.length == 2 || newValue.text.length == 5) {
      return TextEditingValue(
        text: '${newValue.text}/',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    }

    return newValue;
  }
}

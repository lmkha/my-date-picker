import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // You need this for DateFormat

class DateInput extends StatefulWidget {
  final String text;
  final DateTime? selectedDate;

  const DateInput({super.key, required this.text, this.selectedDate});

  @override
  State<StatefulWidget> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  // 1. Create the controller
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _updateText(); // Set initial value
  }

  // 2. CRITICAL: Update text if the parent changes the date
  @override
  void didUpdateWidget(DateInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _updateText();
    }
  }

  // Helper function to format date to String
  void _updateText() {
    if (widget.selectedDate != null) {
      // Format: dd/MM/yyyy
      String formatted = DateFormat('dd/MM/yyyy').format(widget.selectedDate!);
      _controller.text = formatted;
    } else {
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    // 3. Always dispose the controller to free memory
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: _controller, // <--- CONNECT CONTROLLER HERE
        readOnly:
            true, // Prevent manual typing (optional, good for date pickers)
        decoration: InputDecoration(
          label: Text(widget.text),
          border: const OutlineInputBorder(),
          // Add an icon to make it look nice
          suffixIcon: const Icon(Icons.calendar_today, size: 16),
        ),
      ),
    );
  }
}

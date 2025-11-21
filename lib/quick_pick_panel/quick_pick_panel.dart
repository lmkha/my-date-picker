import 'package:flutter/material.dart';

class QuickPickPanel extends StatefulWidget {
  final List<String> options = [
    'Today',
    'Yesterday',
    'This week',
    'Last week',
    'This month',
    'Last 7 days',
    'Last 14 days',
    'Last 30 days',
    'Custom',
  ];

  QuickPickPanel({super.key});

  @override
  State<StatefulWidget> createState() => _QuickPickPanelState();
}

class _QuickPickPanelState extends State<QuickPickPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      padding: EdgeInsetsGeometry.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2,
        children: List.generate(widget.options.length, (index) {
          return Expanded(
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
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
                widget.options[index],
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

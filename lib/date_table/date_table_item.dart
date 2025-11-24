import 'package:flutter/material.dart';
import 'package:my_date_picker/date_table/item_position.dart';

class DateTableItem extends StatelessWidget {
  final String? text;
  final VoidCallback? onClick;
  final ItemPosition position;

  const DateTableItem({super.key, this.text, this.onClick, required this.position});

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = Colors.white;
    Color? textColor;

    switch (position) {
      case ItemPosition.at:
        backgroundColor = Colors.blue[400];
        textColor = Colors.white;
        break;

      case ItemPosition.between:
        backgroundColor = Colors.grey[400];
        textColor = Colors.black;
        break;

      case ItemPosition.today:
        backgroundColor = Colors.blue[100];
        textColor = Colors.black;
        break;

      case ItemPosition.outside:
        backgroundColor = Colors.white;
        textColor = Colors.black;
        break;
    }

    return Visibility(
      visible: text != null,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: SizedBox(
        child: TextButton(
          onPressed: onClick,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.blue[300]),
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            text ?? '',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: textColor),
          ),
        ),
      ),
    );
  }
}

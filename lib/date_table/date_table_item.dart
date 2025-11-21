import 'package:flutter/material.dart';

class DateTableItem extends StatelessWidget {
  final String? text;
  final VoidCallback? onClick;
  final bool isSelected;

  const DateTableItem({
    super.key,
    this.text,
    this.onClick,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: SizedBox(
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.blue[300]),
            backgroundColor: WidgetStateProperty.all(
              isSelected ? Colors.blue : Colors.white,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            text ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

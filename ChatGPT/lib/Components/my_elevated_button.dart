import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.textColor,
    required this.leading,
    required this.backgroundColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Widget leading;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leading, // your icon widget
          const SizedBox(
              width: 8.0), // add some spacing between the icon and text
          Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

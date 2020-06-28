import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  final Color textColor;
  final Color buttonColor;

  CustomButton({
    @required this.text,
    @required this.width,
    @required this.onPressed,
    this.textColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
        color: buttonColor == null ? Colors.grey[200] : buttonColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: textColor == null
              ? Theme.of(context).textTheme.button
              : TextStyle(color: textColor),
        ),
      ),
    );
  }
}

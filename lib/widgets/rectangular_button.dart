import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final double width;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RectangularButton({
    Key key,
    this.width,
    this.text,
    this.buttonColor,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width ?? 0,
      child: RaisedButton(
        color: buttonColor,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

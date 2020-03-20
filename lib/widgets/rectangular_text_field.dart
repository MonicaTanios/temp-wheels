import 'package:flutter/material.dart';

class RectangularTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const RectangularTextField({
    Key key,
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidate: true,
      autocorrect: false,
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(16.0),
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        hintText: hintText,
        helperStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginOutlineButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color fillColor;
  final String btnText;
  final Function onTap;

  const LoginOutlineButton(
      {this.buttonColor,
      this.textColor,
      this.btnText,
      this.onTap,
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: buttonColor)),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          btnText,
          style: TextStyle(
              color: textColor, fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      color: fillColor,
    );
  }
}

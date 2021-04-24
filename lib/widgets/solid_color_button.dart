import 'package:flutter/material.dart';

class SolidColorButton extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final String btnText;
  final Function onTap;
  final bool isLoading;

  const SolidColorButton(
      {this.buttonColor,
      this.textColor,
      this.btnText,
      this.onTap,
      this.isLoading = false});

  @override
  _SolidColorButtonState createState() => _SolidColorButtonState();
}

class _SolidColorButtonState extends State<SolidColorButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      onPressed: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isLoading
                ? SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.btnText,
                style: TextStyle(
                    color: widget.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      color: widget.buttonColor,
    );
  }
}

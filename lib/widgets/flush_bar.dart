import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flushbar(
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.green.shade800, Colors.greenAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'This is a floating Flushbar',
      message: 'Lorem ipsum dolor sit amet',
    )..show(context);
    ;
  }
}

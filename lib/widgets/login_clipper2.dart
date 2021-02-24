import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginClipPainter2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    var controlPoint1 = Offset(150, size.height * 0.67);
    var controlPoint2 = Offset(size.width * 0.80, size.height * 1.13);
    var endPoint = Offset(size.width * 1.17, size.height * 0.85);
    // path.lineTo(size.width, height);

    print(size.width);

    path.moveTo(0, size.height);
    path.lineTo(0, size.height);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(width, 0);
    path.lineTo(0, 0);
    // path.lineTo(width * 0.4, 0);

    // var controlPoint = Offset(size.width * 0.2, size.height * 0.2);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

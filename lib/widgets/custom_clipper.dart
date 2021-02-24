import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    var controlPoint1 = Offset(10, size.height * 0.67);
    var controlPoint2 = Offset(size.width * 0.80, size.height * 1.13);
    var endPoint = Offset(size.width * 1.17, size.height * 0.85);
    // path.lineTo(size.width, height);

    print(size.width);

    path.moveTo(0, size.height / 1.35);
    path.lineTo(0, size.height * 0.75);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(width, 0);
    path.lineTo(width * 0.4, 0);

    // var controlPoint = Offset(size.width * 0.2, size.height * 0.2);

    var controlPoint3 = Offset(size.width * 0.2, size.height * 0.3);
    var controlPoint4 = Offset(size.width * 0.92, size.height * 0.2);
    var endPoint1 = Offset(size.width * 0.87, size.height * 0.5);

    path.cubicTo(controlPoint3.dx, controlPoint3.dy, controlPoint4.dx,
        controlPoint4.dy, endPoint1.dx, endPoint1.dy);

    var controlPoint5 = Offset(size.width * 0.75, size.height * 1);
    var controlPoint6 = Offset(size.width * 0.3, size.height * 0.2);
    var endPoint2 = Offset(0, size.height * 0.42);

    path.cubicTo(controlPoint5.dx, controlPoint5.dy, controlPoint6.dx,
        controlPoint6.dy, endPoint2.dx, endPoint2.dy);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

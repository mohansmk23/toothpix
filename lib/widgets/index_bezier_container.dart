import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toothpix/widgets/custom_clipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ToothPix',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Container(
            child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [themeData.accentColor, themeData.accentColor])),
          ),
        )),
        Positioned(
          right: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.8,
          top: MediaQuery.of(context).size.height * 0.7 / 2,
          child: Hero(
            tag: 'styletooth',
            child: Transform.rotate(
              angle: pi / 8,
              child: SvgPicture.asset(
                'assets/styletooth.svg',
                width: 50.0,
                height: 50.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        Positioned(
          left: 24.0,
          top: MediaQuery.of(context).size.height * 0.7 * 0.75 - 75,
          child: Transform.rotate(
            angle: pi / 8,
            child: SvgPicture.asset(
              'assets/teeth2.svg',
              width: 30.0,
              height: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Positioned(
          right: 24.0,
          top: 32.0,
          child: Hero(
            tag: 'bigtooth',
            child: Transform.rotate(
              angle: pi / .55,
              child: SvgPicture.asset(
                'assets/teeth.svg',
                width: 100.0,
                height: 100.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Positioned(
          right: 24.0,
          top: 160.0,
          child: Transform.rotate(
            angle: pi / 18,
            child: SvgPicture.asset(
              'assets/teeth2.svg',
              width: 30.0,
              height: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Positioned(
          bottom: 60.0,
          right: 75.0,
          child: Transform.rotate(
            angle: pi / 18,
            child: Image.asset(
              'assets/blob.gif',
              width: 50.0,
              height: 50.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Positioned(
          top: 36.0,
          right: 150.0,
          child: Transform.rotate(
            angle: pi / 18,
            child: Image.asset(
              'assets/blob.gif',
              width: 20.0,
              height: 20.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

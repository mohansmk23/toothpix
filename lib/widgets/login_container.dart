import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_clipper.dart';
import 'login_clipper2.dart';

class LoginBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                  child: ClipPath(
                clipper: LoginClipPainter2(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).accentColor,
                ),
              )),
              Container(
                  child: ClipPath(
                clipper: LoginClipPainter(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                ),
              )),
              Positioned(
                left: 24.0,
                top: 80.0,
                child: Hero(
                  tag: 'bigtooth',
                  child: Transform.rotate(
                    angle: pi / 5.0,
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
                right: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.9,
                top: MediaQuery.of(context).size.height * 0.23,
                child: Hero(
                  tag: 'styletooth',
                  child: Transform.rotate(
                    angle: -pi / 4,
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
                right: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.9,
                top: MediaQuery.of(context).size.height * 0.15,
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
              Positioned(
                right: 24.0,
                top: MediaQuery.of(context).size.height * 0.3,
                child: SvgPicture.asset(
                  'assets/blob.svg',
                  width: 30.0,
                  height: 30.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Positioned(
                left: 24.0,
                bottom: 80.0,
                child: SvgPicture.asset(
                  'assets/blob.svg',
                  width: 30.0,
                  height: 30.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Positioned(
                left: 80.0,
                bottom: 80.0,
                child: SvgPicture.asset(
                  'assets/blob.svg',
                  width: 80.0,
                  height: 80.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Back !',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

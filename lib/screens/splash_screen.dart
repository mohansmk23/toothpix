import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/screens/index_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashscreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/introvideo.mp4');

    _controller.addListener(() {});
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    Timer(
        Duration(seconds: 8),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IndexScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: VideoPlayer(_controller)),
              Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                height: MediaQuery.of(context).size.height * 0.2,
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 0.1),
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0x80006BFF), Color(0xff006BFF)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Image.asset(
                    'assets/logo_white.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Got A Cavity or Problem a Problem Brewing ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Let\'s Take a Look',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Image.asset(
                    'assets/introloader.gif',
                    width: 40.0,
                    height: 40.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

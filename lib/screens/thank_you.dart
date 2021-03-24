import 'dart:async';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/video.dart';
import 'package:toothpix/widgets/solid_color_button.dart';
import 'package:toothpix/widgets/video_thumbnail.dart';

class ThankYouScreen extends StatefulWidget {
  static const routeName = "/thankyou";
  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  bool isTextAnimationStarted = false;
  bool isIllusAnimationStarted = false;
  ConfettiController _poppercontroller;
  VideoResponse videoDetails;
  bool _isLoading = false;

  getVideoResponse() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    Map video = jsonDecode(pref.getString(videoDetailsObject));
    videoDetails = VideoResponse.fromJson(video);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _poppercontroller =
        ConfettiController(duration: const Duration(seconds: 2));

    getVideoResponse();

    Timer(Duration(seconds: 1), () {
      setState(() {
        isTextAnimationStarted = true;
      });

      Timer(Duration(milliseconds: 200), () {
        setState(() {
          isIllusAnimationStarted = true;
        });

        Timer(Duration(milliseconds: 800), () {
          _poppercontroller.play();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: isTextAnimationStarted ? 100 : 200.0,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInQuart,
                    opacity: isTextAnimationStarted ? 1.0 : 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Thank You !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.pacifico(
                              color: Theme.of(context).primaryColor,
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: isIllusAnimationStarted ? 180 : 200.0,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInQuart,
                    opacity: isIllusAnimationStarted ? 1.0 : 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Checkout your results after 24 hours',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              color: Colors.black45,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                    left: isIllusAnimationStarted ? 0 : -100,
                    top: 200,
                    duration: Duration(milliseconds: 600),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInQuart,
                      opacity: isIllusAnimationStarted ? 1.0 : 0.0,
                      child: SvgPicture.asset(
                        'assets/thankyou_man.svg',
                        height: 300,
                      ),
                    )),
                AnimatedPositioned(
                    right: isIllusAnimationStarted ? 0 : -100,
                    top: 200,
                    duration: Duration(milliseconds: 600),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInQuart,
                      opacity: isIllusAnimationStarted ? 1.0 : 0.0,
                      child: SvgPicture.asset(
                        'assets/thankyou_woman.svg',
                        height: 300,
                      ),
                    )),
                Positioned(
                  top: 100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ConfettiWidget(
                        confettiController: _poppercontroller,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        shouldLoop:
                            false, // start again as soon as the animation is finished
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple
                        ], // manually specify the colors to be used
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1000),
                  bottom: isIllusAnimationStarted ? 0 : -450.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 2.0),
                        child: Text(
                          'Dental Education',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: VideoThumbnail(
                            videoName: videoDetails.dentalHealth.title,
                            videoUrl: videoDetails.dentalHealth.url,
                            videoImg: videoDetails.dentalHealth.thumbnailImage,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SolidColorButton(
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            btnText: 'Go to Home',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

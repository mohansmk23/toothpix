import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/widgets/solid_color_button.dart';
import 'package:toothpix/widgets/video_thumbnail.dart';

class HowToScreen extends StatelessWidget {
  static const routeName = "/howto";

  final Function onGetStartedTap;

  const HowToScreen({this.onGetStartedTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              child: Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'How to Take a Pic ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 8.0,
                        top: 8.0,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, color: Colors.white)))
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'howtoillus',
                    child: SvgPicture.asset(
                      'assets/how_to.svg',
                      height: 170,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Step 1 : Choose better lighting position',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Step 2 : Widely open your mouth before capturing',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Step 3 : Take four pics of your teeth perfectly',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Step 4 : Refer video given below for visual representation',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 2.0),
                    child: Text(
                      'How to Take a pic your tooth?',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: VideoThumbnail(),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0)),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.white,
                child: SolidColorButton(
                  buttonColor: Theme.of(context).accentColor,
                  btnText: 'Get Started',
                  textColor: Colors.white,
                  onTap: onGetStartedTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

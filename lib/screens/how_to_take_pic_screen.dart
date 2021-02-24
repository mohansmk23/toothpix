import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HowToScreen extends StatefulWidget {
  static const routeName = "/howto";

  @override
  _HowToScreenState createState() => _HowToScreenState();
}

class _HowToScreenState extends State<HowToScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '9Qa2K1CC3Hw',
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        hideControls: true,
        loop: true,
        hideThumbnail: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to take a pic'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: 'howtoillus',
                        child: SvgPicture.asset(
                          'assets/how_to.svg',
                          height: 170,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          child: Text(
                            'How to Take Pic of your tooth ?  ',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0),
                          ),
                        ),
                        Divider(),
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
            Expanded(
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
          ],
        ),
      ),
    );
  }
}

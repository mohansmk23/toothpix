import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/screens/pic_upload_screen.dart';
import 'package:toothpix/screens/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'how_to_take_pic_screen.dart';
import 'package:toothpix/app/widget_constants.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

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
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: Colors.grey,
      tapScaffoldEnabled: true,
      colorTransitionScaffold: Colors.black54,
      offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.4),
      scale: IDOffset.horizontal(0.9),
      proportionalChildArea: true,
      borderRadius: 50,
      leftAnimationType: InnerDrawerAnimation.static,
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
        color: Colors.blueGrey,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color(0xff8d99ae), Color(0xff3d5a80)]),
      ),
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        print(val);
        print(direction == InnerDrawerDirection.start);
      },
      innerDrawerCallback: (a) => print(a),
      leftChild: Container(
        child: Stack(
          children: [],
        ),
      ),
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('ToothPix'),
          leading: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(FontAwesome.bars)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, PicUploadscreen.routeName);
          },
          label: Text('Take a pic'),
          icon: SvgPicture.asset(
            'assets/teeth_camera.svg',
            height: 24.0,
            width: 24.0,
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: neumorphicShadow,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).primaryColor
                  ]),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -32.0,
                        left: -32.0,
                        child: SvgPicture.asset(
                          'assets/blob.svg',
                          height: 150.0,
                          width: 24.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Positioned(
                        right: -32.0,
                        bottom: -32.0,
                        child: SvgPicture.asset(
                          'assets/blob.svg',
                          height: 150.0,
                          width: 24.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 75.0,
                              height: 75.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/man_avatar.svg',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'john doe',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.0),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Male , 25 Years',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
              child: Text(
                'How to Take Care of your tooth?',
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HowToScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 75.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: neumorphicShadow,
                        gradient: LinearGradient(
                            colors: [howToCard1stColor, howToCard2ndColor]),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -32.0,
                              left: -32.0,
                              child: SvgPicture.asset(
                                'assets/blob.svg',
                                height: 150.0,
                                width: 24.0,
                                color: howToCard1stColor,
                              ),
                            ),
                            Positioned(
                              right: -32.0,
                              bottom: -32.0,
                              child: SvgPicture.asset(
                                'assets/blob.svg',
                                height: 150.0,
                                width: 24.0,
                                color: howToCard1stColor,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 24.0),
                                child: Text(
                                  'How to Take a Good Pic ?',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'howtoillus',
                      child: SvgPicture.asset(
                        'assets/how_to.svg',
                        height: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.start);
  }
}

class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: neumorphicShadow,
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset('assets/video_thumb.jpg'),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0.0, -0.5),
                          end: Alignment(0.0, 1.0),
                          colors: [Color(0x80000000), Color(0xff000000)])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Dental Care Tips',
                      style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(VideoScreen.routeName);
                      },
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

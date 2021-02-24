import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/screens/how_to_take_pic_screen.dart';
import 'package:toothpix/screens/thank_you.dart';

import 'index_screen.dart';

class PicUploadscreen extends StatefulWidget {
  static const routeName = "/picuupload";
  @override
  _PicUploadscreenState createState() => _PicUploadscreenState();
}

class _PicUploadscreenState extends State<PicUploadscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload picture'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/mouth.jpg',
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          UploadOpenContainer(
                              cardColor: Color(0x80e85d04),
                              position: 0,
                              positionText: 'Upper Left'),
                          UploadOpenContainer(
                              cardColor: Color(0x8090e0ef),
                              position: 1,
                              positionText: 'Upper Right'),
                        ],
                      ),
                      Row(
                        children: [
                          UploadOpenContainer(
                              cardColor: Color(0x80fec89a),
                              position: 2,
                              positionText: 'Lower Left'),
                          UploadOpenContainer(
                              cardColor: Color(0x80bdb2ff),
                              position: 2,
                              positionText: 'Lower Right'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Having a doubts on Capturing Pics ? ',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HowToScreen.routeName);
                },
                child: Text(
                  'Have a Look Here',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: SolidColorButton(
                  buttonColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, ThankYouScreen.routeName);
                  },
                  btnText: 'Submit',
                ),
              )
            ],
          ),
        ));
  }
}

class UploadOpenContainer extends StatelessWidget {
  final Color cardColor;
  final String positionText;
  final int position;

  const UploadOpenContainer({this.cardColor, this.positionText, this.position});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          color: cardColor,
          child: OpenContainer(
            transitionType: ContainerTransitionType.fade,
            transitionDuration: Duration(milliseconds: 600),
            closedColor: cardColor,
            closedBuilder: (context, action) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesome.upload,
                    color: Colors.white,
                  ),
                  Text(
                    positionText,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              );
            },
            openBuilder: (BuildContext context,
                void Function({Object returnValue}) action) {
              return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          uploadPicHeaderColor1,
                          uploadPicHeaderColor2
                        ]),
                      ),
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
                            top: 32.0,
                            left: 200.0,
                            child: SvgPicture.asset(
                              'assets/blob.svg',
                              height: 45.0,
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesome.upload,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  'Upload $positionText Picture',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Sample Picture of how a good pic look like',
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/sample_teeth.jpg'),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SolidColorButton(
                          buttonColor: Theme.of(context).primaryColor,
                          btnText: 'Capture',
                          textColor: Colors.white,
                          onTap: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

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

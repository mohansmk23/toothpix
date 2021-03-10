import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/app/widget_constants.dart';

class HistoryDetailsDateCard extends StatelessWidget {
  final String uploadDate;
  final String recommendDate;

  const HistoryDetailsDateCard({this.uploadDate, this.recommendDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Date',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 12.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          uploadDate,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Review Date',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 12.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          recommendDate.isEmpty
                              ? 'Not Reviewed'
                              : recommendDate,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
    );
  }
}

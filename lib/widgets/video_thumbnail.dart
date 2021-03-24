import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/screens/video_screen.dart';

class VideoThumbnail extends StatelessWidget {
  final String videoName;
  final String videoUrl;
  final String videoImg;

  const VideoThumbnail({this.videoName, this.videoUrl, this.videoImg});

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
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  videoImg,
                  fit: BoxFit.fill,
                ),
              ),
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
                      videoName,
                      style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) => VideoScreen(
                                    videoId: videoUrl,
                                    videoName: videoName,
                                  )),
                        );
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

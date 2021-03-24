import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  static const routeName = "/video";
  final String videoId;
  final String videoName;

  const VideoScreen({this.videoId, this.videoName});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoId),
      flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          hideControls: false,
          loop: true,
          hideThumbnail: true),
    );
    Future<bool> _onWillPop() async {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return true;
      } else {
        print('dsgfdfdf');
        //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        _controller.toggleFullScreenMode();
      }

      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                title: Text(videoName),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: (Icon(
                      Icons.arrow_back,
                    ))),
              )
            : null,
        body: Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: false,
          ),
        ),
      ),
    );
  }
}

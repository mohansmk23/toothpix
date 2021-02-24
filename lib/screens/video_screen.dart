import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  static const routeName = "/video";

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '9Qa2K1CC3Hw',
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
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        _controller.toggleFullScreenMode();
      }

      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/response_models/Ml_detection_response.dart';

class QuickResults extends StatefulWidget {
  static const routeName = 'QuickResult';

  final List<String> response;

  const QuickResults({this.response});

  @override
  _QuickResultsState createState() => _QuickResultsState();
}

class _QuickResultsState extends State<QuickResults> {
  PredictionModel _predictionModel;
  PageController controller = PageController(
    viewportFraction: 0.9,
  );
  bool _isLoading = false;

  Future<void> getMLDetails() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> params = {"enquiryId": widget.response[0]};

    try {
      final response = await getDio().post(quickResult, data: params);

      _predictionModel = PredictionModel.fromJson(json.decode(response.data));

      final Map<String, dynamic> parsed = json.decode(response.data);

      if (_predictionModel.status == 'success') {
        print('ssdsd');
        //Navigator.pop(context, true);
      } else {
        print('fffff');
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('eeeee');
      Navigator.pop(context, true);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMLDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Instant Review'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Theme.of(context).primaryColor,
                  Colors.blue,
                ])),
            child: Stack(
              children: [
                Positioned(
                  top: 16.0,
                  left: -18.0,
                  child: SvgPicture.asset(
                    'assets/blob.svg',
                    width: 78.0,
                    height: 78.0,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: 32.0,
                  right: 8.0,
                  child: SvgPicture.asset(
                    'assets/blob.svg',
                    width: 78.0,
                    height: 78.0,
                    color: Colors.blue,
                  ),
                ),
                !_isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Hey !',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 32.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'See the instant review from our AI System. Our doctors will give their expert review in 24 hrs.',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 18.0,
                            ),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 28.0),
                          child: Row(
                            children: [
                              CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                'Scanning your results.',
                                style: GoogleFonts.sourceSansPro(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              child: PageView(
                controller: controller,
                children: [
                  QuickResultsItem(
                    imgUrl: _isLoading
                        ? widget.response[1]
                        : _predictionModel.responseImages[0].responseImage,
                    position: 'UL',
                    isLoading: _isLoading,
                    isDetected: _isLoading
                        ? true
                        : _predictionModel.responseImages[0].isDetected ==
                            'yes',
                  ),
                  QuickResultsItem(
                      imgUrl: _isLoading
                          ? widget.response[2]
                          : _predictionModel.responseImages[1].responseImage,
                      position: 'UR',
                      isLoading: _isLoading,
                      isDetected: _isLoading
                          ? true
                          : _predictionModel.responseImages[1].isDetected ==
                              'yes'),
                  QuickResultsItem(
                      imgUrl: _isLoading
                          ? widget.response[3]
                          : _predictionModel.responseImages[2].responseImage,
                      position: 'LL',
                      isLoading: _isLoading,
                      isDetected: _isLoading
                          ? true
                          : _predictionModel.responseImages[2].isDetected ==
                              'yes'),
                  QuickResultsItem(
                      imgUrl: _isLoading
                          ? widget.response[4]
                          : _predictionModel.responseImages[3].responseImage,
                      position: 'LR',
                      isLoading: _isLoading,
                      isDetected: _isLoading
                          ? true
                          : _predictionModel.responseImages[3].isDetected ==
                              'yes')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickResultsItem extends StatefulWidget {
  final String imgUrl;
  final String position;
  final bool isLoading;
  final bool isDetected;

  const QuickResultsItem(
      {this.imgUrl, this.position, this.isLoading, this.isDetected});

  @override
  _QuickResultsItemState createState() => _QuickResultsItemState();
}

class _QuickResultsItemState extends State<QuickResultsItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _animationStopped = false;
  String scanText = "Scan";
  bool scanning = false;

  @override
  void initState() {
    _animationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });

    animateScanAnimation(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.fill,
                )),
                Positioned(
                  top: 16.0,
                  right: 8.0,
                  child: ClipOval(
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.position,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.isDetected,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(24.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'No problem detected by our AI system',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.isLoading,
                  child: ImageScannerAnimation(
                    _animationStopped,
                    334,
                    animation: _animationController,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  ImageScannerAnimation(this.stopped, this.width,
      {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final scorePosition = (animation.value * 440) + 16;

    Color color1 = Color(0x5532CD32);
    Color color2 = Color(0x0032CD32);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x0032CD32);
      color2 = Color(0x5532CD32);
    }

    return new Positioned(
        bottom: scorePosition,
        left: 0.0,
        child: new Opacity(
            opacity: (stopped) ? 0.0 : 1.0,
            child: Container(
              height: 60.0,
              width: 700.0,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [color1, color2],
              )),
            )));
  }
}

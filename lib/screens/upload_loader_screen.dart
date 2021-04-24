import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/image_upload_model.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:toothpix/screens/thank_you.dart';

class UploadLoader extends StatefulWidget {
  final File upperLeft;
  final File upperRight;
  final File lowerLeft;
  final File lowerRight;
  const UploadLoader(
      {this.upperLeft, this.upperRight, this.lowerLeft, this.lowerRight});

  @override
  _UploadLoaderState createState() => _UploadLoaderState();
}

class _UploadLoaderState extends State<UploadLoader>
    with TickerProviderStateMixin {
  bool animationStart = false;
  bool _isLoading = false;
  bool uploadSuccess = false;
  bool uploadFailure = false;
  UploadImageResponse uploadImageResponse;

  AnimationController _uploadIconAnimationController;
  Animation _uploadIconAnimation;
  AnimationController _successIconAnimationController;
  Animation _successIconAnimation;

  @override
  dispose() {
    _uploadIconAnimationController.dispose();
    _successIconAnimationController.dispose(); // you need this
    super.dispose();
  }

  uploadAllImage() async {
    setState(() {
      _isLoading = true;
    });
    FormData formData = FormData.fromMap({
      "Top_Left": await MultipartFile.fromFile(widget.upperLeft.path,
          filename: "topleft.txt"),
      "Top_Right": await MultipartFile.fromFile(widget.upperRight.path,
          filename: "topright.txt"),
      "Bottom_Left": await MultipartFile.fromFile(widget.lowerLeft.path,
          filename: "bottomleft.txt"),
      "Bottom_Right": await MultipartFile.fromFile(widget.lowerRight.path,
          filename: "bottomright.txt")
    });
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final response = await getDio(key: preferences.getString(authkey))
          .post(uploadImage, data: formData);
      final Map<String, dynamic> parsed = json.decode(response.data);
      uploadImageResponse =
          UploadImageResponse.fromJson(json.decode(response.data));

      if (uploadImageResponse.status == 'success') {
        setState(() {
          uploadFailure = false;
          uploadSuccess = true;
          _isLoading = false;
        });
        _uploadIconAnimationController.stop();
        _successIconAnimationController.forward().whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ThankYouScreen(
                        response: uploadImageResponse,
                      )),
              ModalRoute.withName(Dashboard.routeName));
        });
      } else {
        setState(() {
          _isLoading = false;
          uploadSuccess = false;
          uploadFailure = true;
        });
        _uploadIconAnimationController.stop();
        _successIconAnimationController.forward().whenComplete(() {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
        uploadSuccess = false;
        uploadFailure = true;
      });
      _uploadIconAnimationController.stop();
      _successIconAnimationController.forward().whenComplete(() {
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    _uploadIconAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _uploadIconAnimation =
        Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0, -1.0))
            .animate(_uploadIconAnimationController);

    _successIconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _successIconAnimation =
        Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0, 0.0))
            .animate(_successIconAnimationController);

    //_animationController.forward().whenComplete(() {});

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        animationStart = true;
      });

      Timer(Duration(milliseconds: 300), () {
        setState(() {
          uploadAllImage();
          _uploadIconAnimationController.repeat();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: Theme.of(context).accentColor,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: animationStart ? height * 0.5 : 250.0,
              left: animationStart ? width * 0.5 : 60,
              child: AnimatedContainer(
                width: animationStart ? 0 : 100.0,
                height: animationStart ? 0 : 100.0,
                color: Colors.white,
                duration: Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: animationStart ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: Image.file(
                    widget.upperLeft,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: animationStart ? height * 0.5 : 250.0,
              right: animationStart ? width * 0.5 : 60,
              child: AnimatedContainer(
                width: animationStart ? 0 : 100.0,
                height: animationStart ? 0 : 100.0,
                color: Colors.white,
                duration: Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: animationStart ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: Image.file(
                    widget.upperRight,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: animationStart ? height * 0.5 : 250.0,
              left: animationStart ? width * 0.5 : 60,
              child: AnimatedContainer(
                width: animationStart ? 0 : 100.0,
                height: animationStart ? 0 : 100.0,
                color: Colors.white,
                duration: Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: animationStart ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: Image.file(
                    widget.lowerLeft,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: animationStart ? height * 0.5 : 250.0,
              right: animationStart ? width * 0.5 : 60,
              child: AnimatedContainer(
                width: animationStart ? 0 : 100.0,
                height: animationStart ? 0 : 100.0,
                color: Colors.white,
                duration: Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: animationStart ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: Image.file(
                    widget.lowerRight,
                  ),
                ),
              ),
            ),
            _isLoading
                ? Center(
                    child: SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            _isLoading
                ? Align(
                    alignment: Alignment(0.0, 0.5),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Uploading ...',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ))
                : SizedBox(),
            Center(
              child: ClipOval(
                child: AnimatedContainer(
                  width: _isLoading
                      ? 120.0
                      : uploadSuccess || uploadFailure
                          ? 150.0
                          : 0.0,
                  height: _isLoading
                      ? 120.0
                      : uploadSuccess || uploadFailure
                          ? 150.0
                          : 0.0,
                  duration: Duration(milliseconds: 300),
                  color: Colors.white,
                  child: SlideTransition(
                    position: uploadSuccess
                        ? _successIconAnimation
                        : _uploadIconAnimation,
                    child: Icon(
                      _isLoading
                          ? Icons.arrow_upward_sharp
                          : uploadSuccess
                              ? Icons.check
                              : uploadFailure
                                  ? Icons.warning_amber_rounded
                                  : Icons.warning_amber_rounded,
                      size: 48.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

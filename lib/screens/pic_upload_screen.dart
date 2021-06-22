import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/video.dart';
import 'package:toothpix/screens/how_to_take_pic_screen.dart';
import 'package:toothpix/screens/upload_loader_screen.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

class PicUploadscreen extends StatefulWidget {
  static const routeName = "/picuupload";
  @override
  _PicUploadscreenState createState() => _PicUploadscreenState();
}

class _PicUploadscreenState extends State<PicUploadscreen> {
  File upperLeftImage, upperRightImage, lowerLeftImage, lowerRightImage;
  bool _isLoading = false;
  VideoResponse videoResponse;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _uploadImages = false;

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<File> pickImage(int pos) async {
    File image;

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 5.0,
              bottom: 5.0,
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: const Text(
                    'Pick Image From',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    File pickedImage = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    image = await ImageCropper.cropImage(
                        sourcePath: pickedImage.path,
                        cropStyle: CropStyle.rectangle,
                        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
                    Navigator.pop(context);
                    setImage(pos, image);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.image,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    File pickedImage =
                        await ImagePicker.pickImage(source: ImageSource.camera);

                    image = await ImageCropper.cropImage(
                        sourcePath: pickedImage.path,
                        cropStyle: CropStyle.rectangle,
                        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
                    Navigator.pop(context);
                    setImage(pos, image);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.camera,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });

    return image;
  }

  setImage(int position, File image) {
    if (position == 0) {
      upperLeftImage = image;
    } else if (position == 1) {
      upperRightImage = image;
    } else if (position == 2) {
      lowerLeftImage = image;
    } else if (position == 3) {
      lowerRightImage = image;
    }

    setState(() {});
  }

  bool isAllImageCaptured() {
    if (upperLeftImage != null &&
        upperRightImage != null &&
        lowerLeftImage != null &&
        lowerRightImage != null) {
      return true;
    }
    return false;
  }

  getVideos() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> params = {};
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final response = await getDio(key: preferences.getString(authkey))
          .post(videoList, data: params);
      setState(() {
        _isLoading = false;
      });
      videoResponse = VideoResponse.fromJson(json.decode(response.data));
      if (videoResponse.status == 'success') {
        String videoDetails = jsonEncode(videoResponse);
        preferences.setString(videoDetailsObject, videoDetails);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return HowToScreen(
                onGetStartedTap: () => Navigator.pop(context),
                videoResponse: videoResponse,
              );
            });
      } else {
        _showSnackBar('Something Went Wrong');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Network Error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Take a ToothSnap'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
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
                                  positionText: 'Upper Left',
                                  onTap: () async {
                                    pickImage(0);
                                    setState(() {});
                                  },
                                  isImagePicked: upperLeftImage != null,
                                  imageFile: upperLeftImage,
                                ),
                                UploadOpenContainer(
                                  cardColor: Color(0x8090e0ef),
                                  position: 1,
                                  positionText: 'Upper Right',
                                  onTap: () async {
                                    pickImage(1);
                                    setState(() {});
                                  },
                                  isImagePicked: upperRightImage != null,
                                  imageFile: upperRightImage,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                UploadOpenContainer(
                                  cardColor: Color(0x80fec89a),
                                  position: 2,
                                  positionText: 'Lower Left',
                                  onTap: () async {
                                    lowerLeftImage = await pickImage(2);
                                    setState(() {});
                                  },
                                  isImagePicked: lowerLeftImage != null,
                                  imageFile: lowerLeftImage,
                                ),
                                UploadOpenContainer(
                                  cardColor: Color(0x80bdb2ff),
                                  position: 2,
                                  positionText: 'Lower Right',
                                  onTap: () async {
                                    lowerRightImage = await pickImage(3);
                                    setState(() {});
                                  },
                                  isImagePicked: lowerRightImage != null,
                                  imageFile: lowerRightImage,
                                ),
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
                        getVideos();
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
                        buttonColor: isAllImageCaptured()
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        textColor: Colors.white,
                        onTap: () async {
                          if (isAllImageCaptured()) {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.none) {
                              _showSnackBar('Check Your Network');
                            } else {
                              var dummy = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UploadLoader(
                                          upperLeft: upperLeftImage,
                                          upperRight: upperRightImage,
                                          lowerLeft: lowerLeftImage,
                                          lowerRight: lowerRightImage,
                                        )),
                              );
                            }
                            _showSnackBar('Something Went Wrong');
                          } else {
                            _showSnackBar('Please Capture All 4 images');
                          }
                        },
                        btnText: 'Get General Advise',
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
  final Function onTap;
  final bool isImagePicked;
  final File imageFile;

  const UploadOpenContainer(
      {this.cardColor,
      this.positionText,
      this.position,
      this.onTap,
      this.isImagePicked,
      this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: cardColor,
            child: isImagePicked
                ? Hero(tag: positionText, child: Image.file(imageFile))
                : Column(
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
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/app/widget_constants.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/screens/how_to_take_pic_screen.dart';

import 'history_screen.dart';
import 'index_screen.dart';
import 'pic_upload_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  String strFName = '', strLName = '', strAge = '', strGender = '';

  getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    strFName = preferences.getString(fName);
    strLName = preferences.getString(lName);
    strAge = preferences.getInt(age).toString();
    strGender = preferences.getString(gender);

    setState(() {});
  }

  @override
  void initState() {
    getUserDetails();
  }

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
      leftChild: _drawerWidget(),
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     Navigator.pushNamed(context, PicUploadscreen.routeName);
        //   },
        //   label: Text('Take a pic'),
        //   icon: SvgPicture.asset(
        //     'assets/teeth_camera.svg',
        //     height: 24.0,
        //     width: 24.0,
        //     color: Colors.white,
        //   ),
        // ),
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
                                  '$strFName $strLName',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.0),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  '$strGender , $strAge Years',
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
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return HowToScreen(
                        onGetStartedTap: () => Navigator.popAndPushNamed(
                            context, PicUploadscreen.routeName),
                      );
                    });
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
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 24.0),
                                child: Text(
                                  'Take a ToothPix',
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
                      child: Image.asset(
                        'assets/take_pic.png',
                        height: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HistoryScreen.routeName);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                child: Container(
                  height: 120.0,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 75.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: neumorphicShadow,
                          gradient: LinearGradient(colors: [
                            historyCard1stColor,
                            historyCard2ndColor
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
                                  color: historyCard1stColor,
                                ),
                              ),
                              Positioned(
                                right: -32.0,
                                bottom: -32.0,
                                child: SvgPicture.asset(
                                  'assets/blob.svg',
                                  height: 150.0,
                                  width: 24.0,
                                  color: historyCard2ndColor,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 24.0),
                                  child: Text(
                                    'History of ToothPix',
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
                      Positioned(
                        right: 8.0,
                        child: SvgPicture.asset(
                          'assets/history_illus.svg',
                          height: 120.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerWidget() {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Divider(
                color: Colors.white54,
              ),
              _navigationMenuItem(Icons.home, 'Home', () async {
                _toggle();
              }),
              Divider(
                color: Colors.white54,
              ),
              _navigationMenuItem(Icons.person, 'Profile', () async {
                _toggle();
              }),
              Divider(
                color: Colors.white54,
              ),
              _navigationMenuItem(Icons.camera, 'Take a ToothPix', () async {
                _toggle();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return HowToScreen(
                        onGetStartedTap: () => Navigator.popAndPushNamed(
                            context, PicUploadscreen.routeName),
                      );
                    });
              }),
              Divider(
                color: Colors.white54,
              ),
              _navigationMenuItem(Icons.history, 'History', () async {
                Navigator.pushNamed(context, HistoryScreen.routeName);
              }),
              Divider(
                color: Colors.white54,
              ),
              Spacer(),
              _navigationMenuItem(Icons.logout, 'Logout', () {
                _showLogoutAlertDialog(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  _showLogoutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Logout"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(context).pushNamedAndRemoveUntil(
            IndexScreen.routeName, (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert !"),
      content: Text("Are You sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _navigationMenuItem(IconData icon, String txt, Function onTapMenu) {
    return InkWell(
      onTap: onTapMenu,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          txt,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              decoration: TextDecoration.none),
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

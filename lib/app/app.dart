import 'package:flutter/material.dart';
import 'package:toothpix/app/theme.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:toothpix/screens/index_screen.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/screens/pic_upload_screen.dart';
import 'package:toothpix/screens/signup_screen.dart';
import 'package:toothpix/screens/splash_screen.dart';
import 'package:toothpix/screens/how_to_take_pic_screen.dart';
import 'package:toothpix/screens/thank_you.dart';
import 'package:toothpix/screens/video_screen.dart';

class ToothPixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: SplashScreen(),
        routes: {
          IndexScreen.routeName: (context) => IndexScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          Dashboard.routeName: (context) => Dashboard(),
          HowToScreen.routeName: (context) => HowToScreen(),
          PicUploadscreen.routeName: (context) => PicUploadscreen(),
          ThankYouScreen.routeName: (context) => ThankYouScreen(),
          VideoScreen.routeName: (context) => VideoScreen(),
        });
  }
}

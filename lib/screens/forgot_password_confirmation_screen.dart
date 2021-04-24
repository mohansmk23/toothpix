import 'package:flutter/material.dart';
import 'package:toothpix/widgets/login_outline_button.dart';

class ForgotPasswordConfirmation extends StatelessWidget {
  static const routeName = 'forgotcoponfirm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Theme.of(context).primaryColor,
            Color(0xff1A54F8)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/paperplane.gif',
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Email Sent !',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'We have sent you an email with password reset instruction. Please check your registered email id and follow the instruction given!',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: LoginOutlineButton(
                  buttonColor: Colors.white,
                  btnText: 'Try Logging in',
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toothpix/app/theme.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/screens/signup_screen.dart';
import 'package:toothpix/widgets/index_bezier_container.dart';

class IndexScreen extends StatefulWidget {
  static const routeName = "/indexscreen";

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //  Icon(FontAwesome.teeth)

                // BezierContainer(),
                Expanded(
                  child: SizedBox.expand(
                    child: BezierContainer(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome !',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                          'Got A Cavity or Problem a Problem Brewing ? Let\'s Take a Look',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 38.0,
                      ),
                      SolidColorButton(
                        buttonColor: Colors.white,
                        btnText: 'Log in',
                        textColor: Theme.of(context).primaryColor,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      LoginOutlineButton(
                        buttonColor: Colors.white,
                        btnText: 'Sign up',
                        textColor: Colors.white,
                        fillColor: Theme.of(context).primaryColor,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginOutlineButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color fillColor;
  final String btnText;
  final Function onTap;

  const LoginOutlineButton(
      {this.buttonColor,
      this.textColor,
      this.btnText,
      this.onTap,
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: buttonColor)),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          btnText,
          style: TextStyle(
              color: textColor, fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      color: fillColor,
    );
  }
}

class SolidColorButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String btnText;
  final Function onTap;

  const SolidColorButton(
      {this.buttonColor, this.textColor, this.btnText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          btnText,
          style: TextStyle(
              color: textColor, fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      color: buttonColor,
    );
  }
}

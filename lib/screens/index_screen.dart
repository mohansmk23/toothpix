import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/screens/signup_screen.dart';
import 'package:toothpix/widgets/login_outline_button.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

class IndexScreen extends StatefulWidget {
  static const routeName = "/indexscreen";

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen>
    with TickerProviderStateMixin {
  String assetName = 'assets/smilegif.gif';

  @override
  Widget build(BuildContext context) {
    GifController controller = GifController(vsync: this);
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
                    child: Image.asset(
                      assetName,
                      fit: BoxFit.fill,
                    ),
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
                      Text('Care for your smile? Let\'s take a look',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 38.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SolidColorButton(
                              buttonColor: Colors.white,
                              btnText: 'Log in',
                              textColor: Theme.of(context).primaryColor,
                              onTap: () async {
                                setState(() {
                                  assetName = 'assets/smileimg.jpg';
                                });

                                var dummy = await Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: LoginOutlineButton(
                              buttonColor: Colors.white,
                              btnText: 'Sign up',
                              textColor: Colors.white,
                              fillColor: Theme.of(context).primaryColor,
                              onTap: () {
                                setState(() {
                                  assetName = 'assets/smileimg.jpg';
                                });
                                Navigator.of(context)
                                    .pushNamed(SignUpScreen.routeName);
                              },
                            ),
                          ),
                        ],
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

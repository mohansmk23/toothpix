import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/widgets/login_container.dart';
import 'package:toothpix/widgets/signup_container.dart';

import 'index_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SignupBanner()),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoginFormField(
                  prefixIcon: FontAwesome5.user,
                  hint: 'First Name',
                  isPassword: false,
                ),
                SizedBox(
                  height: 22.0,
                ),
                LoginFormField(
                  prefixIcon: FontAwesome5.user,
                  hint: 'Last Name',
                  isPassword: false,
                ),
                SizedBox(
                  height: 22.0,
                ),
                Row(
                  children: [
                    ToggleButtons(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Male'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Female'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Others'),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      },
                      isSelected: isSelected,
                    ),
                    Spacer(),
                    Container(
                      width: 150.0,
                      child: LoginFormField(
                        prefixIcon: FontAwesome.calendar_o,
                        hint: 'Age',
                        isPassword: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.0,
                ),
                LoginFormField(
                  prefixIcon: FontAwesome.phone,
                  hint: 'Phone no',
                  isPassword: false,
                ),
                SizedBox(
                  height: 22.0,
                ),
                LoginFormField(
                  prefixIcon: FontAwesome.envelope_o,
                  hint: 'Email ID (Login Id)',
                  isPassword: false,
                ),
                SizedBox(
                  height: 22.0,
                ),
                LoginFormField(
                  prefixIcon: Icons.vpn_key_outlined,
                  hint: 'Password',
                  isPassword: false,
                ),
                SizedBox(
                  height: 22.0,
                ),
                LoginFormField(
                  prefixIcon: Icons.vpn_key_outlined,
                  hint: 'Confirm Password',
                  isPassword: true,
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SolidColorButton(
                    buttonColor: Theme.of(context).primaryColor,
                    btnText: 'Sign up',
                    textColor: Colors.white,
                    onTap: () {
                      // Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'or',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 2.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginOutlineButton(
                  buttonColor: Colors.grey,
                  btnText: 'Log in',
                  textColor: Colors.grey,
                  onTap: () {
                    // Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}

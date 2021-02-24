import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:toothpix/screens/signup_screen.dart';
import 'package:toothpix/widgets/login_container.dart';

import 'index_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginscreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: LoginBanner()),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoginFormField(
                    prefixIcon: FontAwesome.envelope_o,
                    hint: 'Email ID',
                    isPassword: false,
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  LoginFormField(
                    prefixIcon: Icons.vpn_key_outlined,
                    hint: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SolidColorButton(
                      buttonColor: Theme.of(context).primaryColor,
                      btnText: 'Log in',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).pushNamed(Dashboard.routeName);
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
                    btnText: 'Sign up',
                    textColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginFormField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;

  const LoginFormField({this.hint, this.prefixIcon, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          fillColor: Colors.grey,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: isPassword ? Icon(FontAwesome.eye) : null),
      obscureText: isPassword,
    );
  }
}

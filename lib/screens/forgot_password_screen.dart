import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

import 'forgot_password_confirmation_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = 'forgotpass';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Color(0xff1A54F8)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150.0),
                            bottomRight: Radius.circular(150.0))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SvgPicture.asset(
                          'assets/forgot_password_illus.svg',
                          height: 280.0,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Enter email id associated with your account.',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: LoginFormField(
                              hint: 'Email ID',
                              prefixIcon: Icons.email,
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter valid Email-ID';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: SolidColorButton(
                              buttonColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              isLoading: _isLoading,
                              btnText: _isLoading ? "Verifying" : 'Verify',
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  verifyEmail();
                                }

                                // Navigator.pushNamed(context,
                                // ForgotPasswordConfirmation.routeName);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  verifyEmail() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {
      "e-mailid": emailController.text,
    };

    try {
      final response = await getDio().post(forgot, data: params);
      final Map<String, dynamic> parsed = json.decode(response.data);

      if (parsed['status'] == 'success') {
        Navigator.pushReplacementNamed(
            context, ForgotPasswordConfirmation.routeName);
      } else {
        _showSnackBar(parsed['message']);
      }
    } catch (e) {}

    setState(() {
      _isLoading = false;
    });
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

class NewPasswordScreen extends StatefulWidget {
  static const routeName = 'newpassword';

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  setNewPassword() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> params = {
      "newPassword": passwordController.text,
      "confirmPassword": confirmPasswordController.text
    };
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final response = await getDio(key: preferences.getString(authkey))
          .post(newPassword, data: params);
      setState(() {
        _isLoading = false;
      });

      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed['status'] == 'success') {
        _showSnackBar('Password changed successfully');
        Navigator.pop(context);
      } else {
        _showSnackBar(parsed['message']);
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Theme.of(context).accentColor])),
          ),
          Positioned(
            bottom: 54.0,
            left: 18.0,
            child: SvgPicture.asset(
              'assets/blob.svg',
              width: 78.0,
              height: 78.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            bottom: 108.0,
            right: 18.0,
            child: SvgPicture.asset(
              'assets/blob.svg',
              width: 108.0,
              height: 118.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: 70.0,
            right: 18.0,
            child: SvgPicture.asset(
              'assets/blob.svg',
              width: 50.0,
              height: 40.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: 215.0,
            left: 18.0,
            child: SvgPicture.asset(
              'assets/blob.svg',
              width: 78.0,
              height: 78.0,
              color: Colors.lightBlue,
            ),
          ),
          Positioned(
            top: 230.0,
            right: 18.0,
            child: SvgPicture.asset(
              'assets/blob.svg',
              width: 50.0,
              height: 50.0,
              color: Colors.lightBlue,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Lets set your new',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'password !',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 32.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginFormField(
                                hint: 'Password',
                                isPassword: true,
                                prefixIcon: Icons.vpn_key_outlined,
                                controller: passwordController,
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Valid Password';
                                  } else if (value.length < 8) {
                                    return 'Password must be more than 8';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              LoginFormField(
                                hint: 'Confirm Password',
                                isConfirmPass: true,
                                prefixIcon: Icons.vpn_key_outlined,
                                controller: confirmPasswordController,
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Valid Password';
                                  } else if (value != passwordController.text) {
                                    return 'Password & confirm password not same';
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                            btnText: _isLoading
                                ? "Changing your Password"
                                : 'Submit',
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                setNewPassword();
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
          ),
        ],
      ),
    );
  }
}

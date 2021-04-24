import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/login_model.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:toothpix/screens/forgot_password_screen.dart';
import 'package:toothpix/screens/new_password_screen.dart';
import 'package:toothpix/screens/signup_screen.dart';
import 'package:toothpix/widgets/login_container.dart';
import 'package:toothpix/widgets/login_outline_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName, passWord;
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  LoginResponse loginResponse;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  loginUser(String userName, String password) async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {"e-mailid": userName, "password": password};

    try {
      final response = await getDio().post(loginRequest, data: params);
      loginResponse = LoginResponse.fromJson(json.decode(response.data));

      if (loginResponse.status == 'success') {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        if (loginResponse.isTempPassword == 'yes') {
          preferences.setString(authkey, loginResponse.authKey);
          Navigator.pushNamed(context, NewPasswordScreen.routeName);

          userNameController.text = '';
          passwordController.text = '';
        } else {
          preferences.setString(fName, loginResponse.firstName);
          preferences.setString(lName, loginResponse.lastName);
          preferences.setString(gender, loginResponse.gender);
          preferences.setInt(age, loginResponse.age);
          preferences.setString(phoneNo, loginResponse.mobileNumber);
          preferences.setString(emailId, loginResponse.emailId);
          preferences.setString(authkey, loginResponse.authKey);
          preferences.setString(profileImgUrl, loginResponse.profileUrl);
          preferences.setBool(isLoggedIn, true);

          Navigator.pushNamedAndRemoveUntil(
              context, Dashboard.routeName, (route) => false);
        }
      } else {
        _showSnackBar('Invalid Credentials');
      }
    } catch (e) {}

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: LoginBanner()),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoginFormField(
                        prefixIcon: FontAwesome.envelope_o,
                        hint: 'Email ID',
                        isPassword: false,
                        controller: userNameController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid Email ID';
                          } else {
                            userName = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 22.0,
                      ),
                      LoginFormField(
                        prefixIcon: Icons.vpn_key_outlined,
                        hint: 'Password',
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid Password';
                          } else {
                            passWord = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          userNameController.text = '';
                          passwordController.text = '';
                          Navigator.pushNamed(
                              context, ForgotPasswordScreen.routeName);
                        },
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            height: 40.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                loginUser(userName, passWord);
                              }
                              // Navigator.pushNamedAndRemoveUntil(context,
                              //     Dashboard.routeName, (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _isLoading
                                      ? SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                          ))
                                      : SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      _isLoading ? 'Signing in' : 'Sign in',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            color: Theme.of(context).accentColor,
                          )),
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
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class LoginFormField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final Function validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isAge;
  final bool isMobile;
  final bool isConfirmPass;

  const LoginFormField(
      {this.hint,
      this.prefixIcon,
      this.isPassword = false,
      this.validator,
      this.controller,
      this.isAge = false,
      this.isMobile = false,
      this.isConfirmPass = false,
      this.inputType});

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColor),
      keyboardType: widget.inputType,
      maxLength: widget.isAge
          ? 2
          : widget.isMobile
              ? 10
              : null,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          fillColor: Colors.grey,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            widget.prefixIcon,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null),
      obscureText: widget.isPassword
          ? !_passwordVisible
          : widget.isConfirmPass
              ? true
              : false,
      validator: widget.validator,
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/screens/dashboard_screen.dart';
import 'package:toothpix/screens/login_screen.dart';
import 'package:toothpix/widgets/login_outline_button.dart';
import 'package:toothpix/widgets/signup_container.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isSelected = [true, false, false];
  String selectedGender;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();
  TextEditingController emailIdController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {
      "first_name": fNameController.text,
      "last_name": lNameController.text,
      "gender": selectedGender,
      "age": ageController.text,
      "mobile_number": phoneNoController.text,
      "email_id": emailIdController.text,
      "password_hash": passwordController.text
    };

    try {
      final response = await getDio().post(registration, data: params);
      final Map<String, dynamic> parsed = json.decode(response.data);

      if (parsed['status'] == 'success') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(fName, fNameController.text);
        preferences.setString(lName, lNameController.text);
        preferences.setString(gender, selectedGender);
        preferences.setInt(age, int.parse(ageController.text));
        preferences.setString(phoneNo, phoneNoController.text);
        preferences.setString(emailId, emailIdController.text);
        preferences.setString(authkey, parsed["auth-key"]);
        preferences.setBool(isLoggedIn, true);

        Navigator.pushNamedAndRemoveUntil(
            context, Dashboard.routeName, (route) => false);
      } else {
        _showSnackBar(parsed['message']);
      }
    } catch (e) {}

    setState(() {
      _isLoading = false;
    });
  }

  String _getGender() {
    if (isSelected[0] == true) {
      return 'Male';
    } else if (isSelected[1] == true) {
      return 'Female';
    } else if (isSelected[2] == true) {
      return 'Others';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
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
                      controller: fNameController,
                      prefixIcon: FontAwesome5.user,
                      hint: 'First Name',
                      isPassword: false,
                      inputType: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Valid First Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    LoginFormField(
                      controller: lNameController,
                      prefixIcon: FontAwesome5.user,
                      hint: 'Last Name',
                      inputType: TextInputType.name,
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Valid Last Name';
                        }
                        return null;
                      },
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
                              for (int i = 0; i < isSelected.length; i++) {
                                if (i == index) {
                                  isSelected[i] = !isSelected[i];
                                } else {
                                  isSelected[i] = false;
                                }
                              }
                            });
                          },
                          isSelected: isSelected,
                        ),
                        Spacer(),
                        Container(
                          width: 150.0,
                          child: LoginFormField(
                            controller: ageController,
                            inputType: TextInputType.number,
                            prefixIcon: FontAwesome.calendar_o,
                            hint: 'Age',
                            isAge: true,
                            isPassword: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Valid Age';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    LoginFormField(
                      controller: phoneNoController,
                      prefixIcon: FontAwesome.phone,
                      hint: 'Phone no',
                      isMobile: true,
                      inputType: TextInputType.number,
                      isPassword: false,
                      validator: (value) {
                        if (value.length < 10) {
                          return 'Enter Valid Phone No';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    LoginFormField(
                      controller: emailIdController,
                      prefixIcon: FontAwesome.envelope_o,
                      hint: 'Email ID (Login Id)',
                      inputType: TextInputType.emailAddress,
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Valid Email ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    LoginFormField(
                      controller: passwordController,
                      prefixIcon: Icons.vpn_key_outlined,
                      hint: 'Password',
                      inputType: TextInputType.visiblePassword,
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Valid Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    LoginFormField(
                      controller: confirmPasswordController,
                      prefixIcon: Icons.vpn_key_outlined,
                      hint: 'Confirm Password',
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Valid Confirm Password';
                        } else if (value != confirmPasswordController.text) {
                          return 'Password & Confirm Password Not Matching';
                        }
                        return null;
                      },
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
                          print('test');

                          if (_formKey.currentState.validate()) {
                            if (isSelected.contains(true)) {
                              selectedGender = _getGender();
                              _registerUser();
                            } else {
                              _showSnackBar('Select valid gender');
                            }
                          }
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
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ))
                                  : SizedBox(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _isLoading ? 'Signing Up' : 'Sign Up',
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
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}

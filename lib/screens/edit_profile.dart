import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothpix/backend/api_urls.dart';
import 'package:toothpix/connection/connection.dart';
import 'package:toothpix/constants/sharedPrefKeys.dart';
import 'package:toothpix/response_models/login_model.dart';
import 'package:toothpix/widgets/login_outline_button.dart';
import 'package:toothpix/widgets/solid_color_button.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditable = false;
  final _formKey = GlobalKey<FormState>();
  List<bool> selectedGender = [false, false, false];

  String strFName = '',
      strLName = '',
      strAge = '',
      strGender = '',
      strMobile = '',
      strEmail = '',
      strProfileImg = '';
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController emailIdController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  LoginResponse loginResponse;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool isImagePicked = false;
  File _image;

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void open_gallery() async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 5.0,
              bottom: 5.0,
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: const Text(
                    'Pick Image From',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    _image = await ImageCropper.cropImage(
                        sourcePath: _image.path, cropStyle: CropStyle.circle);

                    if (_image != null) {
                      updateImage(_image);
                    }
                    Navigator.pop(context);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.image,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _image =
                        await ImagePicker.pickImage(source: ImageSource.camera);

                    _image = await ImageCropper.cropImage(
                        sourcePath: _image.path, cropStyle: CropStyle.circle);

                    if (_image != null) {
                      updateImage(_image);
                    }

                    Navigator.pop(context);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.camera,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void updateImage(File profileImage) async {
    setState(() {
      _isLoading = true;
    });

    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(profileImage.path,
          filename: 'image.jpg'),
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final response = await getDio(key: preferences.getString(authkey))
          .post(changeProfilePic, data: formData);

      final Map<String, dynamic> parsed = json.decode(response.data);

      if (parsed['status'] == 'success') {
        isImagePicked = true;

        strProfileImg = parsed['data'][0];
        preferences.setString(profileImgUrl, strProfileImg);
      } else {
        _showSnackBar('Something Went Wrong');
      }
    } catch (e) {
      _showSnackBar('Something Went Wrong');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void getProfileDetails() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    fNameController.text = strFName = preferences.getString(fName);
    lNameController.text = strLName = preferences.getString(lName);
    ageController.text = strAge = preferences.getInt(age).toString();
    mobileNoController.text = strMobile = preferences.getString(phoneNo);
    emailIdController.text = strEmail = preferences.getString(emailId);
    strProfileImg = preferences.getString(profileImgUrl);
    strGender = preferences.getString(gender);
    setGender(strGender);

    if (strProfileImg.isNotEmpty) {
      isImagePicked = true;
    } else {
      isImagePicked = false;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void updateUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {
      "first_name": fNameController.text,
      "last_name": lNameController.text,
      "gender": _getGender(),
      "age": ageController.text,
      "mobile_number": mobileNoController.text,
      "email_id": emailIdController.text,
    };
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final response = await getDio(key: preferences.getString(authkey))
          .post(editProfile, data: params);
      loginResponse = LoginResponse.fromJson(json.decode(response.data));
      if (loginResponse.status == 'success') {
        preferences.setString(fName, fNameController.text);
        preferences.setString(lName, lNameController.text);
        preferences.setString(gender, _getGender());
        preferences.setInt(age, int.parse(ageController.text));
        preferences.setString(phoneNo, mobileNoController.text);
        preferences.setString(emailId, emailIdController.text);
        strFName = fNameController.text;
        strLName = lNameController.text;
        strAge = ageController.text;
        strMobile = mobileNoController.text;
        strEmail = emailIdController.text;
        strGender = _getGender();

        toggleEditing();
      } else {
        _showSnackBar('Something Went Wrong');
      }
    } catch (e) {
      _showSnackBar('Something Went Wrong');
    }

    setState(() {
      _isLoading = false;
    });
  }

  String _getGender() {
    if (selectedGender[0] == true) {
      return 'Male';
    } else if (selectedGender[1] == true) {
      return 'Female';
    } else if (selectedGender[2] == true) {
      return 'Others';
    }
    return null;
  }

  void setGender(String gender) {
    if (gender == 'Male') {
      selectedGender = [true, false, false];
    } else if (gender == 'Female') {
      selectedGender = [false, true, false];
    } else if (gender == 'Others') {
      selectedGender = [false, false, true];
    }

    print('changed');
    setState(() {});
  }

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  void toggleEditing() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      floatingActionButton: isEditable
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                toggleEditing();
              },
              label: Text('Edit'),
              icon: Icon(Icons.edit),
            ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                width: 150.0,
                                height: 150.0,
                                child: ClipOval(
                                    child: isImagePicked
                                        ? Image.network(
                                            strProfileImg,
                                            fit: BoxFit.cover,
                                          )
                                        : SvgPicture.asset(
                                            'assets/man_avatar.svg')),
                              ),
                            ),
                            Positioned(
                                bottom: 16.0,
                                right: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    open_gallery();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.add_a_photo_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  ProfileEditField(
                    label: 'First Name',
                    isEnabled: isEditable,
                    controller: fNameController,
                    keyBoardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Valid First Name';
                      }
                      return null;
                    },
                  ),
                  ProfileEditField(
                    label: 'Last Name',
                    isEnabled: isEditable,
                    controller: lNameController,
                    keyBoardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Valid Last Name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GenderSelector(
                          label: 'Male',
                          icon: Icon(
                            FontAwesome.mars,
                            color: Colors.blue,
                          ),
                          isSelected: selectedGender[0],
                          onTap: () => isEditable ? setGender('Male') : null,
                        ),
                        GenderSelector(
                          label: 'Female',
                          icon: Icon(
                            FontAwesome.venus,
                            color: Colors.pink,
                          ),
                          isSelected: selectedGender[1],
                          onTap: () => isEditable ? setGender('Female') : null,
                        ),
                        GenderSelector(
                          label: 'Others',
                          icon: Icon(
                            FontAwesome.transgender,
                            color: Colors.green,
                          ),
                          isSelected: selectedGender[2],
                          onTap: () => isEditable ? setGender('Others') : null,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: ProfileEditField(
                          label: 'Mobile Number',
                          isEnabled: isEditable,
                          controller: mobileNoController,
                          keyBoardType: TextInputType.number,
                          validator: (value) {
                            if (value.length < 10) {
                              return 'Enter Valid Mobile Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ProfileEditField(
                          label: 'Age',
                          isEnabled: isEditable,
                          controller: ageController,
                          keyBoardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid First Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  ProfileEditField(
                    label: 'Email',
                    isEnabled: isEditable,
                    controller: emailIdController,
                    keyBoardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Valid Email ID';
                      }
                      return null;
                    },
                  ),
                  isEditable
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SolidColorButton(
                                  buttonColor: Theme.of(context).primaryColor,
                                  btnText: 'Update',
                                  textColor: Colors.white,
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (selectedGender.contains(true)) {
                                        updateUserDetails();
                                      } else {
                                        _showSnackBar(
                                            'Please select Valid Gender');
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: LoginOutlineButton(
                                  buttonColor: Theme.of(context).primaryColor,
                                  btnText: 'Cancel',
                                  textColor: Theme.of(context).primaryColor,
                                  fillColor: Colors.white,
                                  onTap: () {
                                    fNameController.text = strFName;
                                    lNameController.text = strLName;
                                    ageController.text = strAge;
                                    mobileNoController.text = strMobile;
                                    emailIdController.text = strEmail;
                                    setGender(strGender);

                                    toggleEditing();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
    );
  }
}

class ProfileEditField extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final Function validator;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final bool isAge;
  final bool isMobile;

  ProfileEditField(
      {this.label,
      this.isEnabled,
      this.validator,
      this.controller,
      this.keyBoardType,
      this.isAge = false,
      this.isMobile = false});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.sourceSansPro(
                color: Colors.blueGrey,
                fontSize: 18.0,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
            enabled: isEnabled,
            controller: controller,
            keyboardType: keyBoardType,
            decoration: InputDecoration(
              fillColor: Colors.grey[300],
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: new BorderSide(color: Colors.blue)),
              filled: true,
            ),
            validator: validator,
          )
        ],
      ),
    );
  }
}

class GenderSelector extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool isSelected;
  final Function onTap;

  const GenderSelector({this.label, this.icon, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: isSelected ? Colors.blue[100] : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Row(
                children: [
                  icon,
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    label,
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.blueGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

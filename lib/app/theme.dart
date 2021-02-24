import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
    );
  }

  static const _primaryColor = Color(0xff006BFF);
  static const _accentColor = Color(0xff1A54F8);
}
